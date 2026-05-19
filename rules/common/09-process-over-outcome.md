# 9. Process Over Outcome — Validate the Signal, Control the Variance

> "There's no use in having a great insight if you don't execute on it."
> — Jim Simons

> "The secret to investing is to figure out the value of something — and then pay a lot less."
> — Joel Greenblatt

## Why

Outcomes lie. A bad process can produce a good outcome (luck); a good process can produce a bad outcome (variance). Judging the agent by last week's P&L teaches it to chase luck.

What you actually want is a *process* whose statistical properties you can measure: hit rate, expectancy, drawdown profile, capacity, decay. Renaissance does not bet on individual ideas; it bets that the *system* of ideas has positive expectancy after costs, validated and re-validated against fresh data.

An LLM-driven agent is unusually exposed to outcome bias because it can rationalize any result after the fact. The defense is a paper trail the agent cannot edit: signal, size, fill, exit, attribution — all logged, all reviewed.

## Checklist

- [ ] Every strategy has an out-of-sample validation period before it goes live with real capital.
- [ ] Live performance is compared to live expectation (not to backtest); divergence beyond X sigma triggers review.
- [ ] Signals are logged at the moment they are generated, not after the trade closes. No backfilling.
- [ ] Attribution separates: signal correctness, sizing correctness, execution quality.
- [ ] Wins are reviewed as harshly as losses — was it the process, or was it luck?

## How an AI trading bot enforces this

```python
def promote_to_live(strategy):
    # Gating: paper → small-size live → full-size live
    if not strategy.has_oos_period(months=6):
        return False
    if strategy.oos_sharpe < strategy.is_sharpe * 0.5:
        return False   # too much in-sample overfitting
    if strategy.oos_max_dd > strategy.is_max_dd * 1.5:
        return False
    return True

def divergence_alarm(strategy):
    z = (strategy.live_sharpe_30d - strategy.expected_sharpe) / strategy.sharpe_stderr
    return abs(z) > 2.0   # halt or down-size, do not "wait it out"
```

The bot is accountable to its process. The process is accountable to out-of-sample evidence. P&L is the by-product.
