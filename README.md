# Dairy Milk Collection and Quality Monitoring System

**Student:** ISHIMWE Pitie | **Student ID:** 29767
**Course:** INSY 8311 – Database Development with PL/SQL | **Instructor:** Eric Maniraguha
**Repository:** pitie_29767_milkTrack

## Problem Statement
Dairy farmers deliver milk to collection centres every day. Quality is often checked and recorded on paper, so poor-quality batches are accepted by mistake, farmer payments are calculated by hand, and managers learn about repeated rejections too late. This project builds an Oracle database with PL/SQL that records deliveries, tests quality, calculates payments, and raises alerts automatically.

## Objectives
**Main objective:** Build an Oracle PL/SQL database that records milk deliveries, enforces quality rules and automatically alerts managers about rejected batches.

**Specific objectives:**
1. Record farmers, collection centres, daily deliveries and quality tests in a normalized (3NF) schema.
2. Accept or reject each batch with PL/SQL based on quality rules, and calculate farmer payments.
3. Block invalid data with triggers and record every rejected attempt in an audit log.
4. Run a nightly scheduled job that flags centres with repeated rejected batches and creates alerts.

## Data Source
- **Dataset:** Milk Quality dataset (Kaggle) – pH, temperature, taste, odour, fat, turbidity, colour and quality grade per sample.
- **Link:** https://www.kaggle.com/datasets/cpluzshrijayan/milkquality *(confirm link on Kaggle)*
- **Size:** about 1,000 records *(confirm after download)*
- **Licence:** *(copy the licence from the Kaggle page; must allow educational use)*
- **Personal data:** none. Farmers and collection centres are modelled with non-identifying, simulated records around the real quality data.

## Innovation
**Option:** Smart automation.
**Tool:** DBMS_SCHEDULER (nightly job), with optional UTL_MAIL email alerts.
A nightly job finds centres with repeated rejected batches and writes alerts to an alerts table for the manager.

## Planned Tables
Farmers, Collection_Centres, Milk_Deliveries, Quality_Tests, Payment_Rates, Payments, Alerts, Audit_Log.

## Planned PL/SQL Features
- **Procedure `record_delivery`:** saves a delivery and its quality test, then accepts or rejects the batch.
- **Function `calculate_payment`:** returns a farmer's payment from accepted litres and the current rate.
- **Cursor:** loops through collection centres to count recent rejections.
- **Package `milk_pkg`:** groups the delivery, payment and alert logic.
- **Trigger:** blocks impossible values (for example pH outside 0–14) and writes the denied attempt to `Audit_Log`.
- **Exceptions:** handle unknown farmers, invalid quantities and duplicate deliveries.
- **Scheduler job:** runs nightly and creates alerts for centres with repeated rejections.

## Folder Structure
- `docs/research/` – research log
- `docs/proposal/` – proposal
- `docs/presentation/` – slides
- `data/` – dataset

## References



## Phase I – Business Process Modeling


I used draw .ai and the link it is bellow

https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=MILK%20DELIVERY%20COLLECTION%20AND%20MONITORING%20SYSTEM.drawio&dark=auto#R%3Cmxfile%3E%3Cdiagram%20name%3D%22Page-1%22%20id%3D%22MrtOLcojdqimwEW-s0jg%22%3E7V1rc6M2F%2F41ntl%2BSIa7zcfE2XQ7k7TZzb7zdj91ZCPbNBi5gGN7f30lkLgIYmTZgjj1TmaNhBBwnqNz05EYmOPl9tcIrBaPyIPBwNC87cC8GxiG7WgG%2FiE1u6xGdxxaM498j9YVFc%2F%2BT0grNVq79j0YVxomCAWJv6pWTlEYwmlSqQNRhDbVZjMUVO%2B6AnNYq3iegqBe%2B3%2FfSxZZ7cjWivov0J8v2J11jZ5ZAtaYVsQL4KFNqcr8PDDHEUJJdrTcjmFAqMfokl13%2F8bZ%2FMEiGCYiFzxuf%2F9ta0RX9z9vvvz0t%2F9M7r58vRrWe6Edx8mO0SDe%2BMsAhLh0O134gfcAdmhNWscJmL6w0m0EYwzfE%2BtK56oeAeEKDdcuUOT%2FRGECAtoM9xMlFHuz2uKZ3IJdlyzZFdkzvoJgTZ%2FxzgfRjpDdD15SdggCzA4%2BCsnbRWgK45heA6MEbkuvSqn1K0RLmKR9LEqAmhS9TQG%2Bbjm0knZzZTLQKZe7rAwo983zzvP7fcOPB8I5pnHrDbnb5Rz11t1AkMAoBAm8RevQi8tcgQ9Kr1pUpbxyAN%2BMDuSbMsJGjQfawL0H0RJGcvjZUgCaewCs0PJQwukNI24fhUvkXCE%2FTNLnsW%2Fxn3atW%2FbAGOe%2FAxu3GqdnsnK1bmQ3t9bTWr4H1pr%2Bcn3rXB17klrrat%2F4D7PCAqzIGy23c6IzrierZXgNX1NqlLmAAO1jQfwAJjB4QrGfjmbzboKSBC1xg4CcuMXiYR4RPh%2BjAEUppcxZ%2Bq%2FUx03gz8m1CVrhWkBLU3xPzFbm7QpGPoaXHN9hDLFugU9FFR5FSeCHcJyrGMKvIF5lhZm%2FhV7RKhOLoQciUhnvlhNE3mgOQxgRZq9ztxRfN7C1XWVqu8rSQ1sVR7vSHJ3iRoiXAr5Z%2BAl8XoEpObvBvNEm8mHgvxKxoD36gf%2BSWga86KcQy1DYaRAcBieJTY7GqqQGE67Qq1krgkRH62gKBeRSCR1ys2dahMEEbT4XFbczLLupPNeNKlAw9G6I5UXGaoCmL98XfphV3%2FsBa1RATwYT3PrJn%2BxyfPyD1GO5kZXutqVmd7tSoTRK07rGsVWHOYIBSDDvVEhZxtlp199PRBoXrKDzStmt9pABQC8qW2lcPzxLue61MXKLf061W6xW5zCpdXsqNW%2BYx%2FJdP%2BwU4tf%2Bs1woMRQpFhyVlnYV9slouo8qRn98lssY5lDxloooo1lmS0eKWcuW56Tj1AY2vH1sbqS33i0hfTsF2kHP4WUk1lXpB9u4WJUf3arEAq9sUOJOlj5x8owObUrdtHmWVmVW2kernjaTx657rGUdhaJkgeYoBEFZUVUVTdHmAREmSFnsb5gkO6rMwBrbpFV1JmPqSOqztNRsI7UqOfsQnXZ6p0Krg60wwDCmboI2DWD0IjV4jJFMoEHPLzu9zyCqExitT6hh536c0ZP6aPhtnIBIYs9%2FxYdzcvhpRqM648BPIhj%2Fwtrgty01U6WdTc7%2BsZXhYPWFw3cYJ5l3TJzjr2usoZJGJFZfMArf4XKFf2Ygue4YClvvCgpXVqc0YNOhP9Oo3jtxNyw%2BiiTp1vIQD3t1a03pcEq%2FfKDYr2USsQ9Gs2uGpaRfO9RbOlLMWw3RUIWGyx1IwATExJuNd1jnLvHBJxQBbMc8PeDnf%2F768IuU2Lab5Ha7OWPvQ%2F4o2W02WIT7ADhlvABF3lVuyZg3DSoUt%2Fc97IyRN8d%2BGr49SEMMHoyYAURPJKlS7lK9OqOO1KsprV4ZZm0um2nsFb%2BKXbbCTftROiMenS7EdyGxf1QE9nHi2z5AWp8efFF3oz4%2BayEoI4v7GCIBqGFj2%2BbwE207FAk%2BGc1tRUNPcywMNmDH6fyeok%2FRAi0n67g1%2BlQEm0KUKScWbaLl%2Beb7Ln1XuJ0G6zhlqs6CTyMunGqrCj2ZlnI51q8ZKRGC6s8yHLoHuQ6idiLPTT17JHZP1s33yJ%2FP01BNyj0xYfswxWMcoDl5bEIzn8yl36w9P%2FnrgdSqMVRGhl21JpXFxix5Y%2FIyX3KZL5FWWYarjKOlQxrCOss%2BG9tb0s4%2BZrrE0pr5pRvj27JVo29dPK89xLH6BJ%2BZKjQFHkwYQKJKzmoe2anIr%2BJRk9m8aF%2F6npdBTzK%2F6aMQSlbV5l2TDP4dCUvhRsKyoBT23QxNr8hd923Sc9bhrhErNJvFUE0ajPaxR%2B6xGX2KQ97W6MiR%2B0Y2IJ%2F6g70Le6hbxij7n%2BNHxc4F44BLaOYSmlFj5%2Bqa3VFsxpJOCzqPGHNf8vIo2%2FeQYNDpOWKoXINa52L7igLm9AqYaEKMmpm89D3%2FxpIVksMJSKYL%2FPspRIM8I1huylQkJVjTOwtxOadT%2BpcQ1yXEJaz6Fca4GladdiI4xiCYrrFohH%2BxJQONSQBTtFyt6zkALM9RW9HlBl1O%2Fus6P%2FuvLGFbuR5mWwf8tywzQZ1uH6vT3%2FBkrSr7mBY3ut%2BYbztZfERejR055tdRjKI0rLYm2pBQcpoO35r5AMnZVZY%2Frna9KRdVMJUtKHKUTyfY%2B1cI%2FrcHs9PrbIItr2cv8aJLvEjAaLS4VaymoUqQ2cpzEpmGOgNB1scysmMD7Mepsb6ShscRpNnAAR47A5ZBQwpxSjYyM6bISnB03kpQZfIzg%2FwSY%2Fi4MYamzWwSf5n21ZW6cDtjaPnQ5IWhz4Sh30PQjLd%2FjH0bxh3H0cozg%2Fp15KqzI7nJc3RmkK7QJnJ6TRcaUbyk04UYS32MdCHtWjMdpzIar3TxMFl%2BSfUKdQlDLHdEQkVhMnFSvMmsjZMIvUAmr6m3OPODgKs6ANz9i5kJkLmdHEJImsqI3fadMy3Gumz2jQ9mni4nz%2FxoKLFpiwmbsSBLT7MmhBL3pWmNyVGTGu0wjvi1wqpQ1Nn2xRIwZgCxPYO54BFvZc0CtJkuQJRce2xBbzPspzFQGpzIFhJbytb16g0kPt2CaSEa3v6Gyx6IFxNEHB0Zilp6g1%2Feuly6cN1Pb%2FeJxnAZ%2FS%2BuzPm5Mu%2FBNx9qXWW0DOkrSOzawXi8dYa5Lsc%2FWCx3IOaiDA%2BxpE8vvERt3AbhdVzc9gEBjyiDfNuqcTbZm%2B0mnKV15NtGal5mAs0iRPbdyLbdYNFdue3mRVZJ8ht3Ktt1mHWscsCd9SzwkWOkOeOCx9fQul2KPDwY5FMNvv%2Bt6BYqhS1m3uTjLyaavp50lW0exw%2FOekZGp0lXGr%2Fzq7Ixqjc4mh2bz48gBHPJpBdLk7KbbWXfZ3BE840Y4U%2BYnfzqw00pFJIx9AwF2DnEB%2BtVSqZkMVCdZsRPIOrKotND0TCJOmonCypx5J0%2FIYnA79utjqaiXxhpoOnF8zsTz%2B89TGLptb3o1fG0%2FMadjMnbLNFhfTS8V0u0hzSeTKj0NmV1MNoXkXYRaTL7tfC%2BNQtunZ6l5YNZohLNuSQmtsqU3iSa8KbgdYn2TicI8z3071OPJV0eQXwWiYEqMAXYWRBMF%2FrU4TvFhG79%2Fg0Cb3cqJFzOOecXpRQLAk%2BfzC2yMSMDp3VV9%2FnkLRU5So5jVUWkO3QUCkm732kAkRWFonAzLn0PcKvZvkwQU6fXxf9D54SYDuuC%2BP1jahlOGdUr7VrTLIVjOHNsezN0GrIKz0Z93sGpH2dTf0vgyS3YaLdlXG6FtjFUFkcZNWwzezZoPE8X0FsHqWEZwVkE44UiRCx%2BvsFUlv40EvoC%2BztF5DP9skGYElcNFlcGPxuh7uPc7jkLqx%2BSKQcCH5znna2Rshwf1zhjBGopst%2FgiiwDzARWPo3daa6szsfoXWWizG2IaZwNdgesJjgMAJvT7rqjbH8c95y1uzrx5fDiy1GWMO6eszZXhwD%2FCQeVCJxzuK6mQPJvNuL3iWPY8TqLIT9wbGVRVrch4%2FNsYCs%2BcoqfH7%2BmIk2ucVsx6erm2%2FOezxKPzyGLcMzWsbLFZLUvFroK4dgTJHv3cNzSLTaLbbPUSKsaHgrXhYnsQiwaxcxXmZWgJBmweW4bKTyBBKNAyI4VHI0XCnz4Kc32ZM3QK8nxzOpomyy46NFYpzOo5odaVW5662OkasLUboN6FI5jHvTJKUwfsCs1oCkjJS6pf66Uj9lpvEss%2FL1Sq60nxfneunbORusfJ1h0IeBC6DxIEiuHcTFCKCmjR1J5HpFH1s1%2F%2Fhc%3D%3C%2Fdiagram%3E%3C%2Fmxfile%3E#%7B%22pageId%22%3A%22MrtOLcojdqimwEW-s0jg%22%7D
