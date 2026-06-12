INSERT INTO customers (
    first_name, last_name, email, phone_number, date_of_birth,
    gender, last_login_date, account_status, loyalty_tier, marketing_opt_in
)
VALUES
('Liam','Miller','liam.miller@example.com','+491702222222','1988-07-24','male',CURRENT_TIMESTAMP - INTERVAL '3 days','active','silver',FALSE),

('Sophia','Davis','sophia.davis@example.com',NULL,'1995-01-18','female',CURRENT_TIMESTAMP - INTERVAL '7 days','active','bronze',TRUE),

('Noah','Wilson','noah.wilson@example.com','+491703333333','1992-09-05','male',CURRENT_TIMESTAMP - INTERVAL '2 days','active','platinum',TRUE),

('Olivia','Moore','olivia.moore@example.com','+491704444444','1985-11-30','female',CURRENT_TIMESTAMP - INTERVAL '14 days','inactive','silver',FALSE),

('James','Taylor','james.taylor@example.com',NULL,'1991-06-11','male',CURRENT_TIMESTAMP - INTERVAL '5 days','active','gold',TRUE),

('Ava','Anderson','ava.anderson@example.com','+491705555555','1998-08-22','female',CURRENT_TIMESTAMP - INTERVAL '12 hours','active','bronze',TRUE),

('William','Thomas','william.thomas@example.com','+491706666666','1983-02-14','male',CURRENT_TIMESTAMP - INTERVAL '21 days','suspended','bronze',FALSE),

('Isabella','Jackson','isabella.jackson@example.com',NULL,'1997-12-09','female',CURRENT_TIMESTAMP - INTERVAL '4 days','active','silver',TRUE),

('Benjamin','White','benjamin.white@example.com','+491707777777','1989-04-03','male',CURRENT_TIMESTAMP - INTERVAL '10 days','active','gold',FALSE),

('Mia','Harris','mia.harris@example.com','+491708888888','1994-10-17','female',CURRENT_TIMESTAMP - INTERVAL '6 days','active','platinum',TRUE),

('Lucas','Martin','lucas.martin@example.com',NULL,'1993-05-29','male',CURRENT_TIMESTAMP - INTERVAL '30 days','inactive','bronze',FALSE),

('Charlotte','Thompson','charlotte.thompson@example.com','+491709999999','1987-09-21','female',CURRENT_TIMESTAMP - INTERVAL '9 days','active','gold',TRUE),

('Henry','Garcia','henry.garcia@example.com','+491701212121','1996-01-07','male',CURRENT_TIMESTAMP - INTERVAL '15 days','deleted','silver',FALSE),

('Amelia','Martinez','amelia.martinez@example.com',NULL,'1999-07-15','female',CURRENT_TIMESTAMP - INTERVAL '18 hours','active','bronze',TRUE),

('Elijah','Robinson','elijah.robinson@example.com','+491703434343','1984-03-27','male',CURRENT_TIMESTAMP - INTERVAL '11 days','active','platinum',TRUE),

('Harper','Clark','harper.clark@example.com','+491704545454','1992-12-11','female',CURRENT_TIMESTAMP - INTERVAL '8 days','active','silver',FALSE),

('Alexander','Rodriguez','alexander.rodriguez@example.com',NULL,'1990-08-01','male',CURRENT_TIMESTAMP - INTERVAL '25 days','suspended','gold',TRUE),

('Evelyn','Lewis','evelyn.lewis@example.com','+491705656565','1997-04-19','female',CURRENT_TIMESTAMP - INTERVAL '2 hours','active','bronze',TRUE),

('Michael','Lee','michael.lee@example.com','+491706767676','1986-06-25','prefer_not_to_say',CURRENT_TIMESTAMP - INTERVAL '40 days','inactive','silver',FALSE);


