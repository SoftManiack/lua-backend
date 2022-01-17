--\i /home/artem/Soft/test/db/init.sql;
-- CREATE EXTENSION "uuid-ossp";

CREATE TABLE IF NOT EXISTS tariff(
     uid UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),
     name VARCHAR NOT NULL UNIQUE,
     price NUMERIC NOT NULL,
     days INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS client(
     uid UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),
     uid_tariff UUID REFERENCES tariff (uid),
     email VARCHAR NOT NULL,
     name VARCHAR NOT NULL,
     phone VARCHAR NOT NULL,
     tsform TIMESTAMP NOT NULL DEFAULT current_timestamp,
     tsto TIMESTAMP NOT NULL DEFAULT current_timestamp
);

CREATE TABLE IF NOT EXISTS token(
     access VARCHAR PRIMARY KEY NOT NULL,
     tscreate TIMESTAMP NOT NULL DEFAULT current_timestamp,
     expires_in INTEGER NOT NULL,
     tsupdate TIMESTAMP NOT NULL DEFAULT current_timestamp,
     uid_client UUID REFERENCES client (uid) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS balance(
     uid UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),
     uid_client UUID REFERENCES client (uid) ON DELETE CASCADE,
     tsform TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
     tsto TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
     balance NUMERIC NOT NULL
);

CREATE TABLE IF NOT EXISTS operation_type(
     sid VARCHAR PRIMARY KEY NOT NULL,
     name VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS operation(
     uid UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),
     uid_balance UUID REFERENCES balance (uid) ON DELETE CASCADE,
     sid VARCHAR REFERENCES operation_type (sid) ON DELETE CASCADE,
     tsform TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
     amount NUMERIC NOT NULL,
     uid_tariff UUID REFERENCES tariff (uid) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tariff_resources(
     uid UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),
     uid_tariff UUID REFERENCES tariff (uid) ON DELETE CASCADE,
     internet INTEGER NOT NULL,
     sms INTEGER NOT NULL,
     calls INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS client_resources(
     uid UUID PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4(),
     uid_client UUID REFERENCES client (uid) ON DELETE CASCADE,
     internet INTEGER NOT NULL,
     sms INTEGER NOT NULL,
     calls INTEGER NOT NULL
);

INSERT INTO tariff (name, price, days) VALUES
    ('ADA_31', 199, 31),
    ('LUA_00', 249, 31),
    ('PHP_31', 299, 31),
    ('JSX_31', 349, 31),
    ('CSS_31', 699, 60);

INSERT INTO operation_type (sid, name) VALUES
    ('top-up','Пополнение'),
    ('write-downs','Списание');

INSERT INTO tariff_resources (uid_tariff, internet, sms, calls) VALUES
    ( (SELECT uid FROM tariff WHERE name = 'ADA_31'), 10240, 50, 50),
    ( (SELECT uid FROM tariff WHERE name = 'LUA_00'), 15360, 50, 100),
    ( (SELECT uid FROM tariff WHERE name = 'PHP_31'), 40960, 50, 200),
    ( (SELECT uid FROM tariff WHERE name = 'JSX_31'), 102400, 80, 300),
    ( (SELECT uid FROM tariff WHERE name = 'CSS_31'), 512000, 1000, 550);

-- SELECT t.uid, t.name, t.days, t.price, internet, sms, calls
--    FROM tariff AS t
--    JOIN tariff_resources AS r
--        ON r.uid_tariff = t.uid;

--SELECT o.amount, o.tsform, t.name FROM operation AS o
--    JOIN operation_type AS t
--    ON t.uid = o.uid_operation_type AND o.uid_balance = '1d3094a8-6066-4fe7-8e58-ea72af0540de';

--BEGIN;
--    INSERT INTO operation (uid_balance, sid, amount, uid_tariff) VALUES
--        ('%s', 'top-up', '%s', '%s');
--    UPDATE balance
--        SET balance = '%s'
--          ( SELECT SUM(amount) FROM operation WHERE uid_balance = '%s';)
--        WHERE uid_client = '%s';
--COMMIT;
--
--BEGIN;
--    UPDATE client SET uid_tariff = '%s' WHERE uid = '%s'
--    UPDATE balance SET balance = '%s' WHERE uid_client = '%s'
--    INSERT INTO operation (uid_balance, sid, amount, uid_tariff) VALUES
--            ('%s', 'write-downs', '%s', '%s');
--COMMIT;
