# 4. A Stock Is a Piece of a Business

> "If you aren't willing to own a stock for ten years, don't even think about owning it for ten minutes."
> — Warren Buffett

> "We do not view the company itself as the ultimate owner of our business assets but, instead, view the company as a conduit through which our shareholders own the assets."
> — Berkshire Hathaway *Owner's Manual*

## In short

A share of stock is a small slice of a real company that hires people, signs leases, ships product, and makes money. Before you buy a share, ask: "Would I buy the whole company at this price?" If no, do not buy one share either.

## Why

A stock is not a flashing line on a screen. It is part-ownership of a real business with employees, customers, contracts, and competitors, producing cash year after year. The value of that ownership across its lifetime is what determines long-term returns. Everything else is noise on top of that signal.

The owner's mindset reframes every decision:

- "Do I want to buy this *company*?" — not "do I want to buy this *ticker*?"
- "Would I hold it through five years of closed markets?" — not "what does the chart say this week?"
- "If the price falls 30% next month and the business is unchanged, am I happy?" — if the honest answer is no, what you bought was speculation, not investment.

An agent that thinks in tickers and price moves will buy and sell the same business many times for no reason. An agent that thinks in businesses will hold what is working and only act when the business itself has changed.

## Checklist

- [ ] Every proposed buy is described as "buy a piece of this *business* at this implied valuation" — not "buy this ticker because of this signal".
- [ ] The agent can answer in one paragraph: what the company sells, who pays for it, who competes, what scales.
- [ ] The agent is comfortable with the position even if the market closed for five years.
- [ ] Selling because "the price dropped" is blocked unless the business itself has changed materially.
- [ ] Position size answers "how much of this *business* do I want to own?" — not "how much exposure to this ticker can I justify?"

## How an AI investment agent enforces this

```python
def passes_ownership_test(proposal):
    if not proposal.business_one_paragraph_summary:
        return Reject("no_business_understanding")
    if proposal.intended_holding_years < 3:
        return Reject("holding_period_too_short_for_ownership_mindset")
    if proposal.sell_triggers.issubset({"price_drop", "price_target_hit"}):
        return Reject("sell_logic_is_price_only_not_business")
    return Allow()
```

If you would not buy the whole company at this implied price, do not buy a share of it either.
