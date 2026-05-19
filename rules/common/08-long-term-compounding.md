# 8. Long-term Compounding Over Short-term Trading

> "The first rule of compounding: Never interrupt it unnecessarily."
> — Charlie Munger

> "Our favorite holding period is forever."
> — Warren Buffett

## Why

Compounding is multiplicative. Every interruption — a tax event, a round-trip on the spread, a forced sale at the wrong price — is a multiplicative leak. A 1% leak per turnover, run 50 times a year, is not a 50% leak; it is a 39% drag.

Short-term trading can still compound. Renaissance is proof. But it has to clear an unforgivingly high bar: the strategy must produce enough alpha to pay the taxes, the spread, the slippage, the impact, the borrow, and the operational risk of being wrong fast.

Most strategies — and most LLM-generated ideas — cannot clear that bar. The default behavior should be: hold longer than feels natural, churn less than feels exciting.

## Checklist

- [ ] Every strategy declares its target holding period and tracks actual.
- [ ] Turnover budget is set in advance and monitored (e.g., "max 200% annual turnover").
- [ ] Realized round-trip cost (fees + tax + slippage) is tracked per strategy and compared to gross alpha.
- [ ] Strategies whose net-after-cost return drops below a hurdle (e.g., risk-free + 3%) are flagged for retirement.
- [ ] "Boredom trades" — entries with no signal, taken because nothing happened today — are blocked by an explicit "no signal, no trade" rule.

## How an AI trading bot enforces this

```python
def turnover_guard(strategy, proposed_trade):
    annualized_turnover = strategy.rolling_turnover(window_days=90) * 4
    if annualized_turnover > strategy.turnover_budget:
        return Reject("turnover budget exceeded")
    return Allow()

def net_alpha_alive(strategy):
    gross = strategy.gross_return_oos
    cost  = strategy.realized_cost_per_turn * strategy.turnover_annualized
    return (gross - cost) > strategy.hurdle_rate

# Hard rule: no signal, no trade. Time is not a signal.
def has_signal(now, strategy):
    return strategy.signal_for(now) is not None
```

The default is to do nothing. Doing nothing is what makes compounding work.
