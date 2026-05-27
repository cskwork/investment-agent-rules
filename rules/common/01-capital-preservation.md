# 1. Capital Preservation First

> "Rule No. 1: Never lose money. Rule No. 2: Never forget rule No. 1."
> — Warren Buffett

> "Risk means more things can happen than will happen. It is not the same as volatility."
> — Howard Marks, *The Most Important Thing*

## In short

Do not lose money. Not "down on paper for a while" — *actually* lose it. Every other rule in this list exists to defend this one.

## Why

This is the umbrella rule. Every other commandment serves it.

If you lose 50% of your money, you need a 100% gain to get back to even. Lose 75%, you need a 300% gain. Lose 90%, you need 900%. The math is brutal and well known. That is why Buffett puts this rule *before* any rule about how to make money — making money is the second job, and it cannot happen if the first job has been failed.

### What "losing money" actually means

The single most useful refinement, owed to Howard Marks, is that the kind of loss that matters is **permanent loss** — not a price that wobbles up and down.

- A good business whose stock falls 40% in a panic, while the actual earnings are unchanged — that is *volatility*. Uncomfortable, but the money is still there. Selling at the bottom is what turns it into a permanent loss.
- A weak business whose competitive position has been destroyed — that is *permanent impairment*. The price may or may not bounce. The capital is gone either way.
- A leveraged position that was right on the idea but too large for the volatility the idea required — that is volatility *converted into* permanent loss by bad sizing.

The agent must tell these apart. Volatility is the fee you pay for long-term stock returns. Permanent loss is the end of compounding. Treating them as the same number — as a lot of academic finance does — leads to the wrong decision in both directions: too big in things that look stable, too small in things that wobble but compound.

### How preservation actually gets violated

Permanent losses usually come through one of a small number of doors:

- **Leverage that forces selling.** Margin calls. Covenant breaches. Redemptions on a fund. The idea was right, the structure was wrong.
- **Concentration that forces selling.** One industry, one customer, one regulator, one country holds too much of the portfolio.
- **The underlying business breaks.** A debt wall the company cannot refinance. A capital raise at a terrible price.
- **The moat erodes.** The company stops earning more than its cost of capital, and stays there.
- **The operator panics.** The agent, the supervisor, or the investor sells the worst things at the worst time, usually because the position was too big or the time horizon too short.

The rest of the rules — margin of safety, business quality, management, diversification, cycle awareness — are the techniques that defend each of these doors. *Rule 1 is the goal those techniques exist for.*

## Checklist

- [ ] Every position has a written **"how could this permanently lose money"** scenario — not "what would make the price go down 20%".
- [ ] Leverage, if used at all, is small and *reversible without being forced to sell.*
- [ ] No single position, factor, or counterparty can drop the portfolio below a pre-set floor.
- [ ] Position size assumes you must hold through a 30–50% mark-to-market drop without selling.
- [ ] Volatility and permanent loss are tracked separately. Falling prices with intact earnings are not treated as a risk event.
- [ ] "Catastrophic but plausible" events (market closed for a day, broker outage, sudden regulatory change, sudden illiquidity) have a written response.
- [ ] The agent is willing to do nothing. Cash is a legitimate output. "No acceptable position today" is a valid decision.

## How an AI investment agent enforces this

```python
def can_open(proposal, portfolio, risk_config):
    # 1) The "how could this permanently lose money" scenario must be written down.
    if not proposal.written_permanent_loss_scenario:
        return Reject("no_permanent_loss_scenario")

    # 2) Size must survive the volatility the idea requires.
    if proposal.size_implies_forced_sale_on_50pct_drawdown:
        return Reject("sized_to_force_selling_into_volatility")

    # 3) Floor on the total portfolio.
    if portfolio.equity_after(proposal) < risk_config.min_equity_floor:
        return Reject("min_equity_floor_breached")

    # 4) Cap on any single risk factor (industry, customer, country, technology).
    if portfolio.factor_exposure_after(proposal).max() > risk_config.factor_cap:
        return Reject("single_factor_overexposure")

    # 5) No leverage that would force a sale under stress.
    if proposal.leverage_requires_forced_sale_under_stress:
        return Reject("leverage_not_reversible_without_forced_sale")

    return Allow()
```

If the gate cannot prove the position is survivable, the position does not exist. Returns can wait. Capital, once permanently lost, cannot.
