import React, { useState } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ReferenceLine, ResponsiveContainer } from 'recharts';

const NPVIRRVisualization = () => {
  // Default data from the basic project example
  const [initialInvestment, setInitialInvestment] = useState(500000);
  const [cashFlows, setCashFlows] = useState([150000, 180000, 200000, 120000, 100000]);
  
  // Calculate NPV at different discount rates
  const calculateNPV = (rate) => {
    let npv = -initialInvestment;
    for (let i = 0; i < cashFlows.length; i++) {
      npv += cashFlows[i] / Math.pow(1 + rate, i + 1);
    }
    return npv;
  };
  
  // Calculate IRR using the trial and error method
  const calculateIRR = () => {
    let lowerRate = 0;
    let upperRate = 1;
    let currentRate = (lowerRate + upperRate) / 2;
    let currentNPV = calculateNPV(currentRate);
    
    // Use binary search to find the rate where NPV = 0
    for (let i = 0; i < 50; i++) { // 50 iterations should be sufficient for precision
      if (Math.abs(currentNPV) < 0.1) {
        break;
      }
      
      if (currentNPV > 0) {
        lowerRate = currentRate;
      } else {
        upperRate = currentRate;
      }
      
      currentRate = (lowerRate + upperRate) / 2;
      currentNPV = calculateNPV(currentRate);
    }
    
    return Math.round(currentRate * 10000) / 100; // Return as percentage with 2 decimal places
  };
  
  // Generate data points for the NPV profile
  const generateNPVProfileData = () => {
    const data = [];
    for (let rate = 0; rate <= 0.3; rate += 0.01) {
      data.push({
        rate: rate * 100, // Convert to percentage for display
        npv: calculateNPV(rate)
      });
    }
    return data;
  };
  
  const npvProfileData = generateNPVProfileData();
  const irr = calculateIRR();
  
  // Find the closest data point to IRR
  const irrDataPoint = npvProfileData.reduce((closest, point) => 
    Math.abs(point.rate - irr) < Math.abs(closest.rate - irr) ? point : closest, 
    npvProfileData[0]
  );
  
  // Handle cash flow changes
  const handleCashFlowChange = (index, value) => {
    const newCashFlows = [...cashFlows];
    newCashFlows[index] = Number(value);
    setCashFlows(newCashFlows);
  };
  
  // Handle initial investment change
  const handleInvestmentChange = (value) => {
    setInitialInvestment(Number(value));
  };

  const CustomTooltip = ({ active, payload, label }) => {
    if (active && payload && payload.length) {
      return (
        <div className="bg-white p-3 border border-gray-300 rounded shadow-md">
          <p className="font-semibold">Discount Rate: {label.toFixed(2)}%</p>
          <p>NPV: £{payload[0].value.toFixed(2)}</p>
          {Math.abs(payload[0].value) < 100 && (
            <p className="text-green-600 font-bold">This is approximately the IRR!</p>
          )}
        </div>
      );
    }
    return null;
  };

  return (
    <div className="w-full">
      <h2 className="text-xl font-bold mb-4 text-center">NPV-IRR Relationship Visualization</h2>
      
      <div className="mb-6 p-4 border border-gray-200 rounded bg-gray-50">
        <h3 className="font-bold text-lg mb-2">Project Cash Flows</h3>
        
        <div className="mb-4">
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Initial Investment (£):
          </label>
          <input
            type="number"
            min="1000"
            max="1000000"
            value={initialInvestment}
            onChange={(e) => handleInvestmentChange(e.target.value)}
            className="border border-gray-300 rounded p-2 w-full"
          />
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
          {cashFlows.map((cf, index) => (
            <div key={index}>
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Year {index + 1} (£):
              </label>
              <input
                type="number"
                min="0"
                max="1000000"
                value={cf}
                onChange={(e) => handleCashFlowChange(index, e.target.value)}
                className="border border-gray-300 rounded p-2 w-full"
              />
            </div>
          ))}
        </div>
        
        <div className="mt-4 flex flex-wrap gap-4">
          <div className="bg-blue-100 p-2 rounded">
            <span className="font-bold">IRR:</span> {irr}%
          </div>
          <div className="bg-green-100 p-2 rounded">
            <span className="font-bold">NPV at 10%:</span> £{calculateNPV(0.1).toFixed(2)}
          </div>
          <div className="bg-yellow-100 p-2 rounded">
            <span className="font-bold">Decision Rule:</span> {irr > 10 ? 'Accept Project' : 'Reject Project'}
          </div>
        </div>
      </div>
      
      <div className="h-64 md:h-80">
        <ResponsiveContainer width="100%" height="100%">
          <LineChart data={npvProfileData} margin={{ top: 20, right: 30, left: 20, bottom: 20 }}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis 
              dataKey="rate" 
              type="number" 
              domain={[0, 30]} 
              label={{ value: 'Discount Rate (%)', position: 'bottom', offset: 0 }} 
            />
            <YAxis 
              label={{ value: 'Net Present Value (£)', angle: -90, position: 'left' }} 
            />
            <Tooltip content={<CustomTooltip />} />
            <ReferenceLine x={irr} stroke="red" strokeDasharray="3 3" label={{ value: `IRR = ${irr}%`, position: 'top', fill: 'red' }} />
            <ReferenceLine y={0} stroke="#000" strokeDasharray="3 3" />
            <Line 
              type="monotone" 
              dataKey="npv" 
              stroke="#2563eb" 
              dot={false} 
              activeDot={{ r: 8 }} 
              name="NPV"
            />
            {/* Marker for the IRR point */}
            <Line 
              type="monotone" 
              dataKey="npv" 
              stroke="#ef4444" 
              dot={false} 
              data={[irrDataPoint]}
              activeDot={{ r: 8 }} 
              name="IRR Point"
            />
          </LineChart>
        </ResponsiveContainer>
      </div>
      
      <div className="mt-6 p-4 border border-gray-300 rounded bg-gray-50">
        <h3 className="font-bold mb-2">Key NPV-IRR Relationship Insights:</h3>
        <ul className="list-disc ml-5 space-y-1">
          <li>The NPV profile shows how NPV changes with different discount rates</li>
          <li>IRR is the discount rate at which the NPV equals zero (where the line crosses the x-axis)</li>
          <li>When discount rate &lt; IRR, the NPV is positive, and the project is acceptable</li>
          <li>When discount rate &gt; IRR, the NPV is negative, and the project should be rejected</li>
          <li>The steeper the NPV profile, the more sensitive the project is to discount rate changes</li>
          <li>Try adjusting the cash flows to see how the IRR and NPV profile change</li>
        </ul>
      </div>
    </div>
  );
};

export default NPVIRRVisualization;
