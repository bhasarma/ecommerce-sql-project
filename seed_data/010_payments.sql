INSERT INTO payments (
    order_id,
    payment_method,
    payment_status,
    transaction_id,
    amount,
    currency_code,
    payment_date
)
VALUES
(1,  'card',          'completed',  'TXN-20260612-0001',  89.99,  'EUR', '2026-06-01 10:15:00+02'),
(2,  'paypal',        'completed',  'TXN-20260612-0002', 149.50,  'EUR', '2026-06-01 11:20:00+02'),
(3,  'card',          'completed',  'TXN-20260612-0003',  59.99,  'EUR', '2026-06-02 09:45:00+02'),
(4,  'google_pay',    'completed',  'TXN-20260612-0004',  24.99,  'EUR', '2026-06-02 14:30:00+02'),
(5,  'apple_pay',     'completed',  'TXN-20260612-0005', 199.99,  'EUR', '2026-06-03 16:10:00+02'),
(6,  'bank_transfer', 'completed',  'TXN-20260612-0006', 349.00,  'EUR', '2026-06-03 17:05:00+02'),
(7,  'card',          'completed',  'TXN-20260612-0007',  79.95,  'EUR', '2026-06-04 10:40:00+02'),
(8,  'paypal',        'completed',  'TXN-20260612-0008', 129.99,  'EUR', '2026-06-04 12:15:00+02'),
(9,  'card',          'failed',     'TXN-20260612-0009',  49.99,  'EUR', '2026-06-05 08:55:00+02'),
(10, 'card',          'completed',  'TXN-20260612-0010', 279.99,  'EUR', '2026-06-05 13:50:00+02'),

(11, 'paypal',        'authorized', 'TXN-20260612-0011',  99.99,  'EUR', '2026-06-06 09:00:00+02'),
(12, 'google_pay',    'completed',  'TXN-20260612-0012',  39.95,  'EUR', '2026-06-06 11:45:00+02'),
(13, 'apple_pay',     'completed',  'TXN-20260612-0013', 159.90,  'EUR', '2026-06-07 14:20:00+02'),
(14, 'card',          'refunded',   'TXN-20260612-0014',  89.99,  'EUR', '2026-06-07 15:10:00+02'),
(15, 'bank_transfer', 'completed',  'TXN-20260612-0015', 499.00,  'EUR', '2026-06-08 10:30:00+02'),
(16, 'paypal',        'completed',  'TXN-20260612-0016',  69.99,  'EUR', '2026-06-08 13:25:00+02'),
(17, 'card',          'partially_refunded', 'TXN-20260612-0017', 219.99, 'EUR', '2026-06-09 09:40:00+02'),
(18, 'google_pay',    'completed',  'TXN-20260612-0018',  54.50,  'EUR', '2026-06-09 12:55:00+02'),
(19, 'apple_pay',     'cancelled',  'TXN-20260612-0019', 119.99,  'EUR', '2026-06-10 08:15:00+02'),
(20, 'card',          'pending',    'TXN-20260612-0020', 179.95,  'EUR', NULL);