# 8. Compound Long-Term; Don't Get in the Way

> "The first rule of compounding: Never interrupt it unnecessarily."
> — Charlie Munger

> "Our favorite holding period is forever."
> — Warren Buffett

## Why

Compounding is multiplicative. Every interruption — a tax event, a round-trip on the spread, a forced sale at the wrong price — is a multiplicative leak. A 1% leak per turnover, run 50 times a year, is not a 50% leak; it is a 39% drag on the terminal value.

Most of the long-term return on a quality compounder comes from holding it through periods when nothing interesting was happening. The temptation — to time the cycle, to harvest a gain, to "rotate" — costs taxes, spread, slippage, and the most expensive cost of all: not being there when the business takes its next leg up.

The default behavior should be: hold longer than feels natural, sell less than feels exciting, do nothing more often than is comfortable.

There are exactly three legitimate reasons to sell:
1. The original thesis is broken — the facts that made you buy turned out to be wrong.
2. The business quality has materially deteriorated — moat eroded, management changed, capital allocation broken (see Rules 5 and 6).
3. A clearly superior opportunity exists, and selling this position is the cheapest way to fund it.

Price moving is not a reason. Boredom is not a reason. "It's been five years" is not a reason.

## Checklist

- [ ] Every position declares its expected holding period (years, not months).
- [ ] Sell triggers are written at purchase and limited to the three legitimate reasons above.
- [ ] Realized round-trip cost (fees + tax + slippage) is tracked and compared to gross return.
- [ ] Turnover budget is set in advance and enforced.
- [ ] "Boredom" positions — proposed because nothing happened today — are blocked by a no-signal-no-action rule.
- [ ] Tax efficiency is considered before any sell, especially in taxable accounts.

## How an AI investment agent enforces this

```python
def can_sell(position, reason):
    valid = {"thesis_broken", "quality_deteriorated", "clearly_better_opportunity"}
    if reason not in valid:
        return Reject("invalid_sell_reason")
    return Allow()

def turnover_guard(portfolio, proposed):
    annualized = portfolio.rolling_turnover(window_days=90) * 4
    if annualized > portfolio.turnover_budget:
        return Reject("turnover_budget_exceeded")
    return Allow()

# Hard rule: no signal, no action. Time is not a signal.
def has_action_trigger(now, position):
    return position.signal_for(now) is not None
```

The default is to do nothing. Doing nothing is what allows compounding to do its work.
