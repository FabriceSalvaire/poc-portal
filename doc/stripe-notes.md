# Stripe Notes

[[_TOC_]]

## Test Cards

| Type               | Issuer    | Payment  | ID                  |
| ------------------ | --------- | -------- | --------------------|
| French Visa        | Stripe.uk | succeeds | 4000 0025 0000 0003 |
| International Visa | Stripe.us | succeeds | 4242 4242 4242 4242 |
| International Visa | Stripe.us | declined | 4000 0025 0000 3155 |

## How to compute fee

```
P = N + 0.25 + N*f
  = N*(1+f) + 0.25

N = (P - 0.25) / (1 + f)

10*(1+1.4/100) + 0.25 = + 0.39
100                   = + 1.65
500                   = + 7.25
```

## API

### Resent an event

```
> stripe events resend evt_1HgYxPBKQhCtA3D9ro1Z9V1b
```

```js
{
  "id": "evt_1HgYxPBKQhCtA3D9ro1Z9V1b",
  "object": "event",
  "api_version": "2020-08-27",
  "created": 1603731247,
  "data": {
    "object": {
      "id": "cs_test_873IUJbhvZNjltdATfDfGFDgIJcrfFmT0vMkeT5pxNWP6BnijNjTqrrA",
      "object": "checkout.session",
      "allow_promotion_codes": null,
      "amount_subtotal": 5000,
      "amount_total": 5000,
      "billing_address_collection": null,
      "cancel_url": "http://localhost:3000/checkout?canceled=true",
      "client_reference_id": null,
      "currency": "eur",
      "customer": "cus_IH7BaClMwFkpjZ",
      "customer_email": "john.doe@example.com",
      "livemode": false,
      "locale": null,
      "metadata": {
      },
      "mode": "payment",
      "payment_intent": "pi_1HgYuXBKQhCtA3D9az0sivEk",
      "payment_method_types": [
        "card"
      ],
      "payment_status": "paid",
      "setup_intent": null,
      "shipping": null,
      "shipping_address_collection": null,
      "submit_type": null,
      "subscription": null,
      "success_url": "http://localhost:3000/checkout?success=true",
      "total_details": {
        "amount_discount": 0,
        "amount_tax": 0
      }
    }
  },
  "livemode": false,
  "pending_webhooks": 2,
  "request": {
    "id": null,
    "idempotency_key": null
  },
  "type": "checkout.session.completed"
}
```
