# Creating Table

- PostgreSQL automatically creates an unique index for a UNIQUE constraint. Therefore it is not necessary to write `CREATE INDEX` for email. This is redundant. It also creates index automatically for `PRIMARY KEY`, but not for `FOREIGN KEY`.

## Running the script

- step 1:`~$ sudo -u postgres psql`
- step 2: create a database:
  `postgres=# CREATE DATABASE ecommerce_db`
- step 3: connect to the database:
  `postgres=# \c ecommerce_db`
- step 4: run the first script:
- `\l` to show list of databases

```bash
(base) bsarma@turing:~/git-repos/ecommerce-sql-project/sql$ ls -l
total 4
-rw-rw-r-- 1 bsarma bsarma 1142 Jun 10 17:15 001_create_customers.sql
(base) bsarma@turing:~/git-repos/ecommerce-sql-project/sql$ sudo -u postgres psql -d ecommerce_db -f 001_create_customers.sql
[sudo] password for bsarma: 
CREATE TABLE
CREATE INDEX
CREATE INDEX
```

- verify insdie `psql`:
  
```bash
ecommerce_db=# \dt
           List of relations
 Schema |   Name    | Type  |  Owner   
--------+-----------+-------+----------
 public | customers | table | postgres
(1 row)
```

- show table definitions:

```bash
ecommerce_db=# \d customers
                                              Table "public.customers"
      Column      |           Type           | Collation | Nullable |                    Default                     
------------------+--------------------------+-----------+----------+------------------------------------------------
 customer_id      | bigint                   |           | not null | nextval('customers_customer_id_seq'::regclass)
 first_name       | text                     |           | not null | 
 last_name        | text                     |           | not null | 
 email            | character varying(255)   |           | not null | 
 phone_number     | character varying(30)    |           |          | 
 date_of_birth    | date                     |           |          | 
 gender           | character varying(20)    |           |          | 
 last_login_date  | timestamp with time zone |           |          | 
 account_status   | character varying(20)    |           | not null | 'active'::character varying
 loyalty_tier     | character varying(20)    |           | not null | 'bronze'::character varying
 marketing_opt_in | boolean                  |           | not null | false
 created_at       | timestamp with time zone |           | not null | CURRENT_TIMESTAMP
 updated_at       | timestamp with time zone |           | not null | CURRENT_TIMESTAMP
Indexes:
    "customers_pkey" PRIMARY KEY, btree (customer_id)
    "customers_email_key" UNIQUE CONSTRAINT, btree (email)
    "idx_customers_account_status" btree (account_status)
    "idx_customers_created_at" btree (created_at)
Check constraints:
    "customers_account_status_check" CHECK (account_status::text = ANY (ARRAY['active'::character varying, 'inactive'::character varying, 'suspended'::character varying, 'deleted'::character varying]::text[]))
    "customers_gender_check" CHECK (gender::text = ANY (ARRAY['male'::character varying, 'female'::character varying, 'non-binary'::character varying, 'prefer_not_to_say'::character varying]::text[]))
    "customers_loyalty_tier_check" CHECK (loyalty_tier::text = ANY (ARRAY['bronze'::character varying, 'silver'::character varying, 'gold'::character varying, 'platinum'::character varying]::text[]))

```

## To Do

- triggers for updated_at: in table e.g. in adresses, add a postgres trigger so that when a row changes in some column, updated at triggers. Now updated_at triggers only on insert.
- default address constraint: in table addresses, add only one default shipping and billing address per customer.