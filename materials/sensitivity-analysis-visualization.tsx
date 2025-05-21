import React, { useState } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, ReferenceLine } from 'recharts';

const SensitivityAnalysisVisualization = () => {
  // Default values based on the plumbing business example
  const [baselineNPV, setBaselineNPV] = useState(55980);
  const [initialInvestment, setInitialInvestment] = useState(45000);
  const [annualCashFlows, setAnnualCashFlows] = useState([12000, 18000, 22000, 25000, 67000]);
  const [discountRate, setDiscountRate] = useState(10);
  
  // Calculate NPV with modified parameters
  const calculateNPV = (modifiedInvestment, modifiedCashFlows, modifiedRate) => {
    const rate = modifiedRate / 100;
    let npv = -modifiedInvestment;
    
    for (let i = 0; i < modifiedCashFlows.length; i++) {
      npv += modifiedCashFlows[i] / Math.pow(1 + rate, i + 1);
    }
    
    return Math.round(npv);
  };
  
  // Calculate percentage change required for NPV to become zero
  const calculateSwitchingPoint = (parameter) => {
    let lowerChange = -100;
    let upperChange = 500;
    let currentChange = (lowerChange + upperChange) / 2;
    let currentNPV = 0;
    
    // Use binary search to find the percentage change where NPV = 0
    for (let i = 0; i < 25; i++) { // 25 iterations for precision
      if (parameter === 'investment') {
        const modifiedInvestment = initialInvestment * (1 + currentChange / 100);
        currentNPV = calculateNPV(modifiedInvestment, annualCashFlows, discountRate);
      } else if (parameter === 'cashFlows') {
        const modifiedCashFlows = annualCashFlows.map(cf => cf * (1 + currentChange / 100));
        currentNPV = calculateNPV(initialInvestment, modifiedCashFlows, discountRate);
      } else if (parameter === 'discountRate') {
        const modifiedRate = discountRate + currentChange;
        currentNPV = calculateNPV(initialInvestment, annualCashFlows, modifiedRate);
      }
      
      if (Math.abs(currentNPV) < 10) {
        break;
      }
      
      if (currentNPV > 0) {
        if (parameter === 'investment') {
          lowerChange = currentChange;
        } else if (parameter === 'cashFlows') {
          upperChange = currentChange;
        } else if (parameter === 'discountRate') {
          lowerChange = currentChange;
        }
      } else {
        if (parameter === 'investment') {
          upperChange = currentChange;
        } else if (parameter === 'cashFlows') {
          lowerChange = currentChange;
        } else if (parameter === 'discountRate') {
          upperChange = currentChange;
        }
      }
      
      currentChange = (lowerChange + upperChange) / 2;
    }
    
    return Math.round(currentChange * 100) / 100;
  };
  
  // Calculate switching points
  const investmentSwitchingPoint = calculateSwitchingPoint('investment');
  const cashFlowsSwitchingPoint = calculateSwitchingPoint('cashFlows');
  const discountRateSwitchingPoint = calculateSwitchingPoint('discountRate');
  
  // Generate data for sensitivity chart
  const generateSensitivityData = () => {
    // Generate data points for +/- percentage changes
    const percentageChanges = [-20, -10, -5, 0, 5, 10, 20];
    
    const investmentData = percentageChanges.map(change => {
      const modifiedInvestment = initialInvestment * (1 + change / 100);
      return {
        change,
        npv: calculateNPV(modifiedInvestment, annualCashFlows, discountRate)
      };
    });
    
    const cashFlowsData = percentageChanges.map(change => {
      const modifiedCashFlows = annualCashFlows.map(cf => cf * (1 + change / 100));
      return {
        change,
        npv: calculateNPV(initialInvestment, modifiedCashFlows, discountRate)
      };
    });
    
    const discountRateData = percentageChanges.map(change => {
      const modifiedRate = discountRate * (1 + change / 100);
      return {
        change,
        npv: calculateNPV(initialInvestment, annualCashFlows, modifiedRate)
      };
    });
    
    return {
      investmentData,
      cashFlowsData,
      discountRateData
    };
  };
  
  const sensitivityData = generateSensitivityData();
  
  // Data for tornado chart
  const tornadoData = [
    {
      name: 'Initial Investment',
      positive: calculateNPV(initialInvestment * 0.9, annualCashFlows, discountRate) - baselineNPV,
      negative: calculateNPV(initialInvestment * 1.1, annualCashFlows, discountRate) - baselineNPV,
      switchingPoint: investmentSwitchingPoint
    },
    {
      name: 'Annual Cash Flows',
      positive: calculateNPV(initialInvestment, annualCashFlows.map(cf => cf * 1.1), discountRate) - baselineNPV,
      negative: calculateNPV(initialInvestment, annualCashFlows.map(cf => cf * 0.9), discountRate) - baselineNPV,
      switchingPoint: cashFlowsSwitchingPoint
    },
    {
      name: 'Discount Rate',
      positive: calculateNPV(initialInvestment, annualCashFlows, discountRate * 0.9) - baselineNPV,
      negative: calculateNPV(initialInvestment, annualCashFlows, discountRate * 1.1) - baselineNPV,
      switchingPoint: discountRateSwitchingPoint
    }
  ];
  
  // Scenario analysis data
  const scenarios = [
    {
      name: 'Pessimistic',
      probability: 25,
      growth: 5,
      exitMultiple: 1.0,
      npv: 3250,
      irr: 12.1
    },
    {
      name: 'Most Likely',
      probability: 50,
      growth: 10,
      exitMultiple: 1.5,
      npv: 22977,
      irr: 23.9
    },
    {
      name: 'Optimistic',
      probability: 25,
      growth: 15, 
      exitMultiple: 2.0,
      npv: 48350,
      irr: 36.2
    }
  ];
  
  // Calculate expected NPV
  const expectedNPV = scenarios.reduce((sum, scenario) => sum + (scenario.npv * scenario.probability / 100), 0);
  
  const CustomTooltip = ({ active, payload }) => {
    if (active && payload && payload.length) {
      const data = payload[0].payload;
      return (
        <div className="bg-white p-3 border border-gray-300 rounded shadow-md">
          <p className="font-semibold">{data.name}</p>
          <p>NPV Impact (±10%):</p>
          <p className="text-green-600">+10%: £{data.positive.toFixed(0)}</p>
          <p className="text-red-600">-10%: £{data.negative.toFixed(0)}</p>
          <p className="font-bold mt-1">Switching Point: {data.switchingPoint}%</p>
          <p className="text-xs text-gray-500 mt-1">
            Interpretation: {
              Math.abs(data.switchingPoint) > 50 
                ? 'Low sensitivity (robust)' 
                : Math.abs(data.switchingPoint) > 20 
                  ? 'Medium sensitivity' 
                  : 'High sensitivity (risky)'
            }
          </p>
        </div>
      );
    }
    return null;
  };

  return (
    <div className="w-full">
      <h2 className="text-xl font-bold mb-4 text-center">Risk Analysis in Investment Decisions</h2>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="p-4 border border-gray-200 rounded bg-gray-50">
          <h3 className="font-bold text-lg mb-2">Sensitivity Analysis: Tornado Chart</h3>
          <p className="text-sm mb-4">This chart shows how ±10% changes in key variables affect the NPV.</p>
          
          <div className="h-64">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart
                layout="vertical"
                data={tornadoData}
                margin={{ top: 20, right: 30, left: 20, bottom: 5 }}
              >
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis type="number" />
                <YAxis type="category" dataKey="name" />
                <Tooltip content={<CustomTooltip />} />
                <Legend />
                <ReferenceLine x={0} stroke="#000" />
                <Bar dataKey="positive" fill="#4ade80" name="+10% Change" />
                <Bar dataKey="negative" fill="#f87171" name="-10% Change" />
              </BarChart>
            </ResponsiveContainer>
          </div>
          
          <div className="mt-4">
            <h4 className="font-semibold">Switching Points (% change for NPV = 0):</h4>
            <ul className="list-disc ml-5 space-y-1 mt-2">
              <li>Initial Investment: <span className={`font-bold ${Math.abs(investmentSwitchingPoint) > 50 ? 'text-green-600' : 'text-red-600'}`}>{investmentSwitchingPoint}%</span></li>
              <li>Annual Cash Flows: <span className={`font-bold ${Math.abs(cashFlowsSwitchingPoint) > 50 ? 'text-green-600' : 'text-red-600'}`}>{cashFlowsSwitchingPoint}%</span></li>
              <li>Discount Rate: <span className={`font-bold ${Math.abs(discountRateSwitchingPoint) > 20 ? 'text-green-600' : 'text-red-600'}`}>{discountRateSwitchingPoint} percentage points</span></li>
            </ul>
          </div>
        </div>
        
        <div className="p-4 border border-gray-200 rounded bg-gray-50">
          <h3 className="font-bold text-lg mb-2">Scenario Analysis</h3>
          <p className="text-sm mb-4">This table shows different possible outcomes and their probabilities.</p>
          
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-100">
                <tr>
                  <th className="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Scenario</th>
                  <th className="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Probability</th>
                  <th className="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Annual Growth</th>
                  <th className="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Exit Multiple</th>
                  <th className="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">NPV (£)</th>
                  <th className="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">IRR (%)</th>
                  <th className="px-3 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Weighted NPV (£)</th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {scenarios.map((scenario, index) => (
                  <tr key={index} className={scenario.name === 'Most Likely' ? 'bg-blue-50' : ''}>
                    <td className="px-3 py-2 text-sm font-medium">{scenario.name}</td>
                    <td className="px-3 py-2 text-sm">{scenario.probability}%</td>
                    <td className="px-3 py-2 text-sm">{scenario.growth}%</td>
                    <td className="px-3 py-2 text-sm">{scenario.exitMultiple}x</td>
                    <td className="px-3 py-2 text-sm">£{scenario.npv.toLocaleString()}</td>
                    <td className="px-3 py-2 text-sm">{scenario.irr}%</td>
                    <td className="px-3 py-2 text-sm">£{Math.round(scenario.npv * scenario.probability / 100).toLocaleString()}</td>
                  </tr>
                ))}
                <tr className="bg-green-100 font-bold">
                  <td className="px-3 py-2 text-sm">Expected Value</td>
                  <td className="px-3 py-2 text-sm">100%</td>
                  <td className="px-3 py-2 text-sm">-</td>
                  <td className="px-3 py-2 text-sm">-</td>
                  <td className="px-3 py-2 text-sm">£{Math.round(expectedNPV).toLocaleString()}</td>
                  <td className="px-3 py-2 text-sm">-</td>
                  <td className="px-3 py-2 text-sm">£{Math.round(expectedNPV).toLocaleString()}</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <div className="mt-4">
            <h4 className="font-semibold">Key Insights:</h4>
            <ul className="list-disc ml-5 space-y-1 mt-2">
              <li>Even in the pessimistic scenario, NPV remains positive</li>
              <li>IRR exceeds the cost of capital in all scenarios</li>
              <li>Expected NPV of £{Math.round(expectedNPV).toLocaleString()} suggests a robust investment</li>
              <li>Project has approximately a {scenarios[0].probability}% chance of achieving minimal returns</li>
            </ul>
          </div>
        </div>
      </div>
      
      <div className="mt-6 p-4 border border-gray-300 rounded bg-gray-50">
        <h3 className="font-bold mb-2">Risk Assessment Conclusion:</h3>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-3">
          <div>
            <h4 className="font-semibold">Sensitivity Analysis Results:</h4>
            <ul className="list-disc ml-5 space-y-1 mt-1">
              <li>The project is most sensitive to <span className="font-bold">changes in annual cash flows</span></li>
              <li>Initial investment would need to increase by {investmentSwitchingPoint}% to make NPV zero</li>
              <li>Annual cash flows would need to decrease by {Math.abs(cashFlowsSwitchingPoint)}% to make NPV zero</li>
              <li>Discount rate would need to increase by {discountRateSwitchingPoint} percentage points to make NPV zero</li>
            </ul>
          </div>
          
          <div>
            <h4 className="font-semibold">Scenario Analysis Results:</h4>
            <ul className="list-disc ml-5 space-y-1 mt-1">
              <li>Even pessimistic scenario yields positive NPV</li>
              <li>Expected NPV of £{Math.round(expectedNPV).toLocaleString()} represents a {Math.round(expectedNPV/initialInvestment*100)}% return on investment</li>
              <li>IRR exceeds cost of capital in all scenarios</li>
              <li>Project appears robust across reasonable variations in assumptions</li>
            </ul>
          </div>
        </div>
        
        <div className="mt-4 bg-blue-50 p-3 rounded border border-blue-200">
          <h4 className="font-semibold text-blue-800">Recommendation:</h4>
          <p className="mt-1">
            Based on sensitivity and scenario analysis, this appears to be a relatively low-risk investment with significant upside potential. 
            The most critical factor to monitor is annual cash flows, particularly in the early years. 
            The project demonstrates resilience to reasonable variations in key parameters and should be accepted.
          </p>
        </div>
      </div>
    </div>
  );
};

export default SensitivityAnalysisVisualization;
