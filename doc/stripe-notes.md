# Stripe Notes

[[_TOC_]]

## Links

* https://stripe.com
* https://en.wikipedia.org/wiki/Stripe_(company)

* https://stripe.com/docs
* https://stripe.com/docs/development/checklist

## Regulations

* https://stripe.com/docs/strong-customer-authentication
* https://stripe.com/docs/security/guide#validating-pci-compliance

## Test Cards

* https://stripe.com/docs/testing#cards

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

## Python Module

* Git repository at https://github.com/stripe/stripe-python
* https://github.com/dj-stripe/dj-stripe
* https://github.com/jsbronder/asyncio_stripe but now archived

* Stripe Python module is based on `requests` module.
* code is Python 2to3
* it seems they use a code generator, cf. commits "Codegen for openapi ...", but it is not is the source
* design is ??? cf. https://github.com/stripe/stripe-python/issues
  "It definitely would have been better if the library had been written this way originally ..."
* doesn't support asyncio https://github.com/stripe/stripe-python/issues/327
* **module is undocumented :-(**

Usage:
```python
# Set the Secret API Key as a module attribute
stripe.api_key = SECRET_API_KEY

# POST /v1/checkout/sessions
session = stripe.checkout.Session.create(**kwargs)
# or
session = stripe.checkout.Session.create(api_key=SECRET_API_KEY, **kwargs)
```

## Stripe Mock

[stripe-mock](https://github.com/stripe/stripe-mock) is a mock HTTP server that responds like the
real Stripe API. It can be used instead of Stripe's test mode to make test suites integrating with
Stripe faster and less brittle.

## API

* [Stripe API Documentation](https://stripe.com/docs/api)
  https://stripe.com/docs/api?lang=curl to show Curl examples
* [API Errors](https://stripe.com/docs/api/errors)
* [Stripe OpenApi](https://github.com/stripe/openapi)
* Stripe API URL: https://api.stripe.com/v1/...
* HTTPS is mandatory
* POST request must be `Content-Type = application/x-www-form-urlencoded` **NOT JSON :-(**
* but responses are JSON encoded
* Stripe doesn't have an OpenAPI / Swagger online documentation **:-(**

### Httpie example

Authentication using a basic authentication, login using the API secret key and an empty password:
```sh
http -a ${API_SECRET_KEY}: https://api.stripe.com/v1/charges

http -a sk_test_51...UQ: https://api.stripe.com/v1/charges
```

Authentication using a bearer:
```sh
http https://api.stripe.com/v1/charges "Authorization: Bearer ${API_SECRET_KEY}"
```

Get a checkout session
```sh
http -a ${API_SECRET_KEY}: https://api.stripe.com/v1/checkout/sessions/cs_test_a0...Lp
``

To create a checkout session
```sh
http \
  -a ${API_SECRET_KEY}: \
  --form \
  POST https://api.stripe.com/v1/checkout/sessions \
  "line_items[0][price_data][currency]"=eur \
  "line_items[0][price_data][unit_amount]"=1000 \
  "line_items[0][price_data]product_data][name]"="my_product" \
  "line_items[0][quantity]"=1 \
  mode=payment \
  "payment_method_types[0]"=card \
  success_url="https://example.com/success" \
  cancel_url="https://example.com/cancel"
```

```
POST /v1/checkout/sessions HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Authorization: Basic c2tfdGVzdF81MUhkY3piQktRaEN0QTNEOWpZWHZkSXF4dVVmSGlxRjNZWE4wWWNSRTdJTUtYSlJhS3hVQnJTbG1zQnltWVQ0ZHZlQzhHZUVCTlVUeXV2S1JoTkFpWmtlUDAwQ1VCRzBTVVE6
Connection: keep-alive
Content-Length: 351
Content-Type: application/x-www-form-urlencoded; charset=utf-8
Host: api.stripe.com
User-Agent: HTTPie/2.3.0

line_items%5B0%5D%5Bprice_data%5D%5Bcurrency%5D=eur&line_items%5B0%5D%5Bprice_data%5D%5Bunit_amount%5D=1000&line_items%5B0%5D%5Bprice_data%5Dproduct_data%5D%5Bname%5D=my_product&line_items%5B0%5D%5Bquantity%5D=1&mode=payment&payment_method_types%5B0%5D=card&success_url=https%3A%2F%2Fexample.com%2Fsuccess&cancel_url=https%3A%2F%2Fexample.com%2Fcancel
```

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

### Simulate a payment

**Note: seems to be ... :-( ... undocumented ... !**

* stripe-go library source has any occurrence of `payment_page`
* "fixture" occurrences
  https://github.com/stripe/stripe-go/tree/master/testing/openapi/README.md
  https://github.com/stripe/stripe-go/blob/master/scripts/test_with_stripe_mock/main.go

To simulate a payment:

1. create a checkout session and retrieve its id
1. then run this fixture with ```stripe fixtures fixture.json```
   ```js
   {
     "_meta": {
       "template_version": 0
     },
     "fixtures": [
       {
         "name": "payment_page",
         "path": "/v1/payment_pages",
         "method": "get",
         "params": {
           "session_id": "cs_test_a0...aC9"   // <== session_id
         }
       },

       {
         "name": "payment_method",
         "path": "/v1/payment_methods",
         "method": "post",
         "params": {
           "type": "card",
           "card": {
             "token": "tok_visa"
           },
           "billing_details": {
             "email": "stripe@example.com"
           }
         }
       },

       {
         "name": "payment_page_confirm",
         "path": "/v1/payment_pages/${payment_page:id}/confirm",
         "method": "post",
         "params": {
           "payment_method": "${payment_method:id}"
         }
       }
     ]
   }
   ```
