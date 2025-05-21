import React, { useState } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const WACCSensitivityAnalysis = () => {
  // Default values from Primavero Plc example
  const [costOfEquity, setCostOfEquity] = useState(0.16);
  const [costOfDebt, setCostOfDebt] = useState(0.125);
  const [taxRate, setTaxRate] = useState(0.20);
  
  // Calculate after-tax cost of debt
  const afterTaxCostOfDebt = costOfDebt * (1 - taxRate);
  
  // Generate data for different debt percentages
  const generateData = () => {
    const data = [];
    for (let debtPercentage = 0; debtPercentage <= 100; debtPercentage += 5) {
      const equityPercentage = 100 - debtPercentage;
      const wacc = (equityPercentage / 100) * costOfEquity + (debtPercentage / 100) * afterTaxCostOfDebt;
      data.push({
        debtPercentage: debtPercentage,
        wacc: wacc,
      });
    }
    return data;
  };
  
  const data = generateData();
  
  // Find the minimum WACC value and corresponding debt percentage
  const minWACC = Math.min(...data.map(item => item.wacc));
  const optimalDebtPercentage = data.find(item => item.wacc === minWACC).debtPercentage;
  
  // Custom tooltip
  const CustomTooltip = ({ active, payload }) => {
    if (active && payload && payload.length) {
      return (
        <div className="bg-white p-3 border border-gray-300 rounded shadow-md">
          <p className="font-semibold">Debt: {payload[0].payload.debtPercentage}%</p>
          <p>Equity: {100 - payload[0].payload.debtPercentage}%</p>
          <p>WACC: {(payload[0].payload.wacc * 100).toFixed(2)}%</p>
        </div>
      );
    }
    return null;
  };
  
  // Handle input changes
  const handleCostOfEquityChange = (e) => {
    const value = parseFloat(e.target.value) / 100;
    setCostOfEquity(value);
  };
  
  const handleCostOfDebtChange = (e) => {
    const value = parseFloat(e.target.value) / 100;
    setCostOfDebt(value);
  };
  
  const handleTaxRateChange = (e) => {
    const value = parseFloat(e.target.value) / 100;
    setTaxRate(value);
  };

  return (
    <div className="w-full">
      <h2 className="text-xl font-bold mb-4 text-center">WACC Sensitivity to Capital Structure</h2>
      
      <div className="mb-6 p-4 border border-gray-200 rounded bg-gray-50">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Cost of Equity (Ke)
            </label>
            <div className="flex">
              <input
                type="number"
                min="0"
                max="50"
                value={costOfEquity * 100}
                onChange={handleCostOfEquityChange}
                className="border border-gray-300 rounded p-2 w-full"
              />
              <span className="ml-2 flex items-center">%</span>
            </div>
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Cost of Debt (Kd)
            </label>
            <div className="flex">
              <input
                type="number"
                min="0"
                max="30"
                value={costOfDebt * 100}
                onChange={handleCostOfDebtChange}
                className="border border-gray-300 rounded p-2 w-full"
              />
              <span className="ml-2 flex items-center">%</span>
            </div>
          </div>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Tax Rate (t)
            </label>
            <div className="flex">
              <input
                type="number"
                min="0"
                max="50"
                value={taxRate * 100}
                onChange={handleTaxRateChange}
                className="border border-gray-300 rounded p-2 w-full"
              />
              <span className="ml-2 flex items-center">%</span>
            </div>
          </div>
        </div>
        
        <div className="mt-4 grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <p className="text-sm font-medium text-gray-700">After-tax Cost of Debt: 
              <span className="ml-1 font-bold">{(afterTaxCostOfDebt * 100).toFixed(2)}%</span>
            </p>
          </div>
          <div>
            <p className="text-sm font-medium text-gray-700">Optimal Debt Percentage: 
              <span className="ml-1 font-bold">{optimalDebtPercentage}%</span> 
              (Minimum WACC: <span className="font-bold">{(minWACC * 100).toFixed(2)}%</span>)
            </p>
          </div>
        </div>
      </div>
      
      <div className="h-64 md:h-80">
        <ResponsiveContainer width="100%" height="100%">
          <LineChart data={data} margin={{ top: 20, right: 30, left: 20, bottom: 20 }}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis 
              dataKey="debtPercentage" 
              type="number" 
              domain={[0, 100]} 
              label={{ value: 'Debt Percentage (%)', position: 'bottom', offset: 0 }} 
            />
            <YAxis 
              tickFormatter={(value) => `${(value * 100).toFixed(0)}%`}
              domain={['dataMin', 'dataMax']} 
              label={{ value: 'WACC (%)', angle: -90, position: 'left' }} 
            />
            <Tooltip content={<CustomTooltip />} />
            <Legend />
            <Line 
              type="monotone" 
              dataKey="wacc" 
              stroke="#2563eb" 
              activeDot={{ r: 8 }} 
              name="WACC"
            />
          </LineChart>
        </ResponsiveContainer>
      </div>
      
      <div className="mt-6 p-4 border border-gray-300 rounded bg-gray-50">
        <h3 className="font-bold mb-2">Key insights from this analysis:</h3>
        <ul className="list-disc ml-5 space-y-1">
          <li>When the after-tax cost of debt is lower than the cost of equity, increasing debt proportion initially decreases WACC</li>
          <li>Traditional finance theory suggests an optimal capital structure exists that minimizes WACC</li>
          <li>According to Modigliani & Miller, in perfect capital markets (no taxes, bankruptcy costs, agency costs), WACC would be constant regardless of capital structure</li>
          <li>In the real world, factors like tax shields from debt and bankruptcy risk create a trade-off</li>
          <li>Based on your inputs, the optimal debt percentage is {optimalDebtPercentage}%, but in practice, companies typically maintain some financial flexibility</li>
        </ul>
      </div>
    </div>
  );
};

export default WACCSensitivityAnalysis;
