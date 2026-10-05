-- 01_create_tables.sql
-- Creates the five tables of the maintenance database.
-- Run this inside a new database named "maintenance".
-- The machines table is the parent; the other four reference it.

CREATE TABLE machines (
    machine_id integer PRIMARY KEY,
    model      varchar(20),
    age        integer
);

CREATE TABLE telemetry (
    reading_time timestamp,
    machine_id   integer REFERENCES machines(machine_id),
    volt         numeric(12,6),
    rotate       numeric(12,6),
    pressure     numeric(12,6),
    vibration    numeric(12,6),
    PRIMARY KEY (machine_id, reading_time)
);

-- The event files can have several rows for the same machine and time,
-- so each event table gets a serial number as its primary key.

CREATE TABLE errors (
    error_no   serial PRIMARY KEY,
    error_time timestamp,
    machine_id integer REFERENCES machines(machine_id),
    error_id   varchar(20)
);

CREATE TABLE maintenance (
    maint_no   serial PRIMARY KEY,
    maint_time timestamp,
    machine_id integer REFERENCES machines(machine_id),
    component  varchar(20)
);

CREATE TABLE failures (
    failure_no   serial PRIMARY KEY,
    failure_time timestamp,
    machine_id   integer REFERENCES machines(machine_id),
    component    varchar(20)
);
