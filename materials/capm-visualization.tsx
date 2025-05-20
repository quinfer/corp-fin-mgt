import React from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const CAPMVisualization = () => {
  // Sample data showing how Cost of Equity changes with different Beta values
  // Based on Example 1: M plc with risk-free rate of 3% and market risk premium of 5%
  const data = [
    { beta: 0.0, costOfEquity: 0.03 },
    { beta: 0.5, costOfEquity: 0.055 },
    { beta: 1.0, costOfEquity: 0.08 },
    { beta: 1.2, costOfEquity: 0.09 },
    { beta: 1.5, costOfEquity: 0.105 },
    { beta: 2.0, costOfEquity: 0.13 },
    { beta: 2.5, costOfEquity: 0.155 },
  ];
  
  // Calculate values for Security Market Line
  const riskFreeRate = 0.03;
  const marketRiskPremium = 0.05;
  const smlData = [
    { beta: 0, costOfEquity: riskFreeRate },
    { beta: 3, costOfEquity: riskFreeRate + 3 * marketRiskPremium }
  ];

  // Display data points for companies from examples
  const companyData = [
    { beta: 1.2, costOfEquity: 0.09, name: 'M plc' },
    { beta: 1.5, costOfEquity: 0.17, name: 'L plc' },
    { beta: 2.0, costOfEquity: 0.25, name: 'N plc' },
  ];

  // Custom tooltip to show values as percentages
  const CustomTooltip = ({ active, payload }) => {
    if (active && payload && payload.length) {
      return (
        <div className="bg-white p-2 border border-gray-300 rounded shadow-md">
          <p className="font-semibold">Beta: {payload[0].payload.beta}</p>
          <p>Cost of Equity: {(payload[0].payload.costOfEquity * 100).toFixed(2)}%</p>
          {payload[0].payload.name && <p>Company: {payload[0].payload.name}</p>}
        </div>
      );
    }
    return null;
  };

  return (
    <div className="w-full">
      <h2 className="text-xl font-bold mb-4 text-center">Capital Asset Pricing Model (CAPM) Visualization</h2>
      <div className="flex flex-col items-center">
        <div className="w-full h-64 md:h-80">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart margin={{ top: 20, right: 30, left: 20, bottom: 20 }}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis 
                dataKey="beta" 
                type="number" 
                domain={[0, 3]} 
                label={{ value: 'Beta (β)', position: 'bottom', offset: 0 }} 
              />
              <YAxis 
                tickFormatter={(value) => `${(value * 100).toFixed(0)}%`}
                domain={[0, 0.2]} 
                label={{ value: 'Cost of Equity (Ke)', angle: -90, position: 'left' }} 
              />
              <Tooltip content={<CustomTooltip />} />
              <Legend />
              
              {/* Security Market Line */}
              <Line 
                data={smlData} 
                type="linear" 
                dataKey="costOfEquity" 
                stroke="#2563eb" 
                name="Security Market Line"
                strokeWidth={2}
                dot={false}
              />
              
              {/* Data points for companies */}
              <Line 
                data={companyData} 
                type="monotone" 
                dataKey="costOfEquity" 
                stroke="#dc2626" 
                name="Example Companies" 
                dot={{ r: 6 }}
                activeDot={{ r: 8 }}
                legendType="square"
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
        
        <div className="mt-6 p-4 border border-gray-300 rounded bg-gray-50 w-full max-w-xl">
          <h3 className="font-bold mb-2">Key CAPM Concepts</h3>
          <ul className="list-disc ml-5 space-y-2">
            <li><strong>Risk-free rate (rf):</strong> 3% (government bond yield)</li>
            <li><strong>Market risk premium (rm - rf):</strong> 5% (expected market return above risk-free rate)</li>
            <li><strong>Security Market Line:</strong> Shows relationship between systematic risk (β) and required return</li>
            <li><strong>β = 1:</strong> Same systematic risk as the market, requiring 8% return</li>
            <li><strong>β &gt; 1:</strong> Higher systematic risk than the market (e.g., tech companies, startups)</li>
            <li><strong>β &lt; 1:</strong> Lower systematic risk than the market (e.g., utilities, consumer staples)</li>
          </ul>
        </div>
      </div>
    </div>
  );
};

export default CAPMVisualization;
