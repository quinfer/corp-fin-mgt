# ACF838 Corporate Financial Management
## Comprehensive Exam Preparation Pack for Legal Professionals

### Table of Contents
1. [Core Concepts and Intuitive Explanations](#core-concepts)
2. [Mathematical Techniques with Step-by-Step Guidance](#mathematical-techniques)
3. [Practice Problems with Detailed Solutions](#practice-problems)
4. [Common Pitfalls and How to Avoid Them](#common-pitfalls)
5. [Exam Strategy and Time Management](#exam-strategy)

---

## Core Concepts and Intuitive Explanations {#core-concepts}

### 1. Investment Appraisal: The Business Case for Spending Money

Think of investment appraisal like evaluating whether to buy a rental property. You need to consider:
- **Initial cost** (purchase price + fees)
- **Ongoing income** (rental payments)
- **Ongoing costs** (maintenance, taxes)
- **Final value** (what you can sell it for)

**Net Present Value (NPV)** answers: "If I invest this money today, how much better off will I be in today's money terms?"

**Internal Rate of Return (IRR)** answers: "What annual return does this investment actually give me?"

**Payback Period** answers: "How long before I get my initial investment back?"

### 2. Capital Structure: How Companies Fund Themselves

Imagine a company as a person buying a house:
- **Equity financing** = Using your own savings (no obligation to pay back, but you own less of your future wealth)
- **Debt financing** = Taking a mortgage (fixed payments required, but you keep more ownership)

**Weighted Average Cost of Capital (WACC)** = The blended cost of all your funding sources

### 3. Risk and Return: The Fundamental Trade-off

In finance, risk and return are like speed and safety when driving:
- Want higher returns? Accept higher risk
- Want safety? Accept lower returns
- **Beta** measures how bumpy the ride is compared to the overall market

---

## Mathematical Techniques with Step-by-Step Guidance {#mathematical-techniques}

### Technique 1: NPV Calculation

**The Logic:** Money today is worth more than money tomorrow (time value of money)

**Step-by-Step Process:**
1. **Identify all cash flows** (initial investment, annual inflows/outflows, terminal values)
2. **Choose discount rate** (usually given as cost of capital)
3. **Discount each future cash flow** using Present Value tables
4. **Sum everything up** (negative initial investment + positive present values)

**Formula in Plain English:**
NPV = "Money I put in today" + "Present value of all money I get back"

**Example Walkthrough:**
```
Year 0: Invest £100,000 (negative cash flow)
Year 1: Receive £60,000
Year 2: Receive £70,000
Discount rate: 10%

Step 1: Find discount factors from tables
- Year 1 factor at 10% = 0.909
- Year 2 factor at 10% = 0.826

Step 2: Calculate present values
- Year 1 PV = £60,000 × 0.909 = £54,540
- Year 2 PV = £70,000 × 0.826 = £57,820

Step 3: Calculate NPV
NPV = -£100,000 + £54,540 + £57,820 = £12,360

Decision: Accept (NPV > 0 means profitable)
```

### Technique 2: IRR Calculation

**The Logic:** Find the discount rate that makes NPV = zero

**Step-by-Step Process:**
1. **Try a high discount rate** (should give negative NPV)
2. **Try a low discount rate** (should give positive NPV)
3. **Use interpolation formula** to find exact IRR

**Interpolation Formula:**
```
IRR = Lower Rate + [NPV at Lower Rate / (NPV at Lower Rate - NPV at Higher Rate)] × (Higher Rate - Lower Rate)
```

### Technique 3: WACC Calculation

**The Logic:** Find the average cost of all funding sources, weighted by their importance

**Step-by-Step Process:**
1. **Calculate market values** of each funding source
2. **Find the cost** of each funding source
3. **Calculate weights** (each source ÷ total value)
4. **Multiply costs by weights** and sum up

**Key Formulas:**
- **Cost of Equity (CAPM):** Risk-free rate + Beta × (Market return - Risk-free rate)
- **Cost of Debt:** Interest rate × (1 - Tax rate) [because interest is tax-deductible]

---

## Practice Problems with Detailed Solutions {#practice-problems}

### Practice Problem 1: Basic NPV Analysis

**Scenario:** Blackstone Legal Services is considering investing £500,000 in new case management software.

**Cash Flow Projections:**
- Year 1: £180,000 cost savings
- Year 2: £220,000 cost savings
- Year 3: £250,000 cost savings
- Year 4: £200,000 cost savings
- Cost of capital: 8%

**Required:** Calculate NPV and advise on the investment.

**Solution:**

*Step 1: Identify cash flows*
- Year 0: -£500,000
- Years 1-4: As given above

*Step 2: Find discount factors (8% column)*
- Year 1: 0.926
- Year 2: 0.857
- Year 3: 0.794
- Year 4: 0.735

*Step 3: Calculate present values*
- Year 1 PV: £180,000 × 0.926 = £166,680
- Year 2 PV: £220,000 × 0.857 = £188,540
- Year 3 PV: £250,000 × 0.794 = £198,500
- Year 4 PV: £200,000 × 0.735 = £147,000

*Step 4: Calculate NPV*
NPV = -£500,000 + £166,680 + £188,540 + £198,500 + £147,000 = £200,720

**Decision:** Accept the investment (NPV > 0 indicates value creation)

### Practice Problem 2: WACC Calculation for a Law Firm

**Scenario:** Whitfield Partners has the following capital structure:
- Ordinary shares: 2 million shares at £15 each, Beta = 0.8
- Bank loan: £10 million at 6% interest
- Risk-free rate: 3%, Market return: 10%, Tax rate: 25%

**Required:** Calculate WACC.

**Solution:**

*Step 1: Calculate market values*
- Equity: 2m × £15 = £30 million
- Debt: £10 million
- Total: £40 million

*Step 2: Calculate costs*
- Cost of Equity (CAPM): 3% + 0.8 × (10% - 3%) = 3% + 5.6% = 8.6%
- Cost of Debt (after-tax): 6% × (1 - 0.25) = 4.5%

*Step 3: Calculate weights*
- Equity weight: £30m ÷ £40m = 75%
- Debt weight: £10m ÷ £40m = 25%

*Step 4: Calculate WACC*
WACC = (75% × 8.6%) + (25% × 4.5%) = 6.45% + 1.125% = 7.575%

### Practice Problem 3: Complex Investment with Working Capital

**Scenario:** Maritime Legal Associates is considering opening a new office. The details are:
- Initial fit-out costs: £800,000
- Working capital needed: £120,000 (recovered at project end)
- Annual net cash flows: £300,000 for 5 years
- Office rental opportunity cost: £50,000 per year (space currently rented out)
- Cost of capital: 12%

**Required:** Calculate NPV.

**Solution:**

*Step 1: Identify all cash flows*
- Year 0: -(£800,000 + £120,000) = -£920,000
- Years 1-4: £300,000 - £50,000 = £250,000
- Year 5: £250,000 + £120,000 = £370,000 (includes working capital recovery)

*Step 2: Apply NPV calculation*
Using 12% discount factors:
- Year 1: £250,000 × 0.893 = £223,250
- Year 2: £250,000 × 0.797 = £199,250
- Year 3: £250,000 × 0.712 = £178,000
- Year 4: £250,000 × 0.636 = £159,000
- Year 5: £370,000 × 0.567 = £209,790

NPV = -£920,000 + £223,250 + £199,250 + £178,000 + £159,000 + £209,790 = £49,290

**Decision:** Accept (marginal but positive NPV)

### Practice Problem 4: IRR Calculation with Interpolation

**Scenario:** Crown Court Chambers is considering investing £400,000 in a new video conferencing system for remote hearings.

**Expected Cash Flows:**
- Year 1: £150,000 savings in travel costs
- Year 2: £180,000 savings
- Year 3: £200,000 savings

**Required:** Calculate the IRR and advise if acceptable (cost of capital = 15%).

**Solution:**

*Step 1: Test discount rates*

*At 20%:*
- Year 1: £150,000 × 0.833 = £124,950
- Year 2: £180,000 × 0.694 = £124,920
- Year 3: £200,000 × 0.579 = £115,800
- Total PV = £365,670
- NPV = £365,670 - £400,000 = -£34,330 (negative)

*At 15%:*
- Year 1: £150,000 × 0.870 = £130,500
- Year 2: £180,000 × 0.756 = £136,080
- Year 3: £200,000 × 0.658 = £131,600
- Total PV = £398,180
- NPV = £398,180 - £400,000 = -£1,820 (slightly negative)

*At 14%:*
- Year 1: £150,000 × 0.877 = £131,550
- Year 2: £180,000 × 0.769 = £138,420
- Year 3: £200,000 × 0.675 = £135,000
- Total PV = £404,970
- NPV = £404,970 - £400,000 = £4,970 (positive)

*Step 2: Interpolate between 14% and 15%*
IRR = 14% + [£4,970 ÷ (£4,970 - (-£1,820))] × (15% - 14%)
IRR = 14% + [£4,970 ÷ £6,790] × 1% = 14% + 0.73% = 14.73%

**Decision:** Reject (IRR 14.73% < 15% cost of capital)

### Practice Problem 5: Discounted Payback Period

**Scenario:** Solicitors Direct is investing £600,000 in an automated document review system.

**Cash Flow Projections:**
- Year 1: £200,000
- Year 2: £250,000  
- Year 3: £300,000
- Year 4: £300,000
- Cost of capital: 10%

**Required:** Calculate discounted payback period (company policy: maximum 3 years).

**Solution:**

*Step 1: Calculate discounted cash flows*
- Year 1: £200,000 × 0.909 = £181,800
- Year 2: £250,000 × 0.826 = £206,500
- Year 3: £300,000 × 0.751 = £225,300
- Year 4: £300,000 × 0.683 = £204,900

*Step 2: Calculate cumulative discounted cash flows*
- Year 0: -£600,000
- End Year 1: -£600,000 + £181,800 = -£418,200
- End Year 2: -£418,200 + £206,500 = -£211,700
- End Year 3: -£211,700 + £225,300 = £13,600

Recovery occurs in Year 3.

*Step 3: Calculate exact timing*
Amount needed in Year 3 = £211,700
Year 3 provides = £225,300
Fraction of Year 3 = £211,700 ÷ £225,300 = 0.94

**Discounted Payback Period = 2.94 years**

**Decision:** Accept (2.94 years < 3-year policy maximum)

### Practice Problem 6: Multi-Division WACC

**Scenario:** Legal Group Holdings has three divisions with different risk profiles:

**Corporate Division (60% of firm value):**
- Beta = 0.8 (stable corporate clients)

**Litigation Division (30% of firm value):**
- Beta = 1.4 (high-risk contingency work)

**Property Division (10% of firm value):**
- Beta = 1.0 (average risk)

**Market Data:**
- Risk-free rate: 4%
- Market return: 12%
- Overall firm debt ratio: 25%
- Cost of debt (after-tax): 5%

**Required:** Calculate divisional costs of equity and overall firm WACC.

**Solution:**

*Step 1: Calculate divisional costs of equity*
- Corporate: 4% + 0.8 × (12% - 4%) = 4% + 6.4% = 10.4%
- Litigation: 4% + 1.4 × (12% - 4%) = 4% + 11.2% = 15.2%
- Property: 4% + 1.0 × (12% - 4%) = 4% + 8.0% = 12.0%

*Step 2: Calculate weighted average cost of equity*
Weighted CoE = (60% × 10.4%) + (30% × 15.2%) + (10% × 12.0%)
Weighted CoE = 6.24% + 4.56% + 1.20% = 12.0%

*Step 3: Calculate firm WACC*
WACC = (75% × 12.0%) + (25% × 5.0%) = 9.0% + 1.25% = 10.25%

### Practice Problem 7: Preference Share Valuation

**Scenario:** Barrister Chambers Holdings has issued preference shares with the following details:
- Nominal value: £5 per share
- Dividend rate: 8% per annum
- Current market price: £4.20
- 500,000 shares outstanding

**Also has:**
- Ordinary shares: 2 million at £12 each, Beta = 1.1
- Bank loans: £8 million at 7% interest
- Risk-free rate: 3.5%, Market return: 11%, Tax rate: 20%

**Required:** Calculate WACC.

**Solution:**

*Step 1: Calculate market values*
- Preference shares: 500,000 × £4.20 = £2.1 million
- Ordinary shares: 2,000,000 × £12 = £24 million
- Debt: £8 million
- Total: £34.1 million

*Step 2: Calculate component costs*
- Cost of preference shares: (£5 × 8%) ÷ £4.20 = £0.40 ÷ £4.20 = 9.52%
- Cost of ordinary shares: 3.5% + 1.1 × (11% - 3.5%) = 3.5% + 8.25% = 11.75%
- Cost of debt: 7% × (1 - 0.20) = 5.6%

*Step 3: Calculate weights and WACC*
- Preference weight: £2.1m ÷ £34.1m = 6.16%
- Ordinary weight: £24m ÷ £34.1m = 70.38%
- Debt weight: £8m ÷ £34.1m = 23.46%

WACC = (6.16% × 9.52%) + (70.38% × 11.75%) + (23.46% × 5.6%)
WACC = 0.59% + 8.27% + 1.31% = 10.17%

### Practice Problem 8: Bond Valuation for WACC

**Scenario:** City Law Partners has outstanding bonds with these characteristics:
- Face value: £10 million
- Coupon rate: 6% per annum
- Years to maturity: 4 years
- Current market price: 102% of face value
- Tax rate: 25%

**Required:** Calculate the after-tax cost of debt.

**Solution:**

*Step 1: Set up bond valuation*
- Annual coupon = £10m × 6% = £600,000
- Market value = £10m × 1.02 = £10.2 million
- Redemption value = £10 million (at par)

*Step 2: Find yield to maturity using trial and error*

*Try 5%:*
PV = £600,000 × 3.546 + £10,000,000 × 0.823
PV = £2,127,600 + £8,230,000 = £10,357,600 (too high)

*Try 6%:*
PV = £600,000 × 3.465 + £10,000,000 × 0.792  
PV = £2,079,000 + £7,920,000 = £9,999,000 (too low)

*Try 5.5%:*
Using interpolation or financial calculator: YTM ≈ 5.3%

*Step 3: Apply tax adjustment*
After-tax cost = 5.3% × (1 - 0.25) = 3.98%

### Practice Problem 9: Working Capital Impact Analysis

**Scenario:** Regional Legal Services is expanding into employment law. The expansion requires:
- Initial setup costs: £300,000
- Working capital: 15% of annual revenue
- Projected annual revenue: £800,000 (growing 5% per year)
- Annual costs: £600,000 (growing 3% per year)
- Project life: 4 years
- Cost of capital: 11%

**Required:** Calculate NPV including working capital impacts.

**Solution:**

*Step 1: Calculate annual working capital requirements*
- Year 1 revenue: £800,000 → WC = £120,000
- Year 2 revenue: £840,000 → WC = £126,000
- Year 3 revenue: £882,000 → WC = £132,300
- Year 4 revenue: £926,100 → WC = £138,915

*Step 2: Calculate annual cash flows*

| Year | Revenue | Costs | Operating CF | WC Investment | Net CF |
|------|---------|-------|-------------|---------------|---------|
| 0 | - | £300,000 | -£300,000 | £120,000 | -£420,000 |
| 1 | £800,000 | £600,000 | £200,000 | £6,000 | £194,000 |
| 2 | £840,000 | £618,000 | £222,000 | £6,300 | £215,700 |
| 3 | £882,000 | £636,540 | £245,460 | £6,615 | £238,845 |
| 4 | £926,100 | £655,836 | £270,264 | -£138,915 | £409,179 |

*Note: Year 4 includes working capital recovery*

*Step 3: Calculate NPV*
Using 11% discount factors:
- Year 0: -£420,000
- Year 1: £194,000 × 0.901 = £174,794
- Year 2: £215,700 × 0.812 = £175,148
- Year 3: £238,845 × 0.731 = £174,592
- Year 4: £409,179 × 0.659 = £269,649

NPV = -£420,000 + £174,794 + £175,148 + £174,592 + £269,649 = £374,183

**Decision:** Highly attractive investment with strong positive NPV.

### Practice Problem 10: Lease vs Buy Decision

**Scenario:** Commercial Chambers needs new office equipment worth £150,000. Two options:

**Option A: Purchase**
- Pay £150,000 upfront
- Annual maintenance: £8,000
- Disposal value after 5 years: £30,000
- Tax depreciation: 20% reducing balance
- Tax rate: 25%

**Option B: Lease**
- Annual lease payments: £35,000 (tax-deductible)
- Lessor handles all maintenance
- No disposal value

**Cost of capital: 9%**

**Required:** Which option is financially preferable?

**Solution:**

*Step 1: Calculate tax benefits for purchase option*

| Year | Book Value | Depreciation | Tax Shield |
|------|------------|-------------|------------|
| 1 | £150,000 | £30,000 | £7,500 |
| 2 | £120,000 | £24,000 | £6,000 |
| 3 | £96,000 | £19,200 | £4,800 |
| 4 | £76,800 | £15,360 | £3,840 |
| 5 | £61,440 | £12,288 | £3,072 |

*Step 2: Calculate after-tax cash flows for purchase*

| Year | Maintenance | Tax Shield | Net Cost | PV Factor | Present Value |
|------|-------------|------------|----------|-----------|---------------|
| 0 | £150,000 | - | £150,000 | 1.000 | £150,000 |
| 1 | £8,000 | -£7,500 | £500 | 0.917 | £459 |
| 2 | £8,000 | -£6,000 | £2,000 | 0.842 | £1,684 |
| 3 | £8,000 | -£4,800 | £3,200 | 0.772 | £2,470 |
| 4 | £8,000 | -£3,840 | £4,160 | 0.708 | £2,945 |
| 5 | £8,000 | -£3,072 | £4,928 | 0.650 | £3,203 |
| 5 | -£30,000 | - | -£30,000 | 0.650 | -£19,500 |

**Purchase Option PV = £141,261**

*Step 3: Calculate present value of lease payments*
Annual after-tax lease cost = £35,000 × (1 - 0.25) = £26,250

PV of lease = £26,250 × 3.890 (5-year annuity factor at 9%) = £102,113

**Decision:** Choose lease option (£102,113 < £141,261)

### Practice Problem 11: Rights Issue Impact

**Scenario:** Established Law Group currently has:
- 5 million ordinary shares trading at £8 each
- Plans 1-for-4 rights issue at £6 per share
- Funds needed for acquisition: £7.5 million

**Required:** Calculate theoretical ex-rights price and value to existing shareholders.

**Solution:**

*Step 1: Calculate rights issue details*
- New shares issued: 5 million ÷ 4 = 1.25 million
- Funds raised: 1.25 million × £6 = £7.5 million ✓

*Step 2: Calculate theoretical ex-rights price*
- Current market value: 5 million × £8 = £40 million
- Funds raised: £7.5 million
- Total post-issue value: £47.5 million
- Total shares post-issue: 6.25 million
- Theoretical ex-rights price: £47.5m ÷ 6.25m = £7.60

*Step 3: Calculate value of rights*
Rights value per existing share = £8.00 - £7.60 = £0.40

*Step 4: Check: Rights value per new share*
= £7.60 - £6.00 = £1.60
Ratio check: £1.60 ÷ 4 = £0.40 ✓

**Conclusion:** Each existing shareholder receives rights worth £0.40 per share held.

### Practice Problem 12: Dividend Policy Analysis

**Scenario:** Partners Legal has £500,000 surplus cash and three options:

**Option 1:** Pay special dividend (tax rate on dividends: 32.5%)
**Option 2:** Share buyback (capital gains tax: 20%)
**Option 3:** Retain for future investments (current return: 3%, required return: 12%)

**Current position:**
- 1 million shares at £5 each
- Recent annual dividend: £0.20 per share

**Required:** Evaluate each option for shareholders.

**Solution:**

*Step 1: Special dividend analysis*
- Dividend per share: £500,000 ÷ 1,000,000 = £0.50
- After-tax receipt per share: £0.50 × (1 - 0.325) = £0.34
- Total shareholder benefit: £340,000

*Step 2: Share buyback analysis*
- Shares repurchased: £500,000 ÷ £5 = 100,000 shares
- Remaining shares: 900,000
- Percentage ownership increase: 100,000 ÷ 900,000 = 11.11%
- Future dividend benefit (assuming £0.20 continues):
  New dividend per share = £200,000 ÷ 900,000 = £0.22
  Increase = £0.02 per share
- Capital gains: Share price may increase due to reduced share count

*Step 3: Retention analysis*
- Current return on cash: 3%
- Opportunity cost: 12%
- Annual value destruction: £500,000 × (12% - 3%) = £45,000

**Recommendation:** Share buyback likely optimal due to:
- Better tax treatment for shareholders
- Increased ownership concentration
- Avoids value destruction from low returns on cash

## Additional Complex Scenarios

### Multi-Period Working Capital Example

**Scenario:** International Legal Consultancy is launching a new practice area requiring careful working capital management.

**Projections:**
- Setup costs: £200,000
- Annual revenue growth: Year 1: £400,000, then 15% annually
- Working capital: 20% of revenue
- Operating margin: 35% of revenue
- Project life: 5 years
- Terminal working capital recovery: 100%
- Cost of capital: 14%

**Detailed Solution with Working Capital Changes:**

| Year | Revenue | Op. Profit | WC Required | WC Investment | Free CF |
|------|---------|------------|-------------|---------------|---------|
| 0 | - | -£200,000 | £80,000 | £80,000 | -£280,000 |
| 1 | £400,000 | £140,000 | £92,000 | £12,000 | £128,000 |
| 2 | £460,000 | £161,000 | £105,800 | £13,800 | £147,200 |
| 3 | £529,000 | £185,150 | £121,670 | £15,870 | £169,280 |
| 4 | £608,350 | £212,923 | £139,921 | £18,251 | £194,672 |
| 5 | £699,603 | £244,861 | - | -£139,921 | £384,782 |

This demonstrates how working capital ties up cash during growth phases but provides a significant cash release at project end.

---

## Common Pitfalls and How to Avoid Them {#common-pitfalls}

### 1. Forgetting Working Capital

**The Mistake:** Only considering fixed asset investments
**Why It Happens:** Working capital seems "temporary"
**How to Avoid:** Always ask "Do we need extra cash for day-to-day operations?"

**Remember:** Working capital goes out at the start and comes back at the end

### 2. Ignoring Opportunity Costs

**The Mistake:** Not considering what we give up
**Why It Happens:** Opportunity costs don't involve actual cash payments
**How to Avoid:** Always ask "What else could we do with these resources?"

**Example:** Using owned office space means losing rental income

### 3. Poor Bond Yield Calculations

**The Mistake:** Using simple current yield instead of yield to maturity
**Example Error:** 
- Bond pays £6 coupon, trades at £95
- Wrong: Cost = £6 ÷ £95 = 6.32%
- Right: Use IRR method considering redemption value

**How to Avoid:** Always consider the full life of the bond, including redemption

### 4. Forgetting Tax Benefits of Debt

**The Mistake:** Using pre-tax cost of debt in WACC
**Why It Happens:** Interest rates are usually quoted before tax
**How to Avoid:** Always multiply debt cost by (1 - tax rate)

### 5. Poor Interpolation in IRR Calculations

**The Mistake:** Using wrong formula or making arithmetic errors
**How to Avoid:** Use this systematic approach:
1. Ensure one rate gives positive NPV, one gives negative NPV
2. Use the formula: Lower Rate + [Positive NPV ÷ (Positive NPV - Negative NPV)] × Rate Difference

### 6. Missing Cash Flow Components

**Common Oversights:**
- Incremental working capital changes
- Opportunity costs (like forgone rental income)
- Tax implications of asset disposals
- Inflation adjustments when specified

**Example:** A law firm buying new premises might forget:
- Legal fees and stamp duty (part of initial cost)
- Lost rental income from current space
- Different tax treatment of owned vs rented property

### 7. Incorrect Market Value Calculations

**The Mistake:** Using book values or mixing up share counts
**Example:** 
- Wrong: Using historical debt values
- Right: Current market price × number of bonds outstanding

### 8. Misunderstanding Beta in CAPM

**Common Errors:**
- Using beta > 1 to mean "high risk" without understanding it's relative to market
- Forgetting that beta only measures systematic risk
- Not adjusting beta for different business risks in multi-division firms

**Example:** A beta of 0.8 doesn't mean "80% risky" - it means 20% less volatile than the market.

---

## Exam Strategy and Time Management {#exam-strategy}

### Time Allocation (3-hour exam)

**Section A (60 marks, 120 minutes):**
- Question 1 (30 marks): 60 minutes
- Question 2 (30 marks): 60 minutes

**Section B (40 marks, 60 minutes):**
- Two questions (20 marks each): 30 minutes per question

### Question-by-Question Strategy

**Investment Appraisal Questions:**
1. **Read carefully** and identify all cash flow components
2. **Set up a table** with years as columns
3. **Work systematically** through NPV, then IRR, then payback
4. **Write brief conclusions** for each method

**WACC Questions:**
1. **Calculate market values first** - this is often worth easy marks
2. **Show component costs clearly** with CAPM calculations
3. **Present final WACC calculation in a table**
4. **Double-check your arithmetic**

**Essay Questions:**
1. **Plan your answer** - spend 5 minutes outlining
2. **Use headings** to structure your response
3. **Include practical examples** from legal/professional services
4. **Relate theory to practice**

### Quick Reference Formulas

**NPV:** Sum of (Cash Flow × Discount Factor) - Initial Investment

**IRR:** Use interpolation when NPV tables don't give exact answer

**CAPM:** Risk-free rate + Beta × (Market return - Risk-free rate)

**WACC:** Σ(Weight × Cost) for each funding source

**Payback:** Years until cumulative cash flows = Initial investment

### Pre-Exam Checklist

**Technical Preparation:**
- [ ] Can you find discount factors quickly in tables?
- [ ] Do you know the CAPM formula by heart?
- [ ] Can you perform interpolation accurately?
- [ ] Do you remember to adjust debt costs for tax?

**Practical Preparation:**
- [ ] Calculator with percentage and memory functions
- [ ] Spare batteries
- [ ] Multiple pens
- [ ] Watch for time management

**Mental Preparation:**
- [ ] Review common pitfalls list
- [ ] Practice explaining concepts in plain English
- [ ] Prepare standard essay frameworks
- [ ] Plan your time allocation

---

## Final Tips for Legal Professionals

### 1. Connect Finance to Legal Practice
Think about how these concepts apply to:
- Law firm mergers and acquisitions
- Investment in new practice areas
- Office expansion decisions
- Technology investments

### 2. Focus on Understanding, Not Memorisation
The examiners want to see that you understand:
- **Why** we discount future cash flows
- **How** risk affects required returns
- **When** different appraisal methods give different answers

### 3. Show Your Working
In professional practice, you need to justify decisions to partners and clients. The same applies in exams - show your reasoning clearly.

### 4. Practice Under Time Pressure
Financial decisions often need to be made quickly. Practice solving problems within strict time limits.

### 5. Read the Question Carefully
Like legal documents, finance exam questions contain crucial details. A missed requirement can cost significant marks.

Remember: Corporate finance is ultimately about making good business decisions with limited resources. As legal professionals, you already understand the importance of careful analysis and clear communication - apply these same skills to financial problems.