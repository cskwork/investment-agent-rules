# 1. Capital Preservation First

> "Rule No. 1: Never lose money. Rule No. 2: Never forget rule No. 1."
> — Warren Buffett

> "Risk means more things can happen than will happen. It is not the same as volatility."
> — Howard Marks, *The Most Important Thing*

## Why

This is the umbrella rule. Every other commandment in this set exists to serve it.

A 50% drawdown requires a 100% gain to break even. A 75% drawdown requires 300%. A 90% drawdown requires 900%. The arithmetic is unforgiving and well known, and that is why Buffett puts capital preservation at *Rule No. 1, before any rule about how to make money.* Returns compound; permanent losses compound the other way, faster.

The first job of an agent that touches capital is not to grow it. It is to *not permanently impair it.* Growth is the second job, and it cannot happen if the first job has been failed.

### What "losing money" actually means

The single most important refinement, owed to Howard Marks, is that the relevant kind of loss is **permanent loss of capital**, not price volatility:

- A wonderful business whose stock drops 40% in a panic, while the underlying earnings power is unchanged — that is volatility. Holding through it is uncomfortable but harmless. Selling at the bottom converts it into a permanent loss.
- A mediocre business whose competitive position has eroded — that is a permanent impairment. The price may or may not bounce; the capital is gone either way.
- A leveraged position that is correct on the thesis but too large for the volatility the thesis requires — that is volatility *converted into* permanent loss by position sizing.

The agent must price the difference. Volatility is the fee paid for long-term equity returns. Permanent loss is the end of compounding. Treating them as the same number — as standard-deviation finance does — leads to the wrong decisions in both directions: oversized positions in falsely "stable" assets, and undersized positions in assets that wobble but compound.

### How preservation gets violated

Permanent losses typically arrive through one of a small number of channels:

- **Leverage that forces selling.** Margin calls, covenant breaches, redemption pressure on a fund. The thesis was right; the structure was wrong.
- **Concentration that forces selling.** One factor (one industry, one customer, one regulator, one country) holds too much of the portfolio's outcome.
- **Capital structure failure of the underlying business.** Debt maturity wall, dilution at the bottom of the cycle, dependence on a closed capital market.
- **Permanent competitive impairment.** The moat dissolves; ROIC falls below cost of capital and stays there.
- **Operator behavior under stress.** The agent, the human supervisor, or the investor sells the worst things at the worst time — because the position was too large, the leverage was too high, or the holding period was too short.

The rest of the rules — margin of safety, business quality, management, diversification, cycle awareness — are the techniques that defend each of these channels. *Rule 1 is the goal those techniques serve.*

## Checklist

- [ ] Every position has a written **permanent-loss scenario**: what would actually destroy this capital (not just "what would make the price drop")?
- [ ] Leverage, if used at all, is bounded and *reversible without a forced sale.*
- [ ] No single position, factor, or counterparty can take the portfolio below a pre-declared `min_equity_floor`.
- [ ] Position sizing assumes the investor must hold through a 30–50% mark-to-market drawdown without selling.
- [ ] Volatility and permanent loss are tracked separately. Drops in price with intact earnings power are not treated as risk events.
- [ ] "Catastrophic but plausible" scenarios (market closure, broker outage, regulatory shock, sudden illiquidity) have a written response.
- [ ] The agent is willing to do nothing. Cash is a legitimate output. "No acceptable position today" is a valid decision.

## How an AI investment agent enforces this

```python
def can_open(proposal, portfolio, risk_config):
    # 1) Permanent-loss scenario must exist and be written down.
    if not proposal.written_permanent_loss_scenario:
        return Reject("no_permanent_loss_scenario")

    # 2) Position sizing must survive the volatility the thesis requires.
    if proposal.size_implies_forced_sale_on_50pct_drawdown:
        return Reject("sized_to_force_selling_into_volatility")

    # 3) Single-position floor.
    if portfolio.equity_after(proposal) < risk_config.min_equity_floor:
        return Reject("min_equity_floor_breached")

    # 4) Single-factor concentration cap (industry, customer, country, technology).
    if portfolio.factor_exposure_after(proposal).max() > risk_config.factor_cap:
        return Reject("single_factor_overexposure")

    # 5) Leverage that cannot be reversed without a forced sale.
    if proposal.leverage_requires_forced_sale_under_stress:
        return Reject("leverage_not_reversible_without_forced_sale")

    return Allow()
```

If the guard cannot prove the position is survivable, the position does not exist. Returns can wait. Capital, once permanently impaired, cannot.
