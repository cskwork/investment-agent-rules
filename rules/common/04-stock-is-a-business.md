# 4. A Stock Is a Piece of a Business

> "If you aren't willing to own a stock for ten years, don't even think about owning it for ten minutes."
> — Warren Buffett

> "We do not view the company itself as the ultimate owner of our business assets but, instead, view the company as a conduit through which our shareholders own the assets."
> — Berkshire Hathaway *Owner's Manual*

## Why

A stock is not a flashing line on a screen. It is a fractional ownership claim on a real business that hires people, signs leases, ships product, fights competitors, and produces cash. The lifetime value of that ownership is what determines long-term returns. Everything else is noise on top of that signal.

The owner's mindset reframes every decision:

- "Do I want to buy this company?" — not "do I want to buy this ticker?"
- "Would I hold it through five years of closed markets?" — not "what's the chart telling me this week?"
- "Am I happy if the price falls 30% next month and the business is unchanged?" — if the answer is no, the original purchase was speculation, not investment.

An agent that thinks in tickers and price moves will buy and sell the same business many times for no reason. An agent that thinks in businesses will hold what is working and only act when the business changes.

## Checklist

- [ ] Every proposed buy is described as "buy a piece of this business at this implied valuation," not "buy this ticker because of this signal."
- [ ] The agent can answer in one paragraph: what the company sells, who pays, who competes, what scales.
- [ ] The agent is comfortable with the position if the market closes for five years.
- [ ] Price-driven sells (e.g., "it dropped 10%") are blocked unless the business itself has materially changed.
- [ ] Position size respects "how much of this *business* do I want to own?" — not "how much exposure to this ticker can I justify?"

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

If you would not buy the whole company at this implied valuation, do not buy a share of it either.
