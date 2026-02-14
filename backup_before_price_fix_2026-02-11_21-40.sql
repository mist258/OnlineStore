--
-- PostgreSQL database dump
--

\restrict aAeDnK4fPtX4VOqdkS14OwMtMVEyqf0neIKUPNeBDUuCtWvQSbaRmgrfbbWERJd

-- Dumped from database version 17.4
-- Dumped by pg_dump version 18.1

-- Started on 2026-02-11 19:40:44 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 13 (class 2615 OID 16492)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- TOC entry 12 (class 2615 OID 16622)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- TOC entry 11 (class 2615 OID 16611)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- TOC entry 8 (class 2615 OID 16386)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 9 (class 2615 OID 43825)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4445 (class 0 OID 0)
-- Dependencies: 9
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 6 (class 2615 OID 16603)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- TOC entry 14 (class 2615 OID 16540)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- TOC entry 10 (class 2615 OID 16651)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- TOC entry 3 (class 3079 OID 16687)
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- TOC entry 4450 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- TOC entry 2 (class 3079 OID 16652)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 4451 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 1129 (class 1247 OID 16780)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 1153 (class 1247 OID 16921)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 1126 (class 1247 OID 16774)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1123 (class 1247 OID 16769)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1210 (class 1247 OID 137045)
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1222 (class 1247 OID 137117)
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1192 (class 1247 OID 131455)
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1213 (class 1247 OID 137054)
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1159 (class 1247 OID 16963)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1183 (class 1247 OID 17132)
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- TOC entry 1174 (class 1247 OID 17090)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- TOC entry 1177 (class 1247 OID 17105)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- TOC entry 1189 (class 1247 OID 17176)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- TOC entry 1186 (class 1247 OID 17147)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- TOC entry 1204 (class 1247 OID 82001)
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- TOC entry 411 (class 1255 OID 16538)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 4452 (class 0 OID 0)
-- Dependencies: 411
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 424 (class 1255 OID 16751)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 410 (class 1255 OID 16537)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 4455 (class 0 OID 0)
-- Dependencies: 410
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 409 (class 1255 OID 16536)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 4457 (class 0 OID 0)
-- Dependencies: 409
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 408 (class 1255 OID 16387)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- TOC entry 439 (class 1255 OID 17169)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 445 (class 1255 OID 17250)
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- TOC entry 441 (class 1255 OID 17181)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- TOC entry 437 (class 1255 OID 17127)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- TOC entry 436 (class 1255 OID 17122)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- TOC entry 440 (class 1255 OID 17177)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- TOC entry 442 (class 1255 OID 17190)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 435 (class 1255 OID 17121)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- TOC entry 444 (class 1255 OID 17249)
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- TOC entry 434 (class 1255 OID 17119)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- TOC entry 438 (class 1255 OID 17158)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- TOC entry 443 (class 1255 OID 17243)
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- TOC entry 449 (class 1255 OID 81979)
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


ALTER FUNCTION storage.add_prefixes(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 430 (class 1255 OID 17028)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 461 (class 1255 OID 219032)
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


ALTER FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- TOC entry 450 (class 1255 OID 81980)
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


ALTER FUNCTION storage.delete_prefix(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 453 (class 1255 OID 81983)
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


ALTER FUNCTION storage.delete_prefix_hierarchy_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 458 (class 1255 OID 81998)
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- TOC entry 427 (class 1255 OID 17002)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 426 (class 1255 OID 17001)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 425 (class 1255 OID 17000)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 446 (class 1255 OID 81961)
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 447 (class 1255 OID 81977)
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 448 (class 1255 OID 81978)
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 456 (class 1255 OID 81996)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 432 (class 1255 OID 17067)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 431 (class 1255 OID 17030)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 460 (class 1255 OID 219031)
-- Name: lock_top_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket text;
    v_top text;
BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));
        END LOOP;
END;
$$;


ALTER FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- TOC entry 462 (class 1255 OID 219033)
-- Name: objects_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- TOC entry 452 (class 1255 OID 81982)
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_insert_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 463 (class 1255 OID 219034)
-- Name: objects_update_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    -- NEW - OLD (destinations to create prefixes for)
    v_add_bucket_ids text[];
    v_add_names      text[];

    -- OLD - NEW (sources to prune)
    v_src_bucket_ids text[];
    v_src_names      text[];
BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NULL;
    END IF;

    -- 1) Compute NEW−OLD (added paths) and OLD−NEW (moved-away paths)
    WITH added AS (
        SELECT n.bucket_id, n.name
        FROM new_rows n
        WHERE n.name <> '' AND position('/' in n.name) > 0
        EXCEPT
        SELECT o.bucket_id, o.name FROM old_rows o WHERE o.name <> ''
    ),
    moved AS (
         SELECT o.bucket_id, o.name
         FROM old_rows o
         WHERE o.name <> ''
         EXCEPT
         SELECT n.bucket_id, n.name FROM new_rows n WHERE n.name <> ''
    )
    SELECT
        -- arrays for ADDED (dest) in stable order
        COALESCE( (SELECT array_agg(a.bucket_id ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        COALESCE( (SELECT array_agg(a.name      ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        -- arrays for MOVED (src) in stable order
        COALESCE( (SELECT array_agg(m.bucket_id ORDER BY m.bucket_id, m.name) FROM moved m), '{}' ),
        COALESCE( (SELECT array_agg(m.name      ORDER BY m.bucket_id, m.name) FROM moved m), '{}' )
    INTO v_add_bucket_ids, v_add_names, v_src_bucket_ids, v_src_names;

    -- Nothing to do?
    IF (array_length(v_add_bucket_ids, 1) IS NULL) AND (array_length(v_src_bucket_ids, 1) IS NULL) THEN
        RETURN NULL;
    END IF;

    -- 2) Take per-(bucket, top) locks: ALL prefixes in consistent global order to prevent deadlocks
    DECLARE
        v_all_bucket_ids text[];
        v_all_names text[];
    BEGIN
        -- Combine source and destination arrays for consistent lock ordering
        v_all_bucket_ids := COALESCE(v_src_bucket_ids, '{}') || COALESCE(v_add_bucket_ids, '{}');
        v_all_names := COALESCE(v_src_names, '{}') || COALESCE(v_add_names, '{}');

        -- Single lock call ensures consistent global ordering across all transactions
        IF array_length(v_all_bucket_ids, 1) IS NOT NULL THEN
            PERFORM storage.lock_top_prefixes(v_all_bucket_ids, v_all_names);
        END IF;
    END;

    -- 3) Create destination prefixes (NEW−OLD) BEFORE pruning sources
    IF array_length(v_add_bucket_ids, 1) IS NOT NULL THEN
        WITH candidates AS (
            SELECT DISTINCT t.bucket_id, unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(v_add_bucket_ids, v_add_names) AS t(bucket_id, name)
            WHERE name <> ''
        )
        INSERT INTO storage.prefixes (bucket_id, name)
        SELECT c.bucket_id, c.name
        FROM candidates c
        ON CONFLICT DO NOTHING;
    END IF;

    -- 4) Prune source prefixes bottom-up for OLD−NEW
    IF array_length(v_src_bucket_ids, 1) IS NOT NULL THEN
        -- re-entrancy guard so DELETE on prefixes won't recurse
        IF current_setting('storage.gc.prefixes', true) <> '1' THEN
            PERFORM set_config('storage.gc.prefixes', '1', true);
        END IF;

        PERFORM storage.delete_leaf_prefixes(v_src_bucket_ids, v_src_names);
    END IF;

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_update_cleanup() OWNER TO supabase_storage_admin;

--
-- TOC entry 465 (class 1255 OID 219039)
-- Name: objects_update_level_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Set the new level
        NEW."level" := "storage"."get_level"(NEW."name");
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_level_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 457 (class 1255 OID 81997)
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 433 (class 1255 OID 17083)
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- TOC entry 464 (class 1255 OID 219035)
-- Name: prefixes_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.prefixes_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- TOC entry 451 (class 1255 OID 81981)
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.prefixes_insert_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 428 (class 1255 OID 17017)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 455 (class 1255 OID 81994)
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 454 (class 1255 OID 81993)
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 459 (class 1255 OID 219030)
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    sort_col text;
    sort_ord text;
    cursor_op text;
    cursor_expr text;
    sort_expr text;
BEGIN
    -- Validate sort_order
    sort_ord := lower(sort_order);
    IF sort_ord NOT IN ('asc', 'desc') THEN
        sort_ord := 'asc';
    END IF;

    -- Determine cursor comparison operator
    IF sort_ord = 'asc' THEN
        cursor_op := '>';
    ELSE
        cursor_op := '<';
    END IF;
    
    sort_col := lower(sort_column);
    -- Validate sort column  
    IF sort_col IN ('updated_at', 'created_at') THEN
        cursor_expr := format(
            '($5 = '''' OR ROW(date_trunc(''milliseconds'', %I), name COLLATE "C") %s ROW(COALESCE(NULLIF($6, '''')::timestamptz, ''epoch''::timestamptz), $5))',
            sort_col, cursor_op
        );
        sort_expr := format(
            'COALESCE(date_trunc(''milliseconds'', %I), ''epoch''::timestamptz) %s, name COLLATE "C" %s',
            sort_col, sort_ord, sort_ord
        );
    ELSE
        cursor_expr := format('($5 = '''' OR name COLLATE "C" %s $5)', cursor_op);
        sort_expr := format('name COLLATE "C" %s', sort_ord);
    END IF;

    RETURN QUERY EXECUTE format(
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    NULL::uuid AS id,
                    updated_at,
                    created_at,
                    NULL::timestamptz AS last_accessed_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
            UNION ALL
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    id,
                    updated_at,
                    created_at,
                    last_accessed_at,
                    metadata
                FROM storage.objects
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
        ) obj
        ORDER BY %s
        LIMIT $3
        $sql$,
        cursor_expr,    -- prefixes WHERE
        sort_expr,      -- prefixes ORDER BY
        cursor_expr,    -- objects WHERE
        sort_expr,      -- objects ORDER BY
        sort_expr       -- final ORDER BY
    )
    USING prefix, bucket_name, limits, levels, start_after, sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- TOC entry 429 (class 1255 OID 17018)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 296 (class 1259 OID 16523)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 4476 (class 0 OID 0)
-- Dependencies: 296
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 313 (class 1259 OID 16925)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 4478 (class 0 OID 0)
-- Dependencies: 313
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- TOC entry 304 (class 1259 OID 16723)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 4480 (class 0 OID 0)
-- Dependencies: 304
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 4481 (class 0 OID 0)
-- Dependencies: 304
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 295 (class 1259 OID 16516)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 4483 (class 0 OID 0)
-- Dependencies: 295
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 308 (class 1259 OID 16812)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 4485 (class 0 OID 0)
-- Dependencies: 308
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 307 (class 1259 OID 16800)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 4487 (class 0 OID 0)
-- Dependencies: 307
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 306 (class 1259 OID 16787)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 4489 (class 0 OID 0)
-- Dependencies: 306
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 4490 (class 0 OID 0)
-- Dependencies: 306
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- TOC entry 388 (class 1259 OID 137057)
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- TOC entry 390 (class 1259 OID 196809)
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4493 (class 0 OID 0)
-- Dependencies: 390
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- TOC entry 383 (class 1259 OID 131459)
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- TOC entry 389 (class 1259 OID 137090)
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- TOC entry 314 (class 1259 OID 16975)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 294 (class 1259 OID 16505)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 4498 (class 0 OID 0)
-- Dependencies: 294
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 293 (class 1259 OID 16504)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 4500 (class 0 OID 0)
-- Dependencies: 293
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 311 (class 1259 OID 16854)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4502 (class 0 OID 0)
-- Dependencies: 311
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 312 (class 1259 OID 16872)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4504 (class 0 OID 0)
-- Dependencies: 312
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 297 (class 1259 OID 16531)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 4506 (class 0 OID 0)
-- Dependencies: 297
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 305 (class 1259 OID 16753)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 4508 (class 0 OID 0)
-- Dependencies: 305
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 4509 (class 0 OID 0)
-- Dependencies: 305
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 4510 (class 0 OID 0)
-- Dependencies: 305
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- TOC entry 4511 (class 0 OID 0)
-- Dependencies: 305
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- TOC entry 310 (class 1259 OID 16839)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 4513 (class 0 OID 0)
-- Dependencies: 310
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 309 (class 1259 OID 16830)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4515 (class 0 OID 0)
-- Dependencies: 309
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 4516 (class 0 OID 0)
-- Dependencies: 309
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 292 (class 1259 OID 16493)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 4518 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 4519 (class 0 OID 0)
-- Dependencies: 292
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 396 (class 1259 OID 263310)
-- Name: accessory_photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accessory_photo (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    photo character varying(255),
    accessory_id bigint NOT NULL
);


ALTER TABLE public.accessory_photo OWNER TO postgres;

--
-- TOC entry 395 (class 1259 OID 263309)
-- Name: accessory_photo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.accessory_photo ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.accessory_photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 333 (class 1259 OID 116607)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 116606)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 335 (class 1259 OID 116615)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 116614)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 331 (class 1259 OID 116601)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 116600)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 337 (class 1259 OID 116647)
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id bigint NOT NULL,
    email character varying(50) NOT NULL,
    avatar character varying(255),
    is_superuser boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    subscription_updates_news boolean NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 116655)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    usermodel_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- TOC entry 338 (class 1259 OID 116654)
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 336 (class 1259 OID 116646)
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 341 (class 1259 OID 116661)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    usermodel_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- TOC entry 340 (class 1259 OID 116660)
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 380 (class 1259 OID 126971)
-- Name: basket_basket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.basket_basket (
    id bigint NOT NULL,
    guest_token uuid,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    is_active boolean NOT NULL,
    discount_code_id bigint,
    user_id bigint
);


ALTER TABLE public.basket_basket OWNER TO postgres;

--
-- TOC entry 379 (class 1259 OID 126970)
-- Name: basket_basket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.basket_basket ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.basket_basket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 382 (class 1259 OID 126979)
-- Name: basket_basketitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.basket_basketitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    accessory_id bigint,
    basket_id bigint NOT NULL,
    product_id bigint,
    supply_id bigint,
    CONSTRAINT basket_basketitem_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.basket_basketitem OWNER TO postgres;

--
-- TOC entry 381 (class 1259 OID 126978)
-- Name: basket_basketitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.basket_basketitem ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.basket_basketitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 378 (class 1259 OID 126960)
-- Name: discount_codes_discountcode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount_codes_discountcode (
    id bigint NOT NULL,
    code character varying(50) NOT NULL,
    description text NOT NULL,
    discount_percent numeric(5,2) NOT NULL,
    active boolean NOT NULL,
    valid_from timestamp with time zone,
    valid_to timestamp with time zone
);


ALTER TABLE public.discount_codes_discountcode OWNER TO postgres;

--
-- TOC entry 377 (class 1259 OID 126959)
-- Name: discount_codes_discountcode_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.discount_codes_discountcode ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.discount_codes_discountcode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 345 (class 1259 OID 116711)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- TOC entry 344 (class 1259 OID 116710)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 349 (class 1259 OID 116753)
-- Name: django_celery_results_chordcounter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_celery_results_chordcounter (
    id integer NOT NULL,
    group_id character varying(255) NOT NULL,
    sub_tasks text NOT NULL,
    count integer NOT NULL,
    CONSTRAINT django_celery_results_chordcounter_count_check CHECK ((count >= 0))
);


ALTER TABLE public.django_celery_results_chordcounter OWNER TO postgres;

--
-- TOC entry 348 (class 1259 OID 116752)
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_celery_results_chordcounter ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_celery_results_chordcounter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 351 (class 1259 OID 116765)
-- Name: django_celery_results_groupresult; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_celery_results_groupresult (
    id integer NOT NULL,
    group_id character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_done timestamp with time zone NOT NULL,
    content_type character varying(128) NOT NULL,
    content_encoding character varying(64) NOT NULL,
    result text
);


ALTER TABLE public.django_celery_results_groupresult OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 116764)
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_celery_results_groupresult ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_celery_results_groupresult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 347 (class 1259 OID 116732)
-- Name: django_celery_results_taskresult; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_celery_results_taskresult (
    id integer NOT NULL,
    task_id character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    content_type character varying(128) NOT NULL,
    content_encoding character varying(64) NOT NULL,
    result text,
    date_done timestamp with time zone NOT NULL,
    traceback text,
    meta text,
    task_args text,
    task_kwargs text,
    task_name character varying(255),
    worker character varying(100),
    date_created timestamp with time zone NOT NULL,
    periodic_task_name character varying(255),
    date_started timestamp with time zone
);


ALTER TABLE public.django_celery_results_taskresult OWNER TO postgres;

--
-- TOC entry 346 (class 1259 OID 116731)
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_celery_results_taskresult ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_celery_results_taskresult_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 329 (class 1259 OID 116593)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 116592)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 327 (class 1259 OID 116561)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 116560)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 368 (class 1259 OID 116911)
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- TOC entry 387 (class 1259 OID 134797)
-- Name: favorites_favoriteitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorites_favoriteitem (
    id bigint NOT NULL,
    added_at timestamp with time zone NOT NULL,
    accessory_id bigint,
    product_id bigint,
    supply_id bigint,
    favorites_id bigint NOT NULL
);


ALTER TABLE public.favorites_favoriteitem OWNER TO postgres;

--
-- TOC entry 386 (class 1259 OID 134796)
-- Name: favorites_favoriteitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.favorites_favoriteitem ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.favorites_favoriteitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 385 (class 1259 OID 134791)
-- Name: favorites_favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorites_favorites (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.favorites_favorites OWNER TO postgres;

--
-- TOC entry 384 (class 1259 OID 134790)
-- Name: favorites_favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.favorites_favorites ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.favorites_favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 353 (class 1259 OID 116784)
-- Name: flavor_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flavor_profile (
    id bigint NOT NULL,
    name character varying(30)
);


ALTER TABLE public.flavor_profile OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 116783)
-- Name: flavor_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.flavor_profile ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.flavor_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 365 (class 1259 OID 116860)
-- Name: order_positions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_positions (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    date timestamp with time zone NOT NULL,
    accessory_id bigint,
    order_id bigint NOT NULL,
    product_id bigint,
    price numeric(8,2) NOT NULL,
    CONSTRAINT exactly_one_product_or_accessory CHECK ((((product_id IS NOT NULL) AND (accessory_id IS NULL)) OR ((product_id IS NULL) AND (accessory_id IS NOT NULL))))
);


ALTER TABLE public.order_positions OWNER TO postgres;

--
-- TOC entry 364 (class 1259 OID 116859)
-- Name: order_positions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.order_positions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.order_positions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 363 (class 1259 OID 116852)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    order_notes text,
    status character varying(50) NOT NULL,
    ttn character varying(50),
    created_at timestamp with time zone NOT NULL,
    customer_id bigint NOT NULL,
    discount_code_id bigint,
    apartment_number character varying(50),
    company_name character varying(255),
    country character varying(100) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    phone_number character varying(30) NOT NULL,
    region character varying(100),
    state character varying(100),
    street_name character varying(255),
    zip_code character varying(20),
    updated_at timestamp with time zone NOT NULL,
    currency character varying(3) NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 362 (class 1259 OID 116851)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.orders ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 359 (class 1259 OID 116806)
-- Name: photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photo (
    id bigint NOT NULL,
    url character varying(255),
    "position" integer NOT NULL,
    accessory_id bigint,
    product_id bigint
);


ALTER TABLE public.photo OWNER TO postgres;

--
-- TOC entry 358 (class 1259 OID 116805)
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.photo ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 355 (class 1259 OID 116790)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id bigint NOT NULL,
    sku character varying(50) NOT NULL,
    name character varying(100),
    brand character varying(100),
    caffeine_type character varying(18),
    sort character varying(25),
    roast character varying(13),
    description text NOT NULL,
    is_special boolean NOT NULL
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 357 (class 1259 OID 116800)
-- Name: product_flavor_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_flavor_profiles (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    flavorprofile_id bigint NOT NULL
);


ALTER TABLE public.product_flavor_profiles OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 116799)
-- Name: product_flavor_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product_flavor_profiles ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.product_flavor_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 354 (class 1259 OID 116789)
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.product ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 394 (class 1259 OID 263299)
-- Name: products_accessory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_accessory (
    id bigint NOT NULL,
    sku character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    brand character varying(100),
    description text,
    price numeric(8,2) NOT NULL,
    category character varying(100),
    is_special boolean NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT products_accessory_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.products_accessory OWNER TO postgres;

--
-- TOC entry 393 (class 1259 OID 263298)
-- Name: products_accessory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.products_accessory ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.products_accessory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 361 (class 1259 OID 116812)
-- Name: products_photo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_photo (
    id bigint NOT NULL,
    photo character varying(255),
    product_id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.products_photo OWNER TO postgres;

--
-- TOC entry 360 (class 1259 OID 116811)
-- Name: products_photo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.products_photo ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.products_photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 367 (class 1259 OID 116898)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    grade integer NOT NULL,
    comment text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    customer_id bigint NOT NULL
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 366 (class 1259 OID 116897)
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.reviews ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 370 (class 1259 OID 116921)
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    letter character varying(100) NOT NULL
);


ALTER TABLE public.services OWNER TO postgres;

--
-- TOC entry 369 (class 1259 OID 116920)
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.services ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 372 (class 1259 OID 116927)
-- Name: supplies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplies (
    id bigint NOT NULL,
    serving_type character varying,
    price numeric(8,2),
    weight numeric(5,2),
    quantity integer,
    product_id bigint
);


ALTER TABLE public.supplies OWNER TO postgres;

--
-- TOC entry 371 (class 1259 OID 116926)
-- Name: supplies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.supplies ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.supplies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 374 (class 1259 OID 116941)
-- Name: token_blacklist_blacklistedtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_blacklist_blacklistedtoken (
    id bigint NOT NULL,
    blacklisted_at timestamp with time zone NOT NULL,
    token_id bigint NOT NULL
);


ALTER TABLE public.token_blacklist_blacklistedtoken OWNER TO postgres;

--
-- TOC entry 373 (class 1259 OID 116940)
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.token_blacklist_blacklistedtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.token_blacklist_blacklistedtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 376 (class 1259 OID 116947)
-- Name: token_blacklist_outstandingtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_blacklist_outstandingtoken (
    id bigint NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone,
    expires_at timestamp with time zone NOT NULL,
    user_id bigint,
    jti character varying(255) NOT NULL,
    jti_hex character varying(255)
);


ALTER TABLE public.token_blacklist_outstandingtoken OWNER TO postgres;

--
-- TOC entry 375 (class 1259 OID 116946)
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.token_blacklist_outstandingtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.token_blacklist_outstandingtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 343 (class 1259 OID 116667)
-- Name: user_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_profile (
    id bigint NOT NULL,
    first_name character varying(25) NOT NULL,
    last_name character varying(25) NOT NULL,
    company_name character varying(25),
    country character varying(25),
    state character varying(25),
    region character varying(25),
    street_name text,
    apartment_number text,
    zip_code character varying(15),
    phone_number character varying(128),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.user_profile OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 116666)
-- Name: user_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.user_profile ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.user_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 323 (class 1259 OID 17253)
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- TOC entry 317 (class 1259 OID 17084)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 320 (class 1259 OID 17107)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- TOC entry 319 (class 1259 OID 17106)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 298 (class 1259 OID 16544)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 4525 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 325 (class 1259 OID 82006)
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- TOC entry 391 (class 1259 OID 219045)
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- TOC entry 300 (class 1259 OID 16586)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 299 (class 1259 OID 16559)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 4529 (class 0 OID 0)
-- Dependencies: 299
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 324 (class 1259 OID 81962)
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE storage.prefixes OWNER TO supabase_storage_admin;

--
-- TOC entry 315 (class 1259 OID 17032)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 316 (class 1259 OID 17046)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 392 (class 1259 OID 219055)
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- TOC entry 3713 (class 2604 OID 16508)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 4345 (class 0 OID 16523)
-- Dependencies: 296
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- TOC entry 4359 (class 0 OID 16925)
-- Dependencies: 313
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- TOC entry 4350 (class 0 OID 16723)
-- Dependencies: 304
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- TOC entry 4344 (class 0 OID 16516)
-- Dependencies: 295
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4354 (class 0 OID 16812)
-- Dependencies: 308
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- TOC entry 4353 (class 0 OID 16800)
-- Dependencies: 307
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- TOC entry 4352 (class 0 OID 16787)
-- Dependencies: 306
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- TOC entry 4430 (class 0 OID 137057)
-- Dependencies: 388
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- TOC entry 4432 (class 0 OID 196809)
-- Dependencies: 390
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- TOC entry 4425 (class 0 OID 131459)
-- Dependencies: 383
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- TOC entry 4431 (class 0 OID 137090)
-- Dependencies: 389
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- TOC entry 4360 (class 0 OID 16975)
-- Dependencies: 314
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4343 (class 0 OID 16505)
-- Dependencies: 294
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- TOC entry 4357 (class 0 OID 16854)
-- Dependencies: 311
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- TOC entry 4358 (class 0 OID 16872)
-- Dependencies: 312
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- TOC entry 4346 (class 0 OID 16531)
-- Dependencies: 297
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
\.


--
-- TOC entry 4351 (class 0 OID 16753)
-- Dependencies: 305
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.


--
-- TOC entry 4356 (class 0 OID 16839)
-- Dependencies: 310
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4355 (class 0 OID 16830)
-- Dependencies: 309
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- TOC entry 4341 (class 0 OID 16493)
-- Dependencies: 292
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- TOC entry 4438 (class 0 OID 263310)
-- Dependencies: 396
-- Data for Name: accessory_photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accessory_photo (id, created_at, updated_at, photo, accessory_id) FROM stdin;
\.


--
-- TOC entry 4375 (class 0 OID 116607)
-- Dependencies: 333
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 4377 (class 0 OID 116615)
-- Dependencies: 335
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 4373 (class 0 OID 116601)
-- Dependencies: 331
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add Blacklisted Token	6	add_blacklistedtoken
22	Can change Blacklisted Token	6	change_blacklistedtoken
23	Can delete Blacklisted Token	6	delete_blacklistedtoken
24	Can view Blacklisted Token	6	view_blacklistedtoken
25	Can add Outstanding Token	7	add_outstandingtoken
26	Can change Outstanding Token	7	change_outstandingtoken
27	Can delete Outstanding Token	7	delete_outstandingtoken
28	Can view Outstanding Token	7	view_outstandingtoken
29	Can add task result	8	add_taskresult
30	Can change task result	8	change_taskresult
31	Can delete task result	8	delete_taskresult
32	Can view task result	8	view_taskresult
33	Can add chord counter	9	add_chordcounter
34	Can change chord counter	9	change_chordcounter
35	Can delete chord counter	9	delete_chordcounter
36	Can view chord counter	9	view_chordcounter
37	Can add group result	10	add_groupresult
38	Can change group result	10	change_groupresult
39	Can delete group result	10	delete_groupresult
40	Can view group result	10	view_groupresult
41	Can add user model	11	add_usermodel
42	Can change user model	11	change_usermodel
43	Can delete user model	11	delete_usermodel
44	Can view user model	11	view_usermodel
45	Can add user profile model	12	add_userprofilemodel
46	Can change user profile model	12	change_userprofilemodel
47	Can delete user profile model	12	delete_userprofilemodel
48	Can view user profile model	12	view_userprofilemodel
49	Can add flavor profile	13	add_flavorprofile
50	Can change flavor profile	13	change_flavorprofile
51	Can delete flavor profile	13	delete_flavorprofile
52	Can view flavor profile	13	view_flavorprofile
53	Can add product	14	add_product
54	Can change product	14	change_product
55	Can delete product	14	delete_product
56	Can view product	14	view_product
57	Can add photo	15	add_photo
58	Can change photo	15	change_photo
59	Can delete photo	15	delete_photo
60	Can view photo	15	view_photo
61	Can add product photos model	16	add_productphotosmodel
62	Can change product photos model	16	change_productphotosmodel
63	Can delete product photos model	16	delete_productphotosmodel
64	Can view product photos model	16	view_productphotosmodel
65	Can add supply	17	add_supply
66	Can change supply	17	change_supply
67	Can delete supply	17	delete_supply
68	Can view supply	17	view_supply
69	Can add subscription	18	add_subscription
70	Can change subscription	18	change_subscription
71	Can delete subscription	18	delete_subscription
72	Can view subscription	18	view_subscription
73	Can add review	19	add_review
74	Can change review	19	change_review
75	Can delete review	19	delete_review
76	Can view review	19	view_review
77	Can add order	20	add_order
78	Can change order	20	change_order
79	Can delete order	20	delete_order
80	Can view order	20	view_order
81	Can add order position	21	add_orderposition
82	Can change order position	21	change_orderposition
83	Can delete order position	21	delete_orderposition
84	Can view order position	21	view_orderposition
85	Can add accessory	22	add_accessory
86	Can change accessory	22	change_accessory
87	Can delete accessory	22	delete_accessory
88	Can view accessory	22	view_accessory
89	Can add accessory photos model	23	add_accessoryphotosmodel
90	Can change accessory photos model	23	change_accessoryphotosmodel
91	Can delete accessory photos model	23	delete_accessoryphotosmodel
92	Can view accessory photos model	23	view_accessoryphotosmodel
93	Can add basket	24	add_basket
94	Can change basket	24	change_basket
95	Can delete basket	24	delete_basket
96	Can view basket	24	view_basket
97	Can add basket item	25	add_basketitem
98	Can change basket item	25	change_basketitem
99	Can delete basket item	25	delete_basketitem
100	Can view basket item	25	view_basketitem
101	Can add discount code	26	add_discountcode
102	Can change discount code	26	change_discountcode
103	Can delete discount code	26	delete_discountcode
104	Can view discount code	26	view_discountcode
105	Can add favorite item	27	add_favoriteitem
106	Can change favorite item	27	change_favoriteitem
107	Can delete favorite item	27	delete_favoriteitem
108	Can view favorite item	27	view_favoriteitem
109	Can add favorites	28	add_favorites
110	Can change favorites	28	change_favorites
111	Can delete favorites	28	delete_favorites
112	Can view favorites	28	view_favorites
\.


--
-- TOC entry 4379 (class 0 OID 116647)
-- Dependencies: 337
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, email, avatar, is_superuser, is_staff, is_active, subscription_updates_news, password, last_login, created_at, updated_at) FROM stdin;
3	o@gmail.com		f	f	t	f	pbkdf2_sha256$1000000$CWS56m3A2rdmBgbQJ92fEB$Mc2Aa6G1QFbzP54Ltgay/MKfYTcwBafv8HUTltqI/Ec=	\N	2025-09-23 20:44:10.220205+00	2025-09-23 20:44:10.220221+00
2	uk@gmail.com		f	f	t	f	pbkdf2_sha256$1000000$02Tm1BeGx2LKHGCTJfWJeH$UGT6XWQ7F7wcAhfsORCH1GUlOHcFhxPmNPpSpYm4zk4=	\N	2025-09-23 20:42:40.01372+00	2025-09-23 20:42:40.013732+00
19	katjarost3@gmail.com		f	f	t	f	pbkdf2_sha256$870000$IEhxBFZep617qwfX1TRPH5$FmmexfVWZEtav6EQjHKql4mCoaoZ2f9lEXU8gZVGleA=	2025-12-01 17:31:13.969531+00	2025-12-01 17:31:10.647876+00	2025-12-01 17:31:10.647892+00
20	katjarost4@gmail.com		f	f	t	f	pbkdf2_sha256$870000$SHxPK59ohKKTVlQfpzcT2m$dZyl1jquV9Y7RRPXnPJwUg1eQW0IsoTrexu8mpT1tM0=	2025-12-01 17:33:01.276439+00	2025-12-01 17:32:57.745901+00	2025-12-01 17:32:57.745921+00
4	fless76@gmail.com		f	f	t	f	pbkdf2_sha256$1000000$ZcHGZjCpaFNnj4vfshknwg$nCvcJYG+8Tk91H+AZmF3QD9zkoxhD7/BKqJDTlJziBY=	2025-09-23 23:19:43.810508+00	2025-09-23 23:16:59.017285+00	2025-09-23 23:21:15.334712+00
6	fless887@gmail.com		f	f	t	f	pbkdf2_sha256$1000000$cIuAewtrlf92zTDO7vGIn4$BvQ+SUTWFFV/LIybHe0O9SzU48SK5ntlo+KB+HaUkhI=	\N	2025-09-23 23:42:02.569974+00	2025-09-23 23:42:02.569983+00
5	fless876@gmail.com		f	f	t	f	pbkdf2_sha256$1000000$fH1CJIFERPqMjcuaCCIEwk$Yw88/ZnaT65XMbQarankJvDi6tgsZCmy2W0o2HaLsFc=	\N	2025-09-23 23:41:48.277823+00	2025-09-23 23:41:48.27784+00
7	fless86@gmail.com		f	f	t	f	pbkdf2_sha256$1000000$dccTxNcrLIlpUwpSChyT9q$KossfbhDNTNgESsoPtW7aoyAw/6EfSlXTChe3oaG8qY=	2025-09-23 23:50:44.349067+00	2025-09-23 23:48:17.473275+00	2025-09-23 23:51:30.006227+00
1	admin@gmail.com		t	t	t	f	pbkdf2_sha256$870000$0hGLwy37KqkDmZ2QAApq0a$GqtYPgkEchwtl3o/+gxWgrGDQDEf0/UY5CMeO3QPZOY=	2025-12-09 18:48:50.635974+00	2025-09-23 19:26:20.014424+00	2025-09-23 19:26:20.014435+00
25	katjarost12@gmail.com		f	f	t	f	pbkdf2_sha256$870000$hI2JiDTXYZBYsqShCCuQ5b$UurgvFN9Jy0iktlfTSFbmTp7lzUNlL/FNHUVxqlePZc=	2025-12-04 16:05:58.024558+00	2025-12-04 15:38:11.180117+00	2025-12-04 15:38:11.180131+00
10	stepovoyas@gmail.com		f	f	t	f	pbkdf2_sha256$1000000$yhHYzLgkhLF2xg4s8KjKuM$5axYWnLHoPOrHqAVmcr9lXz0RSEkqoe+D8phsBMLqiw=	2025-09-25 01:39:35.029336+00	2025-09-25 00:59:35.012691+00	2025-09-25 00:59:35.013272+00
8	fless8176@gmail.com		f	f	t	f	pbkdf2_sha256$1000000$khsmoJx4EyyEjlJRXBTjnv$NpNPb0yv2udhWUWAZW8PNninjJEmWiamo0kQLxr9qLs=	\N	2025-09-24 17:59:49.405282+00	2025-09-24 17:59:49.405295+00
11	fless8876@gmail.com		f	f	t	f	pbkdf2_sha256$870000$wIuyZH2RTb2nlKxjjWT5vj$HOISocRXFT+Ao3fwskI5yM2qWFpab3IgBTO1fSHIUbg=	2025-09-28 17:10:28.750515+00	2025-09-28 17:09:31.083188+00	2025-09-28 17:09:31.0832+00
38	test@test.ua		f	f	t	f	pbkdf2_sha256$870000$jjbx16sEdVlpHiWnEgBqmk$/oDtRkbotsAkeGxKp2tMzxhdS6pBcGDS+svYkJPNKzE=	2025-12-12 12:10:29.772142+00	2025-12-10 09:27:26.971159+00	2025-12-12 12:09:53.111974+00
12	test94@gmail.com		f	f	t	f	pbkdf2_sha256$1000000$CBmkZ2r2hYqiWA6X8Lii0T$NFe/obB6JastKz2kehCayJiK2wDHmc+U3DXFzToRWK4=	2025-09-30 16:53:58.152779+00	2025-09-30 16:53:25.600087+00	2025-09-30 16:53:25.600833+00
26	katjarost111@gmail.com		f	f	t	f	pbkdf2_sha256$870000$u0NznhwUtG72NpLW7gCYkC$QdChQVyxJFnyUO9NxIMLhfItCXmD81jIgQhqnmKL9G0=	2025-12-04 16:32:04.541761+00	2025-12-04 16:31:58.401089+00	2025-12-04 16:31:58.401121+00
14	katjarost82@gmail.com		f	f	t	f	pbkdf2_sha256$870000$yuHxIynHcgJoOx38pTPEYM$N1iCPWQjAeuWW26aK7ywUa/0rCHfjLfsXdF7cF1M2MU=	\N	2025-12-01 16:49:24.242768+00	2025-12-01 16:49:24.242783+00
15	katjarost_new01@gmail.com		f	f	t	f	pbkdf2_sha256$870000$qxJlgm8GQ6zOIzJGqGYn28$tpj06ZPOK9tmBnOjRIPeS6T/LzFwPZJxZjBU0wfPO+M=	2025-12-01 16:55:39.688306+00	2025-12-01 16:55:34.841546+00	2025-12-01 16:55:34.841566+00
16	katjarost_new02@gmail.com		f	f	t	f	pbkdf2_sha256$870000$ku5zSz3SR0qOp3fsu8bbWk$ss5jbb403UMU4fG42P1sI6+5Elfts3ToacSzXT3Rp9s=	2025-12-01 16:59:38.273292+00	2025-12-01 16:59:34.750338+00	2025-12-01 16:59:34.750354+00
17	katjarost11@gmail.com		f	f	t	f	pbkdf2_sha256$870000$PrlOJUbCpBYFKuNilnjCua$iFssFOzLRqZPblc+ocUXlUgiqM21Om5DKNycXbEB1j4=	2025-12-01 17:20:24.97022+00	2025-12-01 17:20:21.737543+00	2025-12-01 17:20:21.737566+00
18	katjarost1@gmail.com		f	f	t	f	pbkdf2_sha256$870000$iopzMjRHB6kAFaaJ0M6h6M$t0q+/eSA3PqtzlWYOquYC33DJM8Y55Jwperv8QYqIV0=	2025-12-01 17:29:09.338078+00	2025-12-01 17:29:05.948637+00	2025-12-01 17:29:05.948653+00
22	katjarost7@gmail.com		f	f	t	f	pbkdf2_sha256$870000$ndIiMOgDXj3DzVb91nyEdF$anQeJdBioU09P3Ij1ugrqb8speObhA62WRi39XM/Fa4=	2025-12-02 08:57:15.379318+00	2025-12-02 08:57:11.737278+00	2025-12-02 08:57:11.737302+00
27	katjsrost2222@gmail.com		f	f	t	f	pbkdf2_sha256$870000$Nt6fA5tu8Oe0ruDJfm2RXb$v5/j9PmJB9qUj5Dn6oFI5VcNZNNFdlrFfezqsLREbpg=	\N	2025-12-04 16:36:51.301467+00	2025-12-04 16:36:51.301483+00
23	katjarost9@gmail.com		f	f	t	f	pbkdf2_sha256$870000$wrJoJKS46zPiS912YtH1Jb$wV3s6RIE+IZQZFrWPYqHQ1C5314+WxDK747/yYWorr8=	2025-12-02 09:34:51.108356+00	2025-12-02 09:08:24.436564+00	2025-12-02 09:08:24.43658+00
24	katjarost78@gmail.com		f	f	t	f	pbkdf2_sha256$870000$qvu7ocm5s7SYQA7Pd19Tf0$nBnO+TTGh2nzNfgEXix4ZL2I727/sAHDex/cCzd0U2A=	2025-12-02 09:56:32.385585+00	2025-12-02 09:56:27.756138+00	2025-12-02 09:56:27.75617+00
28	katjsrost225@gmail.com		f	f	t	f	pbkdf2_sha256$870000$yELVgPzxAj8XpXYeNClsPD$dMNPdunDCJyUzuBu7ndPsgUoyNJ/49VRooirYT63DFM=	\N	2025-12-04 16:37:32.50721+00	2025-12-04 16:37:32.507224+00
29	katjsrost255@gmail.com		f	f	t	f	pbkdf2_sha256$870000$L7wN47dSQCwheGL3pyXjWE$Oe1VQbZUu+gYqTFf4hBuFFF7MzQUlNGYfu9RzfSzSXo=	\N	2025-12-04 16:39:00.108471+00	2025-12-04 16:39:00.108489+00
30	katjsrost257@gmail.com		f	f	t	f	pbkdf2_sha256$870000$GDdPBXM2U9sOyui3onFcnw$tffGLYGYLNmK0r28T1PaqBa9KU9KMEa8b1sU5Q7AK8k=	\N	2025-12-04 16:39:36.908258+00	2025-12-04 16:39:36.908272+00
31	katjsrost258@gmail.com		f	f	t	f	pbkdf2_sha256$870000$gFVyh03d7k9nqAhswdRLXi$SnTynjTo4MLox4h5nZ9zgwPvM4DJMkZGXd1ApUDCSXY=	2025-12-04 16:46:16.345821+00	2025-12-04 16:44:22.798183+00	2025-12-04 16:44:22.798198+00
32	katjarost666@gmail.com		f	f	t	f	pbkdf2_sha256$870000$LdmpxD9Bdwd5zjgJIIc4Cw$7e9Oe3ws3mqJLw/3m6e1a4nfmMjA53I2WtUdH+Yur9w=	\N	2025-12-04 16:48:09.108922+00	2025-12-04 16:48:09.108936+00
33	kkkkk@gmail.com		f	f	t	f	pbkdf2_sha256$870000$onJ6w03N0PEtQgcPVlmgVX$tjmAZuzKNIaea9ookxIB7pzXmBpSN1Ju8OoUlLafFAc=	\N	2025-12-04 16:51:15.607141+00	2025-12-04 16:51:15.607162+00
21	katjarost5@gmail.com		f	f	t	f	pbkdf2_sha256$870000$FCUorBFChxbaXB1iU7VNyL$Jxdn9LxaN03jL6nWGbS75Pe9wmVG3e2esPrJ/qg9DPU=	2025-12-02 11:54:05.867965+00	2025-12-01 17:39:38.246415+00	2025-12-01 17:39:38.246431+00
34	teamchallenge.coffee@gmail.com		f	f	t	f	pbkdf2_sha256$870000$KHuz0UhD1i3llsLe14ciCA$EeAjfLzcxSEjXx0mQGfqpvlPIDm0XVRsZmSWvhuyidU=	\N	2025-12-05 18:52:15.302356+00	2025-12-05 18:52:15.302377+00
37	admin@coffeelane.com	avatars/48aadfeb-d52a-11f0-9046-df4628f6b4a9.png	t	t	t	f	pbkdf2_sha256$870000$oFRnQ5NOErY7Mj52EAdRUU$bw76sdooTD6EpjyQXUpvPQ9Q1ignSLmVcP1QhOgv1Ko=	2025-12-09 17:52:44.001188+00	2025-12-09 16:45:10.66882+00	2025-12-09 18:10:03.298571+00
39	test1@test.test		f	f	t	f	pbkdf2_sha256$870000$lMVYMFD4zgJdPTBScdk0ht$5ZIpP0tqfSGbZ0Jfb3f10Lli9Hb5ekNYCxbJjl0pMc0=	2025-12-16 10:38:56.205314+00	2025-12-16 10:38:47.768773+00	2025-12-16 10:38:47.768795+00
46	abc@gmail.com		f	f	t	f	pbkdf2_sha256$870000$jmhEBVzxfRnZZbINKs3ndK$cCjl5zflA+2GJbg/NwhJncYilVZdLLv6yIPyii8Etlo=	2026-01-01 08:47:07.582314+00	2025-12-31 13:44:14.502058+00	2025-12-31 13:45:11.910452+00
43	lex030382@gmail.com		f	f	t	f	pbkdf2_sha256$870000$raEbxlh7iVEJMKXOvoDx8I$YpaBGE0jw+lz6ifDflxwYB+Dhb9wWI5DH+l/EfYMBEw=	2025-12-26 22:45:14.227838+00	2025-12-26 22:45:04.538313+00	2025-12-26 22:45:04.538336+00
40	test3@test.com		f	f	t	f	pbkdf2_sha256$870000$aD06nwhAcq4hQvwkY3VEMP$AzYpEVx5SDXHdf8OBdhlWjh3bDpFpypTx2gnHBz5eug=	2025-12-29 08:45:19.194521+00	2025-12-17 10:57:38.718001+00	2025-12-29 08:25:41.558766+00
44	test-new-user@gmail.com		f	f	t	f	pbkdf2_sha256$870000$Gyg2MF4OyCvBPN9Ef7y8pJ$f502JkKy1Kn8SGChGkXJCIrNUD9v/f+uieL6p3dDbUk=	2026-01-02 15:41:39.251537+00	2025-12-29 18:54:52.478874+00	2025-12-29 18:54:52.478894+00
41	admin@example.com	image/upload/v1770734378/aubp2xuwrxabjnzfvmya.png	t	t	t	f	pbkdf2_sha256$870000$RiRHRnyJBV3CyyOErm5Ckg$dr1vDo1MyyH/CRjepD8ltrXEDtQd64pU2oSOCRgck+o=	2026-02-10 15:36:45.758719+00	2025-12-18 21:46:20.495471+00	2026-02-10 14:39:38.359343+00
13	katjarost1501@gmail.com		f	f	t	f	pbkdf2_sha256$870000$VwQTXM05fu70CHs3uoDorg$jEoilBZQVYl/Ee2EbeL31zKNo2B0oZPLYHObEw3q2PA=	2026-02-10 15:02:06.956426+00	2025-12-01 09:42:46.048766+00	2026-02-03 17:58:08.416005+00
42	fvm.kolchuk.no.2016.211.m@gmail.com		f	f	t	f	pbkdf2_sha256$870000$oBaSV9yKTK4qxHJsm8vN8K$FZGOo8LUj1+6iDycKuTwYavCRQnpoC40sJbLn4HjSkc=	2026-01-01 20:11:45.739621+00	2025-12-26 21:07:17.482469+00	2026-01-04 19:19:59.276451+00
49	natalia.kolchuk@gmail.com		f	f	t	f	pbkdf2_sha256$870000$TiYcUyiafn4qXUGnULqZPY$/lC5m0F2uvFMR9WzMPVH9M8D90mF7EklYstDWh1nohM=	2026-01-04 20:31:43.296957+00	2026-01-04 19:06:35.650488+00	2026-01-04 19:06:35.650499+00
45	adm@gmail.com	image/upload/v1770638018/lf3ofsuaz6eyrkbvsfnt.png	t	t	t	f	pbkdf2_sha256$870000$LVcutDC0HuiiR3nTKNhjfO$fqrfxU5Ay1H1s1tP+UvHYF5su5Vr2Acp83vYk7RhTKU=	2026-02-10 23:21:10.09084+00	2025-12-30 10:14:01.314041+00	2026-02-09 11:53:36.627358+00
\.


--
-- TOC entry 4381 (class 0 OID 116655)
-- Dependencies: 339
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, usermodel_id, group_id) FROM stdin;
\.


--
-- TOC entry 4383 (class 0 OID 116661)
-- Dependencies: 341
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, usermodel_id, permission_id) FROM stdin;
\.


--
-- TOC entry 4422 (class 0 OID 126971)
-- Dependencies: 380
-- Data for Name: basket_basket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.basket_basket (id, guest_token, created_at, updated_at, is_active, discount_code_id, user_id) FROM stdin;
1	64113aea-521a-4e91-ac1c-4e158593f849	2025-10-03 13:51:41.423015+00	2025-10-03 13:51:41.42305+00	t	\N	\N
2	366f5f7b-f90a-4c81-977c-5a7a65e930cf	2025-10-03 13:51:41.511502+00	2025-10-03 13:51:41.511516+00	t	\N	\N
3	1b0a5159-ffe8-4a00-be97-b791456caa00	2025-10-03 13:51:41.577349+00	2025-10-03 13:51:41.577363+00	t	\N	\N
4	92af17f3-e881-434f-9d76-bdef51cee88f	2025-10-03 13:51:42.163348+00	2025-10-03 13:51:42.16337+00	t	\N	\N
5	96b804e5-4594-4b0b-a9ae-404e232d704e	2025-10-03 13:51:42.230651+00	2025-10-03 13:51:42.230668+00	t	\N	\N
6	1d073618-ccf8-4b51-a157-eb130cb8185b	2025-10-03 13:51:42.296824+00	2025-10-03 13:51:42.296843+00	t	\N	\N
7	d3391a2d-68ff-4b5e-8e57-2040b3b02bae	2025-10-03 13:59:18.481773+00	2025-10-03 13:59:18.48179+00	t	\N	\N
8	c524f28d-3b23-46f1-bc62-b9971b5c1983	2025-10-03 13:59:18.548768+00	2025-10-03 13:59:18.548784+00	t	\N	\N
9	43efa61f-3ddf-4d0a-bed2-56f7dde9b9ca	2025-10-03 13:59:18.615945+00	2025-10-03 13:59:18.61596+00	t	\N	\N
10	e71c9fed-7b82-4dbf-b128-7f114e4e6b91	2025-10-03 13:59:19.25978+00	2025-10-03 13:59:19.259802+00	t	\N	\N
11	376cfa60-89d5-4d35-b10a-e538dd29d835	2025-10-03 13:59:19.326346+00	2025-10-03 13:59:19.326366+00	t	\N	\N
12	74004785-055f-4e74-b46e-657c992115ca	2025-10-03 13:59:19.390585+00	2025-10-03 13:59:19.390604+00	t	\N	\N
13	35ccaf12-4ff0-4d7a-9f44-fcbabd57238c	2025-10-05 13:06:21.890295+00	2025-10-05 13:06:21.89035+00	t	\N	\N
14	f0b94ada-1093-49cb-99ba-77f2f4541ce6	2025-10-05 13:06:22.503545+00	2025-10-05 13:06:22.50357+00	t	\N	\N
15	53f982c4-975d-4a3d-b689-ca390f3e65b2	2025-10-05 13:06:23.117873+00	2025-10-05 13:06:23.117916+00	t	\N	\N
16	29ca09f9-ac55-4b11-95eb-466ef0043f42	2025-10-05 13:27:18.91692+00	2025-10-05 13:27:18.916944+00	t	\N	\N
17	ca2b5ad0-f9ed-47c6-a238-1b0bbc9d8282	2025-10-05 13:27:18.980116+00	2025-10-05 13:27:18.98013+00	t	\N	\N
18	ae8b7e60-d836-4d00-bf6f-90d39421609e	2025-10-05 13:27:19.042176+00	2025-10-05 13:27:19.042195+00	t	\N	\N
19	54a1df13-f75f-4b84-93e3-0b37016211fd	2025-10-05 13:27:19.725323+00	2025-10-05 13:27:19.725337+00	t	\N	\N
20	213ef633-0c7b-4944-9ab5-2e2e4d8a731c	2025-10-05 13:27:19.789285+00	2025-10-05 13:27:19.789299+00	t	\N	\N
21	daa5ff6f-53b0-4fe5-aef1-31a6c379e9ab	2025-10-05 13:27:19.852757+00	2025-10-05 13:27:19.852772+00	t	\N	\N
22	4ea19ddb-40b2-4c27-b825-bc7317221f01	2025-10-05 13:33:05.425146+00	2025-10-05 13:33:05.425165+00	t	\N	\N
23	fd4bcfb1-4037-4b15-9074-b360730b3028	2025-10-05 13:33:05.490483+00	2025-10-05 13:33:05.4905+00	t	\N	\N
24	e4021e28-f411-46fa-8eb8-52cd472905c2	2025-10-05 13:33:05.55655+00	2025-10-05 13:33:05.556601+00	t	\N	\N
25	49f5743d-3036-4191-8ac8-e77f3517e563	2025-10-05 13:33:06.15399+00	2025-10-05 13:33:06.154014+00	t	\N	\N
26	5d457c44-d3e4-4c29-beb0-2efc3355c86c	2025-10-05 13:33:06.224108+00	2025-10-05 13:33:06.224127+00	t	\N	\N
27	35a4d30a-dd5a-430f-b845-a11ae764558f	2025-10-05 13:33:06.291217+00	2025-10-05 13:33:06.291239+00	t	\N	\N
28	dab504c9-fb52-4cc9-9e1b-1a29a6c65237	2025-10-05 13:53:50.347174+00	2025-10-05 13:53:50.347196+00	t	\N	\N
29	2745b850-8c8b-4102-a123-411244907303	2025-10-05 13:53:50.414876+00	2025-10-05 13:53:50.414895+00	t	\N	\N
30	17a97ae5-df5d-49cc-a80b-6c623856fe10	2025-10-05 13:53:50.481447+00	2025-10-05 13:53:50.481464+00	t	\N	\N
31	6f6a26e0-5c0a-4be5-80bd-37790edee7a9	2025-10-06 17:56:34.97808+00	2025-10-06 17:56:34.978107+00	t	\N	\N
32	81d40b31-f29e-429c-961b-f4e3b0a2a2f2	2025-10-06 17:56:35.062419+00	2025-10-06 17:56:35.062436+00	t	\N	\N
33	b63ff392-50aa-4fac-ba4e-cf068424a9d3	2025-10-06 17:56:35.129145+00	2025-10-06 17:56:35.129164+00	t	\N	\N
34	bcd243ce-5062-4451-82b0-70f2cf5d12fb	2025-10-06 17:56:35.774486+00	2025-10-06 17:56:35.774504+00	t	\N	\N
35	32fdeb0b-0ab2-453d-a592-f44eb0dce887	2025-10-06 17:56:35.84031+00	2025-10-06 17:56:35.840329+00	t	\N	\N
36	76f8e639-bd0a-445c-8ffd-b43ddd6c917b	2025-10-06 17:56:35.905381+00	2025-10-06 17:56:35.905399+00	t	\N	\N
37	4ec4a0c6-ab26-4c46-a85c-ca1ec73b605c	2025-10-06 18:39:42.317087+00	2025-10-06 18:39:42.317107+00	t	\N	\N
38	8ef2e5a4-e30e-48eb-a2d8-70bb4a17d320	2025-10-06 18:39:42.385447+00	2025-10-06 18:39:42.385462+00	t	\N	\N
39	2d227f3f-284d-4e20-8d7f-257e6e638493	2025-10-06 18:39:42.450744+00	2025-10-06 18:39:42.45076+00	t	\N	\N
40	10ea8f2b-09a5-416d-ad9e-d640858945df	2025-10-06 18:39:42.9768+00	2025-10-06 18:39:42.976818+00	t	\N	\N
41	ffa2b105-31e9-427c-b4c5-ed87d83e85f6	2025-10-06 18:39:43.043462+00	2025-10-06 18:39:43.043477+00	t	\N	\N
42	56d4dcd3-245a-4feb-bdc0-9a3c0f8ec9a6	2025-10-06 18:39:43.109702+00	2025-10-06 18:39:43.10972+00	t	\N	\N
43	93ac6410-cb82-4ca4-801f-fbe6f13dfcee	2025-10-10 16:19:46.81105+00	2025-10-10 16:19:46.811087+00	t	\N	\N
44	c1d67b13-1ba7-45ce-b0ad-5b875be7a518	2025-10-10 16:19:46.937016+00	2025-10-10 16:19:46.937036+00	t	\N	\N
45	35a162b8-ad23-4954-b62b-c2f27259cf60	2025-10-10 16:19:47.001387+00	2025-10-10 16:19:47.001406+00	t	\N	\N
46	e6c312fc-1bae-402a-8416-f571863bca53	2025-10-10 16:19:47.638107+00	2025-10-10 16:19:47.638127+00	t	\N	\N
47	45d5162c-e80b-4bde-809c-da4a9061f51d	2025-10-10 16:19:47.704282+00	2025-10-10 16:19:47.704315+00	t	\N	\N
48	fbe49ca4-ef74-4c56-afde-a9c6a04b13ff	2025-10-10 16:19:47.768296+00	2025-10-10 16:19:47.768312+00	t	\N	\N
49	873ba21d-5a6a-4eef-ae7d-8dd818153d9b	2025-10-10 16:19:48.738521+00	2025-10-10 16:19:48.73854+00	t	\N	\N
50	672ccacd-9e59-4d8b-9219-5033afb36c73	2025-10-10 16:19:48.804787+00	2025-10-10 16:19:48.804802+00	t	\N	\N
51	3fc18c6d-f765-48bf-9357-4d04641f06e0	2025-10-10 16:19:48.871552+00	2025-10-10 16:19:48.871567+00	t	\N	\N
52	2ff5d7e2-56ab-49cf-803b-9c73a60135e2	2025-10-10 16:19:49.53365+00	2025-10-10 16:19:49.533668+00	t	\N	\N
53	017d538f-6823-4ae9-8186-437c8ab8b4a4	2025-10-10 16:19:49.600657+00	2025-10-10 16:19:49.600706+00	t	\N	\N
54	32ac1f64-f6a2-4ec0-9fde-f88df94d9b36	2025-10-10 16:19:49.665906+00	2025-10-10 16:19:49.665922+00	t	\N	\N
55	31b8edf9-1f59-4ff9-a4d1-4d11abef9869	2025-10-10 16:48:11.482961+00	2025-10-10 16:48:11.482998+00	t	\N	\N
56	30b3f920-e541-4f8f-b84c-c0da8650ba48	2025-10-10 16:48:11.557824+00	2025-10-10 16:48:11.557844+00	t	\N	\N
57	967c3eed-1edc-442a-8a14-717cbf8841ad	2025-10-10 16:48:11.619018+00	2025-10-10 16:48:11.619034+00	t	\N	\N
58	40a44c2c-c42d-415a-afb3-d63b6c8810e1	2025-10-10 16:48:12.215193+00	2025-10-10 16:48:12.215211+00	t	\N	\N
59	e401b7ab-9c70-4129-b294-960965b20d25	2025-10-10 16:48:12.27638+00	2025-10-10 16:48:12.276396+00	t	\N	\N
60	4fd074ea-af38-4fd0-844e-e33d0c139ec7	2025-10-10 16:48:12.337612+00	2025-10-10 16:48:12.33763+00	t	\N	\N
61	a8ca91e1-3c29-40c4-83d5-5ad9e049b068	2025-10-10 20:31:15.737763+00	2025-10-10 20:31:15.737824+00	t	\N	\N
62	1f6439d1-62b1-427d-b37d-0153299eecd8	2025-10-10 20:31:16.454392+00	2025-10-10 20:31:16.45443+00	t	\N	\N
63	e96f6b0f-169e-4105-9c05-7f4d41b45a01	2025-10-10 20:31:17.066737+00	2025-10-10 20:31:17.066763+00	t	\N	\N
64	2f7a701a-1984-4f88-849e-9ad931471913	2025-10-12 11:21:13.347658+00	2025-10-12 11:21:13.347701+00	t	\N	\N
65	9f3af59f-13df-43a6-b2aa-12a2fc9d5489	2025-10-12 11:21:13.450739+00	2025-10-12 11:21:13.450757+00	t	\N	\N
66	8ff60ecc-2ec3-4d2a-97c0-49965a076d8f	2025-10-12 11:21:13.517472+00	2025-10-12 11:21:13.517489+00	t	\N	\N
67	c131e740-a56e-46ed-a632-af5c45ac9e08	2025-10-12 11:21:14.225556+00	2025-10-12 11:21:14.225575+00	t	\N	\N
68	12bdafe7-3ca4-4cfb-b589-3c70749be226	2025-10-12 11:21:14.293636+00	2025-10-12 11:21:14.293654+00	t	\N	\N
69	9c6cb0c4-94db-4233-86a3-717d0be51f4c	2025-10-12 11:21:14.361784+00	2025-10-12 11:21:14.361802+00	t	\N	\N
70	12a08916-6248-4bf1-b575-b2edae39e521	2025-10-14 11:38:58.262504+00	2025-10-14 11:38:58.262529+00	t	\N	\N
71	ec2b896a-6ec9-4bdd-ac5e-5b54bbbe4579	2025-10-14 11:38:58.349392+00	2025-10-14 11:38:58.349407+00	t	\N	\N
72	f0eb8075-4eaa-4995-a373-ee7e31ecea90	2025-10-14 11:38:58.415213+00	2025-10-14 11:38:58.415235+00	t	\N	\N
73	8c8863f6-e8a4-4fb8-b574-5a1e6e46117c	2025-10-14 11:38:58.965719+00	2025-10-14 11:38:58.965739+00	t	\N	\N
74	fa1fba05-8746-4b9d-b5ab-c479856ad304	2025-10-14 11:38:59.032658+00	2025-10-14 11:38:59.032673+00	t	\N	\N
75	26e97fd1-4555-4dd0-94ee-6a34a6163c4e	2025-10-14 11:38:59.098608+00	2025-10-14 11:38:59.098628+00	t	\N	\N
76	c862e8e3-053a-45dd-a2ec-b419a27b9970	2025-10-14 22:44:58.847472+00	2025-10-14 22:44:58.847506+00	t	\N	\N
77	1f6bd47d-8516-4aac-b565-99fdfbe11090	2025-10-14 22:44:58.990492+00	2025-10-14 22:44:58.990513+00	t	\N	\N
78	cf417821-63a9-490a-b56a-f7569e7f3d62	2025-10-14 22:44:59.059413+00	2025-10-14 22:44:59.059429+00	t	\N	\N
79	98d04524-6ac7-486d-bbe1-4b8b8098d487	2025-10-14 22:44:59.687042+00	2025-10-14 22:44:59.687064+00	t	\N	\N
80	12d0eebd-aaed-428a-b7ab-e655dc4421ff	2025-10-14 22:44:59.758072+00	2025-10-14 22:44:59.758091+00	t	\N	\N
81	61ddf67a-3b45-423f-8890-9e375205a814	2025-10-14 22:44:59.829941+00	2025-10-14 22:44:59.82996+00	t	\N	\N
82	d1d97c06-b576-44ef-9e94-52b6a1106503	2025-10-15 09:51:38.496451+00	2025-10-15 09:51:38.496493+00	t	\N	\N
83	18c9c3ba-29ac-4a13-95e7-8bd8bdc24b03	2025-10-15 09:51:38.596436+00	2025-10-15 09:51:38.596454+00	t	\N	\N
84	862af716-e42e-4db2-a09e-3f55ef881382	2025-10-15 09:51:38.661686+00	2025-10-15 09:51:38.661704+00	t	\N	\N
85	e9ed91fd-f2cf-4736-bc78-cf94327ad57e	2025-10-15 09:51:39.491645+00	2025-10-15 09:51:39.491662+00	t	\N	\N
86	11b2c9c1-5efd-4a2e-9ab9-2f826c5383b4	2025-10-15 09:51:39.55692+00	2025-10-15 09:51:39.556943+00	t	\N	\N
87	f38a1d40-2d2e-454d-a610-107ae5380ddb	2025-10-15 09:51:39.621138+00	2025-10-15 09:51:39.621156+00	t	\N	\N
88	f8b89084-373c-44f0-bbf3-ad07a694cbd8	2025-10-15 10:02:51.012888+00	2025-10-15 10:02:51.012946+00	t	\N	\N
89	c45dca60-875a-4d23-8463-b4b9e2ba7080	2025-10-15 10:02:51.602904+00	2025-10-15 10:02:51.60293+00	t	\N	\N
90	86ddcbdd-0361-4252-b0c5-0ec6dbdd5795	2025-10-15 10:02:52.239309+00	2025-10-15 10:02:52.23932+00	t	\N	\N
91	a9b1ef7e-9ff2-44f5-932d-ba04fe0e70cd	2025-10-15 10:10:18.786832+00	2025-10-15 10:10:18.786873+00	t	\N	\N
92	e0074393-bccd-4d37-b0b2-3ed61a035e93	2025-10-15 10:10:19.400198+00	2025-10-15 10:10:19.400209+00	t	\N	\N
93	698db9bf-4fa9-4dd7-9e3b-006d3c5736b7	2025-10-15 10:10:20.015655+00	2025-10-15 10:10:20.015685+00	t	\N	\N
94	3bfc39b5-5b04-46a3-9ee7-3830ea719534	2025-10-15 10:21:44.081292+00	2025-10-15 10:21:44.081321+00	t	\N	\N
95	f22fc876-1c5c-4609-81f4-8b0b087bbe95	2025-10-15 10:21:44.153394+00	2025-10-15 10:21:44.153414+00	t	\N	\N
96	55700edc-9009-43dc-bd4e-772c65d760c8	2025-10-15 10:21:44.217971+00	2025-10-15 10:21:44.218012+00	t	\N	\N
97	02318693-0991-4f61-b9dd-bd748a9ecfc2	2025-10-15 10:21:44.830067+00	2025-10-15 10:21:44.830087+00	t	\N	\N
98	bc0ebd99-2328-45c9-b90c-f8429152100c	2025-10-15 10:21:44.892649+00	2025-10-15 10:21:44.892703+00	t	\N	\N
99	38d041d4-2099-4897-8181-d28917798172	2025-10-15 10:21:44.953573+00	2025-10-15 10:21:44.953589+00	t	\N	\N
100	2fcc6fcc-8727-408f-9bd8-261a3239b3be	2025-10-22 17:17:51.641919+00	2025-10-22 17:17:51.641977+00	t	\N	\N
101	22f3b835-3737-45db-bffa-767770156761	2025-10-22 17:17:51.771493+00	2025-10-22 17:17:51.771513+00	t	\N	\N
102	39136c87-6359-40ce-8a81-6662658245ad	2025-10-22 17:17:51.838311+00	2025-10-22 17:17:51.838331+00	t	\N	\N
103	794d6146-166f-4eba-ac77-a58cc391f70b	2025-10-22 17:17:52.525351+00	2025-10-22 17:17:52.525373+00	t	\N	\N
104	5b5a55f8-4ac4-4512-94f1-ea0080744e2e	2025-10-22 17:17:52.593592+00	2025-10-22 17:17:52.593608+00	t	\N	\N
105	787c9437-f5ef-4262-9cd6-67bde5ecfe89	2025-10-22 17:17:52.659837+00	2025-10-22 17:17:52.659857+00	t	\N	\N
106	f5a450bf-242e-4435-810a-d30bd0003c09	2025-11-06 19:12:43.462614+00	2025-11-06 19:12:43.462653+00	t	\N	\N
107	41e4f2b2-3766-4996-8d82-5e9e5d5d832b	2025-11-06 19:12:43.664539+00	2025-11-06 19:12:43.664555+00	t	\N	\N
108	4ccaab29-1347-4cfb-8788-70559108be14	2025-11-06 19:12:43.782243+00	2025-11-06 19:12:43.782263+00	t	\N	\N
109	10db4cb1-c910-48bc-b3dc-5a0c55c1c2ab	2025-11-06 19:12:44.588632+00	2025-11-06 19:12:44.588649+00	t	\N	\N
110	89a8d9a5-2b03-43ab-aa65-9a9677d35738	2025-11-06 19:12:44.708197+00	2025-11-06 19:12:44.708222+00	t	\N	\N
111	4160ed69-8455-4d08-882f-f2dd6f864119	2025-11-06 19:12:44.825642+00	2025-11-06 19:12:44.825663+00	t	\N	\N
112	f008a5e3-306a-440d-94df-26960e4207fb	2025-11-21 16:12:11.055078+00	2025-11-21 16:12:11.055107+00	t	\N	\N
113	9e89f80c-f396-478b-a736-9d9e44e871df	2025-11-21 16:12:11.172229+00	2025-11-21 16:12:11.172249+00	t	\N	\N
114	ba28e4b5-9d30-4b1b-8a11-b9fd7f139809	2025-11-21 16:12:11.237982+00	2025-11-21 16:12:11.238003+00	t	\N	\N
115	6190b6d0-2007-4abd-a4cf-3bceefbddc1d	2025-11-21 16:12:11.809743+00	2025-11-21 16:12:11.809773+00	t	\N	\N
116	81193e7d-d807-4fac-a7fe-b49b71f7ad7f	2025-11-21 16:12:11.876233+00	2025-11-21 16:12:11.876248+00	t	\N	\N
117	d34926d1-0862-4aee-8c19-4b491d5bcbd7	2025-11-21 16:12:11.942222+00	2025-11-21 16:12:11.942243+00	t	\N	\N
118	54e32b43-c5f8-4543-b70f-18d0b04a3e62	2025-11-21 17:47:41.699146+00	2025-11-21 17:47:41.699174+00	t	\N	\N
119	e2e0ded5-42aa-438d-a081-6d0520bb5b36	2025-11-21 17:47:41.827049+00	2025-11-21 17:47:41.827067+00	t	\N	\N
120	33a46a22-9217-4b22-9841-1080589a88f8	2025-11-21 17:47:41.894524+00	2025-11-21 17:47:41.894538+00	t	\N	\N
121	4d321446-4b62-43cc-a607-69d72e65e6dc	2025-11-21 17:47:42.427786+00	2025-11-21 17:47:42.427809+00	t	\N	\N
122	941c8ba9-855b-4d51-b04c-888a2d77794c	2025-11-21 17:47:42.494717+00	2025-11-21 17:47:42.494747+00	t	\N	\N
123	37afc98b-329b-4ead-b98e-e92f31c4c855	2025-11-21 17:47:42.559+00	2025-11-21 17:47:42.559015+00	t	\N	\N
124	213ec0a2-fe96-4348-ac0d-49d0c9005bda	2025-11-23 15:42:42.546919+00	2025-11-23 15:42:42.552525+00	t	\N	\N
125	5e9f3eba-e774-4261-b80d-8a08587df7c4	2025-11-23 15:42:42.67964+00	2025-11-23 15:42:42.679659+00	t	\N	\N
126	80492b04-766f-41b4-8b74-438f3bc91a89	2025-11-23 15:42:42.745204+00	2025-11-23 15:42:42.74522+00	t	\N	\N
127	0ae4df9c-7fc3-4485-8dbb-6b58fc334d76	2025-11-23 15:42:43.538697+00	2025-11-23 15:42:43.538718+00	t	\N	\N
128	22b65b0d-f061-4134-8105-2e53a087e576	2025-11-23 15:42:43.604741+00	2025-11-23 15:42:43.604758+00	t	\N	\N
129	ae92fffc-d00e-4f88-8374-fb03a84024c6	2025-11-23 15:42:43.670978+00	2025-11-23 15:42:43.670998+00	t	\N	\N
130	caff842d-d53f-4739-be8f-21668cdfa5c8	2025-11-27 10:05:13.538069+00	2025-11-27 10:05:13.5381+00	t	\N	\N
131	68e6a03d-7d58-4996-a98d-a3c5cd95ddfa	2025-11-27 10:05:13.679392+00	2025-11-27 10:05:13.679407+00	t	\N	\N
132	f6b822b3-70ca-448f-854d-4cd1e4485cec	2025-11-27 10:05:13.742308+00	2025-11-27 10:05:13.742324+00	t	\N	\N
133	5511d46e-7146-4ec7-908b-689d4bcdc72d	2025-11-27 10:05:14.360774+00	2025-11-27 10:05:14.3608+00	t	\N	\N
134	d28c991b-8385-4c73-9107-3bc8a98dea4f	2025-11-27 10:05:14.429829+00	2025-11-27 10:05:14.429846+00	t	\N	\N
135	ddd66cab-8609-4f9d-b896-4b8ed3e244ff	2025-11-27 10:05:14.495507+00	2025-11-27 10:05:14.495524+00	t	\N	\N
136	cf295d04-4c77-4484-93b2-61a4423141aa	2025-11-27 10:05:15.2812+00	2025-11-27 10:05:15.281222+00	t	\N	\N
137	0456239f-f201-499f-ae3b-aebfa7eb6c45	2025-11-27 10:05:15.347009+00	2025-11-27 10:05:15.347025+00	t	\N	\N
138	75019bfe-38fe-4531-b170-f6a5ee15d2e7	2025-11-27 10:05:15.411433+00	2025-11-27 10:05:15.411449+00	t	\N	\N
139	659492c2-4a0a-4ecd-895e-289d12ae17e0	2025-12-01 16:17:09.033872+00	2025-12-01 16:17:09.033923+00	t	\N	\N
140	cefafe74-a067-401a-a9bf-cd524d76f6a3	2025-12-01 16:17:09.852934+00	2025-12-01 16:17:09.852963+00	t	\N	\N
141	717acf8f-1b66-492b-9f8b-38a818219d87	2025-12-01 16:17:10.46769+00	2025-12-01 16:17:10.467725+00	t	\N	\N
142	cbfea26b-3353-4f6d-9763-0be1fb89daef	2025-12-01 16:39:09.248781+00	2025-12-01 16:39:09.248823+00	t	\N	\N
143	d9cb753e-7409-4090-a1df-a1bfbae99248	2025-12-01 16:39:09.344778+00	2025-12-01 16:39:09.344794+00	t	\N	\N
144	928283f4-90d3-447a-8c2c-7ea0c00a79ef	2025-12-01 16:39:09.412388+00	2025-12-01 16:39:09.412403+00	t	\N	\N
145	9d3915ec-d2be-4d3e-9355-dc08490d6dd4	2025-12-01 16:39:10.076309+00	2025-12-01 16:39:10.076327+00	t	\N	\N
146	65b02651-a88c-45e5-9c1b-54598624fba6	2025-12-01 16:39:10.144078+00	2025-12-01 16:39:10.144121+00	t	\N	\N
147	188559a1-f697-4ff2-812d-91241547e501	2025-12-01 16:39:10.209356+00	2025-12-01 16:39:10.209373+00	t	\N	\N
148	4841e5a7-11ec-44ff-8ec9-727e1a11d483	2025-12-04 14:51:32.911751+00	2025-12-04 14:51:32.911778+00	t	\N	\N
149	da211aed-acf5-4a68-ba5c-6317babbcfd7	2025-12-04 14:51:33.036129+00	2025-12-04 14:51:33.036145+00	t	\N	\N
150	a1a14afa-86d8-46fe-9886-73142a35aa91	2025-12-04 14:51:33.1046+00	2025-12-04 14:51:33.104617+00	t	\N	\N
151	994c3f9a-a1fe-4c40-9382-977bad7044ae	2025-12-04 14:51:33.847972+00	2025-12-04 14:51:33.847995+00	t	\N	\N
152	10e475d0-88b8-4946-bd52-3c5f310f9fcb	2025-12-04 14:51:33.914906+00	2025-12-04 14:51:33.914926+00	t	\N	\N
153	51c2f751-dadf-418d-805a-b17fff5d7469	2025-12-04 14:51:33.980387+00	2025-12-04 14:51:33.980406+00	t	\N	\N
154	0e8598d1-2ada-4d68-9b61-4b63a794a057	2025-12-05 09:56:46.311358+00	2025-12-05 09:56:46.311425+00	t	\N	\N
155	9cf78dc4-c9b4-4c3f-b6c9-7263b2e0165a	2025-12-05 09:56:46.504835+00	2025-12-05 09:56:46.504853+00	t	\N	\N
156	574eabb7-a42b-4b07-a18c-ff13425c4ee7	2025-12-05 09:56:46.570242+00	2025-12-05 09:56:46.570258+00	t	\N	\N
157	2835ef3c-0c71-40de-866b-9467c83454d4	2025-12-05 09:56:47.228753+00	2025-12-05 09:56:47.22877+00	t	\N	\N
158	e256fe11-d47f-4ec6-af9a-e3ef6cbba583	2025-12-05 09:56:47.297085+00	2025-12-05 09:56:47.297102+00	t	\N	\N
159	f550c3d3-8118-4506-9972-907cbe9f9a18	2025-12-05 09:56:47.362361+00	2025-12-05 09:56:47.36238+00	t	\N	\N
160	fc7f1d19-7701-42b2-bd14-c17fb878019b	2025-12-06 03:39:33.436613+00	2025-12-06 03:39:33.436642+00	t	\N	\N
161	1d1c0490-be2b-4ab5-98b9-54e94595c168	2025-12-06 03:39:33.565305+00	2025-12-06 03:39:33.56532+00	t	\N	\N
162	1cd0d482-bc4d-4f7c-b9a5-71758a9eb4ba	2025-12-06 03:39:33.630324+00	2025-12-06 03:39:33.630347+00	t	\N	\N
163	707c20a8-fe77-4ce0-8fe1-d7c15326ace1	2025-12-06 03:39:34.169323+00	2025-12-06 03:39:34.16934+00	t	\N	\N
164	5abe003e-34dd-422b-9a00-5ae79ff75796	2025-12-06 03:39:34.232305+00	2025-12-06 03:39:34.232323+00	t	\N	\N
165	ead6a288-7a90-4d99-9afa-d2b4a9caf3d3	2025-12-06 03:39:34.296128+00	2025-12-06 03:39:34.296149+00	t	\N	\N
166	0015effc-d330-49c9-9b09-62c91053e4fd	2025-12-06 10:08:13.593477+00	2025-12-06 10:08:13.593507+00	t	\N	\N
167	f3f17e50-a2e1-42ae-9ed7-b53cfbb3461f	2025-12-06 10:08:13.679291+00	2025-12-06 10:08:13.679306+00	t	\N	\N
168	f8cbf6ee-d80e-4cc5-a6aa-f952dd52f40c	2025-12-06 10:08:13.745518+00	2025-12-06 10:08:13.745537+00	t	\N	\N
169	6b9e7047-8344-4f62-98ae-ec360cff1eac	2025-12-06 10:08:14.539227+00	2025-12-06 10:08:14.539251+00	t	\N	\N
170	132f9edc-71a5-475e-b05e-b4c533d0e9e3	2025-12-06 10:08:14.606182+00	2025-12-06 10:08:14.606199+00	t	\N	\N
171	91e7a8b2-c40d-4ac7-83fb-11849d409207	2025-12-06 10:08:14.67221+00	2025-12-06 10:08:14.672233+00	t	\N	\N
172	5f43efaa-d9d4-43c6-bc3c-fd08193662c0	2025-12-06 12:20:58.105664+00	2025-12-06 12:20:58.105684+00	t	\N	\N
173	82605972-4858-41c6-b0e2-961b991c64d9	2025-12-06 12:20:58.213215+00	2025-12-06 12:20:58.213234+00	t	\N	\N
174	74ed3a70-e0ff-4ce1-b487-9c78311a98d0	2025-12-06 12:20:58.277557+00	2025-12-06 12:20:58.277573+00	t	\N	\N
175	f4c07fdb-a87f-4fa8-b6ce-c44186a9930e	2025-12-06 12:20:59.072046+00	2025-12-06 12:20:59.072066+00	t	\N	\N
176	9a10e09c-36e7-4921-8864-c55048315fc9	2025-12-06 12:20:59.138553+00	2025-12-06 12:20:59.13857+00	t	\N	\N
177	7c2cd701-ccce-4568-9021-ff587311cd26	2025-12-06 12:20:59.204544+00	2025-12-06 12:20:59.20456+00	t	\N	\N
178	3316e1c0-6b51-467e-9209-da5988d558bf	2025-12-06 12:21:16.041054+00	2025-12-06 12:21:16.041072+00	t	\N	\N
179	a27d8f11-de85-4996-b3a2-4bcc31fe7e50	2025-12-06 12:21:16.103952+00	2025-12-06 12:21:16.103968+00	t	\N	\N
180	8185c6aa-eb6c-417a-8c49-a790a8746590	2025-12-06 12:21:16.165252+00	2025-12-06 12:21:16.16527+00	t	\N	\N
181	ccb349a3-0a03-497d-be5c-654bd5e6dd09	2025-12-06 12:21:16.964399+00	2025-12-06 12:21:16.964418+00	t	\N	\N
182	d12a0f57-cf45-41df-ba29-c0566c25cab8	2025-12-06 12:21:17.029063+00	2025-12-06 12:21:17.029084+00	t	\N	\N
183	763039e8-0d03-4786-90f1-4b6bb4f0624c	2025-12-06 12:21:17.092531+00	2025-12-06 12:21:17.092548+00	t	\N	\N
184	9daae695-0478-471d-87f8-e103b0b81a0f	2025-12-06 12:21:31.888506+00	2025-12-06 12:21:31.888525+00	t	\N	\N
185	0c1d0c20-c768-48db-ab8f-fa71447bea67	2025-12-06 12:21:31.953115+00	2025-12-06 12:21:31.95313+00	t	\N	\N
186	29918a41-7c12-45f5-b5e6-a8eebbbb2e18	2025-12-06 12:21:32.01622+00	2025-12-06 12:21:32.016236+00	t	\N	\N
187	7e7f1599-5011-4d31-9cbf-f77f84d1c67b	2025-12-06 12:21:48.163507+00	2025-12-06 12:21:48.163524+00	t	\N	\N
188	f9aea0de-67aa-4ddf-932e-cb482cd39375	2025-12-06 12:21:48.227818+00	2025-12-06 12:21:48.227839+00	t	\N	\N
189	d8a4594c-71f5-4159-870f-727b61cc863b	2025-12-06 12:21:48.29053+00	2025-12-06 12:21:48.290548+00	t	\N	\N
190	16f9252b-f8e8-44e8-b286-a32c76cf3579	2025-12-06 12:21:50.429405+00	2025-12-06 12:21:50.429426+00	t	\N	\N
191	d1edbe29-72df-4b02-99b0-928fb0cb993f	2025-12-06 12:21:50.494531+00	2025-12-06 12:21:50.494577+00	t	\N	\N
192	fc439a8b-bba5-40cb-91dd-e68e3fb68988	2025-12-06 12:21:50.559864+00	2025-12-06 12:21:50.559884+00	t	\N	\N
193	bdb744a7-000b-4ed2-802a-555e5247d720	2025-12-06 14:54:17.217459+00	2025-12-06 14:54:17.217481+00	t	\N	\N
194	c4537285-299c-4316-a6d7-ceeb860e9870	2025-12-06 14:54:17.327217+00	2025-12-06 14:54:17.327236+00	t	\N	\N
195	5b3b2142-53c9-41cb-95e8-f335a1ee15b2	2025-12-06 14:54:17.392472+00	2025-12-06 14:54:17.39251+00	t	\N	\N
196	c2e550e4-3e1d-473f-b81a-7998daf059c9	2025-12-06 14:54:18.016562+00	2025-12-06 14:54:18.016585+00	t	\N	\N
197	b8d83ce7-ba53-4ef7-bbb7-fbb3d4b837dc	2025-12-06 14:54:18.082269+00	2025-12-06 14:54:18.082289+00	t	\N	\N
198	3f390dd1-8f8e-45f9-b8b1-e579d8612268	2025-12-06 14:54:18.145928+00	2025-12-06 14:54:18.145941+00	t	\N	\N
199	eaf4a322-0cf4-4ca1-8ffc-e4deb746a2b0	2025-12-06 14:55:59.643433+00	2025-12-06 14:55:59.643454+00	t	\N	\N
200	5928a490-cb7e-46ab-b32f-7853f3866f78	2025-12-06 14:55:59.707173+00	2025-12-06 14:55:59.70719+00	t	\N	\N
201	f7ba0fea-e00a-422d-a04f-1203836cebd4	2025-12-06 14:55:59.770516+00	2025-12-06 14:55:59.770533+00	t	\N	\N
202	27daebfd-d61e-4691-be34-87a93dda51e7	2025-12-06 14:56:00.310559+00	2025-12-06 14:56:00.310581+00	t	\N	\N
203	1caf1c23-b92e-4c2f-8485-e57bf6513571	2025-12-06 14:56:00.375006+00	2025-12-06 14:56:00.375025+00	t	\N	\N
204	da5be12a-f9e4-4672-82e2-1ab91b0f7913	2025-12-06 14:56:00.438045+00	2025-12-06 14:56:00.438063+00	t	\N	\N
206	e5cc2dc7-a156-4a11-989c-d9e915347e73	2025-12-08 08:53:07.333959+00	2025-12-08 08:53:07.333995+00	t	\N	\N
207	3fc05fa4-d792-4855-9ea1-3ae5a1559454	2025-12-08 08:53:07.449926+00	2025-12-08 08:53:07.449945+00	t	\N	\N
208	b2c70271-b521-4ba0-ac1d-c7d911b1ef67	2025-12-08 08:53:07.516544+00	2025-12-08 08:53:07.516561+00	t	\N	\N
209	a3c210fc-c00a-47af-a1e8-2d445aad9caa	2025-12-08 08:53:08.219113+00	2025-12-08 08:53:08.219137+00	t	\N	\N
210	99beb465-5fb5-4fc6-ac79-4d60391d5b24	2025-12-08 08:53:08.286331+00	2025-12-08 08:53:08.286355+00	t	\N	\N
211	866989ca-7730-4f0e-b673-e15238ccef42	2025-12-08 08:53:08.35191+00	2025-12-08 08:53:08.351929+00	t	\N	\N
212	394bb7ef-c78c-4319-8fa6-2854bdf0f7cf	2025-12-08 09:21:56.805075+00	2025-12-08 09:21:56.805116+00	t	\N	\N
213	1d55730f-cfcf-4a0c-8979-fc257cacee26	2025-12-08 09:21:56.890065+00	2025-12-08 09:21:56.89009+00	t	\N	\N
214	659fb619-1102-4079-ad2c-bdae8ba09aba	2025-12-08 09:21:56.958496+00	2025-12-08 09:21:56.958522+00	t	\N	\N
215	bc160233-b405-4899-9311-f521ad3dfef8	2025-12-08 09:21:57.723768+00	2025-12-08 09:21:57.723792+00	t	\N	\N
216	f0053646-8f82-46f4-826f-8eb66f6b3bcc	2025-12-08 09:21:57.796959+00	2025-12-08 09:21:57.79698+00	t	\N	\N
217	1adb507b-c973-4548-a316-aed645fef77d	2025-12-08 09:21:57.86329+00	2025-12-08 09:21:57.863308+00	t	\N	\N
218	1177a3fb-49fd-4ad5-a77c-83aafec5ea28	2025-12-09 08:06:06.16761+00	2025-12-09 08:06:06.167649+00	t	\N	\N
219	f842bfbe-33fa-4061-9d8d-de27f94f2fdf	2025-12-09 08:06:06.285872+00	2025-12-09 08:06:06.28589+00	t	\N	\N
220	f5a706cb-290e-4ef4-b5a7-f9f3438eb40b	2025-12-09 08:06:06.349467+00	2025-12-09 08:06:06.349508+00	t	\N	\N
221	3fcc4e01-a635-4e83-bc5c-93a9bf825ebd	2025-12-09 08:06:06.98724+00	2025-12-09 08:06:06.987261+00	t	\N	\N
222	c5d0ed5b-b6a6-4d75-90d4-e8661e2411d6	2025-12-09 08:06:07.05201+00	2025-12-09 08:06:07.052028+00	t	\N	\N
223	0088b036-3f83-4ee0-a9e3-1f0ab9b54d2d	2025-12-09 08:06:07.115038+00	2025-12-09 08:06:07.115055+00	t	\N	\N
224	6d325153-82bd-4065-902d-647ec4cee231	2025-12-09 16:39:52.829504+00	2025-12-09 16:39:52.82953+00	t	\N	\N
225	f9692bad-a1c3-4bd2-b49e-7adcb412e555	2025-12-09 16:39:52.943096+00	2025-12-09 16:39:52.943116+00	t	\N	\N
226	21b61d00-1fa9-4183-8374-c19cc96cfd38	2025-12-09 16:39:53.009579+00	2025-12-09 16:39:53.0096+00	t	\N	\N
227	57ef2297-2c96-447b-af10-7328537127e0	2025-12-09 16:39:53.806456+00	2025-12-09 16:39:53.806478+00	t	\N	\N
228	28ea0731-ba3c-40ba-9b39-159d1da7b9fb	2025-12-09 16:39:53.872979+00	2025-12-09 16:39:53.872997+00	t	\N	\N
229	6b50bb5c-362a-49ae-abce-7c708361caa6	2025-12-09 16:39:53.942215+00	2025-12-09 16:39:53.942233+00	t	\N	\N
230	a0b5a2ef-dac8-4238-9418-588d8b8762a5	2025-12-09 19:20:55.803382+00	2025-12-09 19:20:55.803399+00	t	\N	\N
231	dcd4a657-ee8e-41c0-bfac-43c1ebc90a2b	2025-12-09 19:20:57.063372+00	2025-12-09 19:20:57.063391+00	t	\N	\N
232	e8a0561f-8903-4a63-8235-45891a7d984c	2025-12-09 19:23:00.283251+00	2025-12-09 19:23:00.283269+00	t	\N	\N
233	06288c65-b0b1-42d2-9619-9b1a241ae99e	2025-12-09 19:23:00.362725+00	2025-12-09 19:23:00.36274+00	t	\N	\N
234	25149781-6a08-4c41-8efc-530d0fa07d4d	2025-12-09 19:23:00.426665+00	2025-12-09 19:23:00.426698+00	t	\N	\N
235	78b858af-c366-42e7-93e4-73fb292819e4	2025-12-09 19:23:01.000125+00	2025-12-09 19:23:01.000144+00	t	\N	\N
236	86f52ea1-46b3-4de5-8dc9-75a374c18bc2	2025-12-09 19:23:01.065304+00	2025-12-09 19:23:01.065323+00	t	\N	\N
237	f091948f-29ef-4de5-9438-ea17cf83acfb	2025-12-09 19:23:01.130642+00	2025-12-09 19:23:01.130661+00	t	\N	\N
238	b549ce79-1b7d-402b-b2cf-2b1d9df52800	2025-12-09 19:24:14.061888+00	2025-12-09 19:24:14.061934+00	t	\N	\N
239	1fcd7189-a3ce-430b-bd60-3a4044b6997a	2025-12-09 19:24:14.131989+00	2025-12-09 19:24:14.132011+00	t	\N	\N
240	0c87b509-69d9-47e0-b7af-c7d1b430949b	2025-12-09 19:24:14.200477+00	2025-12-09 19:24:14.200493+00	t	\N	\N
241	\N	2025-12-10 09:48:04.661887+00	2025-12-10 09:48:04.661907+00	t	\N	38
242	1606fad7-ccb5-4542-9a0b-75e530521c5c	2025-12-11 07:45:40.006488+00	2025-12-11 07:45:40.006508+00	t	\N	\N
243	d5e04c75-3c2b-4e52-963f-1f6b6725b4dc	2025-12-11 07:45:40.100491+00	2025-12-11 07:45:40.100507+00	t	\N	\N
244	8a408c58-d3eb-43f7-b215-17e5f9520fcf	2025-12-11 07:45:40.166737+00	2025-12-11 07:45:40.166755+00	t	\N	\N
245	9caf53ee-6e57-48b6-a711-23367293c772	2025-12-11 07:45:40.743839+00	2025-12-11 07:45:40.743856+00	t	\N	\N
246	916e156e-3a6c-4529-a693-3addaff86bd5	2025-12-11 07:45:40.814833+00	2025-12-11 07:45:40.814853+00	t	\N	\N
247	42061371-78ff-4523-baa3-39450046809e	2025-12-11 07:45:40.882151+00	2025-12-11 07:45:40.882171+00	t	\N	\N
248	46b42eee-6b0b-444e-aab2-d0d581b60556	2025-12-11 15:20:27.352048+00	2025-12-11 15:20:27.352064+00	t	\N	\N
249	d5e53924-4101-442f-a486-c5eab723b8ae	2025-12-12 21:36:18.16672+00	2025-12-12 21:36:18.166744+00	t	\N	\N
250	b6c617f8-4801-4bdc-8664-e3c01e3a6336	2025-12-12 21:36:18.290171+00	2025-12-12 21:36:18.290192+00	t	\N	\N
251	910db665-d899-45c8-ad7f-9fd6ac082dae	2025-12-12 21:36:18.353332+00	2025-12-12 21:36:18.353352+00	t	\N	\N
252	138eecfb-4899-4b2a-8aed-f759a21f3de7	2025-12-12 21:36:19.164148+00	2025-12-12 21:36:19.164166+00	t	\N	\N
253	e3505db7-7da3-48f0-a082-30b36aaae1c8	2025-12-12 21:36:19.22793+00	2025-12-12 21:36:19.227949+00	t	\N	\N
254	0aff9aa1-86f0-49d6-9666-1effa24ab383	2025-12-12 21:36:19.293974+00	2025-12-12 21:36:19.293992+00	t	\N	\N
255	af0e46cd-877f-441e-b0c8-d29246ac57f2	2025-12-15 20:01:10.451631+00	2025-12-15 20:01:10.451655+00	t	\N	\N
256	ed20a2da-5b87-4c4e-97e5-7803f3eb92ca	2025-12-15 20:01:10.56687+00	2025-12-15 20:01:10.566889+00	t	\N	\N
257	d4a25ee7-5795-4bae-a36c-d0a48af6975d	2025-12-15 20:01:10.634591+00	2025-12-15 20:01:10.63461+00	t	\N	\N
258	5f64f66c-ef32-4a49-b7e1-296f566fc40c	2025-12-15 20:01:11.278183+00	2025-12-15 20:01:11.278203+00	t	\N	\N
259	3bb1758d-5177-4781-995d-373c1f04f70e	2025-12-15 20:01:11.347786+00	2025-12-15 20:01:11.347804+00	t	\N	\N
260	4d8ca9d8-4c77-4cd7-a23a-95581fba5036	2025-12-15 20:01:11.416524+00	2025-12-15 20:01:11.416557+00	t	\N	\N
261	1a4025a8-9aaa-436f-a57d-49486c0d9bc8	2025-12-16 15:26:09.354621+00	2025-12-16 15:26:09.35466+00	t	\N	\N
262	c876bdc4-1275-4a83-bd1d-09c243171749	2025-12-16 15:26:09.500348+00	2025-12-16 15:26:09.500366+00	t	\N	\N
263	6a61781b-6797-496d-a97f-2fb75c8eb8bf	2025-12-16 15:26:09.567206+00	2025-12-16 15:26:09.567226+00	t	\N	\N
264	d40d5a40-772f-46aa-87e7-10da810f0cda	2025-12-16 15:26:10.657288+00	2025-12-16 15:26:10.657308+00	t	\N	\N
265	4471f5de-95e9-4743-ba80-f1c2f7ec14f9	2025-12-16 15:26:10.723493+00	2025-12-16 15:26:10.723512+00	t	\N	\N
266	3fbb4fe0-fad4-4aa1-ab3d-b5587e3c0ff8	2025-12-16 15:26:10.79016+00	2025-12-16 15:26:10.790174+00	t	\N	\N
267	449e8673-f539-4aa0-aa7a-88daf5b281af	2025-12-16 15:26:11.396025+00	2025-12-16 15:26:11.396046+00	t	\N	\N
268	ad46bd59-be62-40ec-aa88-9cba68bf8932	2025-12-16 15:26:11.465503+00	2025-12-16 15:26:11.465521+00	t	\N	\N
269	7402fb38-14a8-4314-99d0-0e912d2b3871	2025-12-16 15:26:11.532439+00	2025-12-16 15:26:11.532459+00	t	\N	\N
270	eeffd1f8-cdbd-4e1d-9448-2d373b52940e	2025-12-18 15:39:19.905813+00	2025-12-18 15:39:19.905834+00	t	\N	\N
271	55816b94-b7bb-414c-b5e1-a25803815e0c	2025-12-18 15:39:20.001126+00	2025-12-18 15:39:20.001147+00	t	\N	\N
272	851da4f3-8c1f-4aaf-bbf3-c358dc9d0287	2025-12-18 15:39:20.066483+00	2025-12-18 15:39:20.066506+00	t	\N	\N
273	a90c863e-d4d5-4830-9cbe-c40abd2c5d69	2025-12-18 15:39:21.129907+00	2025-12-18 15:39:21.129929+00	t	\N	\N
274	7651c31b-b857-4c6f-8b22-03d035228072	2025-12-18 15:39:21.196776+00	2025-12-18 15:39:21.196799+00	t	\N	\N
275	4d485b51-7628-4f5e-92c4-1f30e2d7b233	2025-12-18 15:39:21.264747+00	2025-12-18 15:39:21.26477+00	t	\N	\N
276	5da4a67d-2d52-4bd0-aa99-56a80c17530f	2025-12-18 16:18:32.474587+00	2025-12-18 16:18:32.474612+00	t	\N	\N
277	31f98b95-160d-4456-a18f-00cdb72c1638	2025-12-18 16:18:32.554334+00	2025-12-18 16:18:32.554351+00	t	\N	\N
278	e0ffc0aa-5d41-4b16-81f6-48ca3feb6492	2025-12-18 16:18:32.62523+00	2025-12-18 16:18:32.625248+00	t	\N	\N
279	f1dea4c6-3af6-442d-89ab-a01d8eb87fa4	2025-12-18 16:18:33.274499+00	2025-12-18 16:18:33.274521+00	t	\N	\N
280	7ec377a7-dc39-495e-afd2-171687be4a63	2025-12-18 16:18:33.349771+00	2025-12-18 16:18:33.349794+00	t	\N	\N
281	67a36214-e988-4494-b60d-7bdc77ddf215	2025-12-18 16:18:33.421952+00	2025-12-18 16:18:33.421971+00	t	\N	\N
282	1644ef36-026f-45d6-87cc-a5babed24437	2025-12-18 19:56:54.500981+00	2025-12-18 19:56:54.501014+00	t	\N	\N
283	2c2742b2-b726-4506-849d-123204db9d14	2025-12-18 19:56:54.629427+00	2025-12-18 19:56:54.629443+00	t	\N	\N
284	1cbb33fb-72bd-40f1-96dc-01b2fcade6cc	2025-12-18 19:56:54.697676+00	2025-12-18 19:56:54.697695+00	t	\N	\N
285	a8cdb32d-abcc-43f9-a6cb-e6c5fe44c7fa	2025-12-18 19:56:55.299362+00	2025-12-18 19:56:55.299379+00	t	\N	\N
286	c917b2b2-d304-4e4d-ae16-f5bf9a0112b6	2025-12-18 19:56:55.367707+00	2025-12-18 19:56:55.367722+00	t	\N	\N
287	56a1c7e1-5fbe-4a2c-b26c-a020878a3b25	2025-12-18 19:56:55.436435+00	2025-12-18 19:56:55.436451+00	t	\N	\N
308	\N	2026-02-04 10:38:23.736122+00	2026-02-04 10:38:23.736139+00	t	\N	41
312	\N	2026-02-10 15:16:09.118279+00	2026-02-10 15:16:09.118295+00	t	\N	13
292	\N	2025-12-29 08:26:36.651779+00	2025-12-29 08:26:39.060101+00	f	\N	40
293	\N	2025-12-29 21:58:26.178806+00	2025-12-29 21:58:26.178825+00	t	\N	44
294	\N	2026-01-04 19:23:01.422262+00	2026-01-04 19:23:01.422283+00	t	\N	42
295	\N	2026-01-04 20:31:44.899105+00	2026-01-04 20:31:44.899127+00	t	\N	49
\.


--
-- TOC entry 4424 (class 0 OID 126979)
-- Dependencies: 382
-- Data for Name: basket_basketitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.basket_basketitem (id, quantity, accessory_id, basket_id, product_id, supply_id) FROM stdin;
15	1	\N	231	\N	\N
16	1	\N	241	\N	\N
84	3	\N	294	101	424
83	4	\N	294	73	433
87	1	\N	294	107	419
88	3	\N	295	107	419
\.


--
-- TOC entry 4420 (class 0 OID 126960)
-- Dependencies: 378
-- Data for Name: discount_codes_discountcode; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount_codes_discountcode (id, code, description, discount_percent, active, valid_from, valid_to) FROM stdin;
2	NEWCODE	NEWCODE test description	50.00	t	2026-01-01 12:11:14+00	2026-05-30 12:11:19+00
1	NEWCODE_1	NEWCODE_1 test description	20.00	t	2026-01-02 12:10:39+00	2026-10-25 12:10:52+00
\.


--
-- TOC entry 4387 (class 0 OID 116711)
-- Dependencies: 345
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2026-01-02 12:10:55.938992+00	1	NEWCODE_1	1	[{"added": {}}]	26	45
2	2026-01-02 12:11:20.625563+00	2	NEWCODE	1	[{"added": {}}]	26	45
3	2026-02-03 15:08:29.913325+00	2	NEWCODE	2	[{"changed": {"fields": ["Valid to"]}}]	26	45
4	2026-02-03 15:09:24.62209+00	2	NEWCODE	2	[]	26	45
5	2026-02-03 15:09:35.671208+00	1	NEWCODE_1	2	[{"changed": {"fields": ["Valid to"]}}]	26	45
6	2026-02-10 23:22:09.681438+00	15	Movenpick Caffe Crema - Ground	2	[{"changed": {"fields": ["Price"]}}]	17	45
7	2026-02-10 23:23:04.351432+00	241	Nescafe Espresso instant coffee powder - Ground	2	[{"changed": {"fields": ["Price"]}}]	17	45
8	2026-02-10 23:23:18.261513+00	242	Nescafe Espresso instant coffee powder - Ground	2	[{"changed": {"fields": ["Price"]}}]	17	45
9	2026-02-11 19:35:28.072226+00	13	Reusable Coffee Filter by BeanWorks	1	new through import_export	22	45
10	2026-02-11 19:35:28.07229+00	14	Coffee Grinder by CafeLux	1	new through import_export	22	45
11	2026-02-11 19:35:28.072345+00	15	Reusable Coffee Filter by BrewMaster	1	new through import_export	22	45
12	2026-02-11 19:35:28.072366+00	16	Latte Art Pen by BrewMaster	1	new through import_export	22	45
13	2026-02-11 19:35:28.072383+00	17	French Press by CaffeineCo	1	new through import_export	22	45
14	2026-02-11 19:35:28.072399+00	18	Espresso Tamper by BeanWorks	1	new through import_export	22	45
15	2026-02-11 19:35:28.072414+00	19	Milk Frother by CafeLux	1	new through import_export	22	45
16	2026-02-11 19:35:28.072428+00	20	Coffee Scale by BrewMaster	1	new through import_export	22	45
17	2026-02-11 19:35:28.072442+00	21	Coffee Grinder by BeanWorks	1	new through import_export	22	45
18	2026-02-11 19:35:28.072455+00	22	Milk Frother by AromaPlus	1	new through import_export	22	45
19	2026-02-11 19:35:28.072469+00	23	Coffee Scale by BeanWorks	1	new through import_export	22	45
20	2026-02-11 19:35:28.072483+00	24	Coffee Scoop by CafeLux	1	new through import_export	22	45
\.


--
-- TOC entry 4391 (class 0 OID 116753)
-- Dependencies: 349
-- Data for Name: django_celery_results_chordcounter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_celery_results_chordcounter (id, group_id, sub_tasks, count) FROM stdin;
\.


--
-- TOC entry 4393 (class 0 OID 116765)
-- Dependencies: 351
-- Data for Name: django_celery_results_groupresult; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_celery_results_groupresult (id, group_id, date_created, date_done, content_type, content_encoding, result) FROM stdin;
\.


--
-- TOC entry 4389 (class 0 OID 116732)
-- Dependencies: 347
-- Data for Name: django_celery_results_taskresult; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_celery_results_taskresult (id, task_id, status, content_type, content_encoding, result, date_done, traceback, meta, task_args, task_kwargs, task_name, worker, date_created, periodic_task_name, date_started) FROM stdin;
\.


--
-- TOC entry 4371 (class 0 OID 116593)
-- Dependencies: 329
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	token_blacklist	blacklistedtoken
7	token_blacklist	outstandingtoken
8	django_celery_results	taskresult
9	django_celery_results	chordcounter
10	django_celery_results	groupresult
11	users	usermodel
12	users	userprofilemodel
13	products	flavorprofile
14	products	product
15	products	photo
16	products	productphotosmodel
17	supplies	supply
18	subscription	subscription
19	reviews	review
20	orders	order
21	orders	orderposition
22	accessories	accessory
23	accessories	accessoryphotosmodel
24	basket	basket
25	basket	basketitem
26	discount_codes	discountcode
27	favorites	favoriteitem
28	favorites	favorites
\.


--
-- TOC entry 4369 (class 0 OID 116561)
-- Dependencies: 327
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
68	accessories	0001_initial	2026-02-11 19:19:23.685771+00
69	accessories	0002_alter_accessoryphotosmodel_photo	2026-02-11 19:19:24.504196+00
70	contenttypes	0001_initial	2026-02-11 19:19:25.126766+00
71	contenttypes	0002_remove_content_type_name	2026-02-11 19:20:53.391942+00
72	auth	0001_initial	2026-02-11 19:21:42.646214+00
73	auth	0002_alter_permission_name_max_length	2026-02-11 19:21:43.461689+00
74	auth	0003_alter_user_email_max_length	2026-02-11 19:21:44.100899+00
75	auth	0004_alter_user_username_opts	2026-02-11 19:21:44.922761+00
76	auth	0005_alter_user_last_login_null	2026-02-11 19:21:45.652029+00
77	auth	0006_require_contenttypes_0002	2026-02-11 19:21:46.330531+00
78	auth	0007_alter_validators_add_error_messages	2026-02-11 19:21:46.990167+00
79	auth	0008_alter_user_username_max_length	2026-02-11 19:21:47.697621+00
80	auth	0009_alter_user_last_name_max_length	2026-02-11 19:21:48.489749+00
81	auth	0010_alter_group_name_max_length	2026-02-11 19:21:49.819551+00
82	auth	0011_update_proxy_permissions	2026-02-11 19:21:50.476123+00
83	auth	0012_alter_user_first_name_max_length	2026-02-11 19:21:51.378492+00
84	users	0001_initial	2026-02-11 19:21:52.682649+00
85	admin	0001_initial	2026-02-11 19:21:53.296608+00
86	admin	0002_logentry_remove_auto_add	2026-02-11 19:21:53.654203+00
87	admin	0003_logentry_add_action_flag_choices	2026-02-11 19:21:54.53418+00
88	products	0001_initial	2026-02-11 19:21:55.754312+00
89	supplies	0001_initial	2026-02-11 19:21:56.262477+00
90	discount_codes	0001_initial	2026-02-11 19:21:56.780894+00
91	basket	0001_initial	2026-02-11 19:21:57.290454+00
92	basket	0002_initial	2026-02-11 19:22:00.674061+00
93	django_celery_results	0001_initial	2026-02-11 19:22:01.183683+00
94	django_celery_results	0002_add_task_name_args_kwargs	2026-02-11 19:23:19.411307+00
95	django_celery_results	0003_auto_20181106_1101	2026-02-11 19:23:19.718064+00
96	django_celery_results	0004_auto_20190516_0412	2026-02-11 19:23:20.026693+00
97	django_celery_results	0005_taskresult_worker	2026-02-11 19:23:20.332823+00
98	django_celery_results	0006_taskresult_date_created	2026-02-11 19:23:20.640623+00
99	django_celery_results	0007_remove_taskresult_hidden	2026-02-11 19:23:20.947517+00
100	django_celery_results	0008_chordcounter	2026-02-11 19:23:21.255219+00
101	django_celery_results	0009_groupresult	2026-02-11 19:23:21.560287+00
102	django_celery_results	0010_remove_duplicate_indices	2026-02-11 19:23:21.868397+00
103	django_celery_results	0011_taskresult_periodic_task_name	2026-02-11 19:23:22.177435+00
104	django_celery_results	0012_taskresult_date_started	2026-02-11 19:23:22.483324+00
105	django_celery_results	0013_taskresult_django_cele_periodi_1993cf_idx	2026-02-11 19:23:22.69063+00
106	django_celery_results	0014_alter_taskresult_status	2026-02-11 19:23:22.897574+00
107	favorites	0001_initial	2026-02-11 19:23:58.738258+00
108	favorites	0002_initial	2026-02-11 19:24:00.481204+00
109	orders	0001_initial	2026-02-11 19:24:01.00915+00
110	orders	0002_initial	2026-02-11 19:24:04.159689+00
111	orders	0003_rename_billing_apartment_number_order_apartment_number_and_more	2026-02-11 19:25:08.375829+00
112	orders	0004_rename_billing_phone_number_order_phone_number	2026-02-11 19:25:08.672328+00
113	orders	0005_order_updated_at	2026-02-11 19:25:08.978774+00
114	orders	0006_remove_orderposition_total_price	2026-02-11 19:25:09.285684+00
115	orders	0007_orderposition_price	2026-02-11 19:25:09.594084+00
116	orders	0008_order_currency	2026-02-11 19:25:09.900096+00
117	products	0002_alter_productphotosmodel_photo	2026-02-11 19:25:48.30111+00
118	sessions	0001_initial	2026-02-11 19:25:49.123336+00
119	token_blacklist	0001_initial	2026-02-11 19:25:50.433633+00
120	token_blacklist	0002_outstandingtoken_jti_hex	2026-02-11 19:25:51.095121+00
121	token_blacklist	0003_auto_20171017_2007	2026-02-11 19:27:54.150932+00
122	token_blacklist	0004_auto_20171017_2013	2026-02-11 19:27:54.365116+00
123	token_blacklist	0005_remove_outstandingtoken_jti	2026-02-11 19:27:54.568693+00
124	token_blacklist	0006_auto_20171017_2113	2026-02-11 19:27:54.772722+00
125	token_blacklist	0007_auto_20171017_2214	2026-02-11 19:27:55.071372+00
126	token_blacklist	0008_migrate_to_bigautofield	2026-02-11 19:27:55.372066+00
127	token_blacklist	0010_fix_migrate_to_bigautofield	2026-02-11 19:27:55.577168+00
128	token_blacklist	0011_linearizes_history	2026-02-11 19:27:55.891376+00
129	token_blacklist	0012_alter_outstandingtoken_user	2026-02-11 19:27:56.198151+00
130	token_blacklist	0013_alter_blacklistedtoken_options_and_more	2026-02-11 19:27:56.505899+00
131	users	0002_alter_usermodel_avatar	2026-02-11 19:28:35.213112+00
\.


--
-- TOC entry 4410 (class 0 OID 116911)
-- Dependencies: 368
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
ids3oivwyhsvedoeragtmdmmtxb515kg	.eJxVjEEOwiAQAP_C2ZBCQViP3n0DYdlFqgaS0p6MfzckPeh1ZjJvEeK-lbB3XsNC4iKMFadfiDE9uQ5Dj1jvTaZWt3VBORJ52C5vjfh1Pdq_QYm9jO9ZewuzcsaDUSbnBB4QvWLG5JJmgIRzjtkizqTZK-WJlNN2mhiIxecL_jc4VA:1vaWue:Xb9LBoKzR2qsaNZUaQny68eznA3o4JPaDwXi3F6FaCI	2026-01-13 10:25:12.536705+00
rkau7fzqr44810s01zwyb8j4sbwo8nz2	.eJxVjEEOwiAQAP_C2ZBCQViP3n0DYdlFqgaS0p6MfzckPeh1ZjJvEeK-lbB3XsNC4iKMFadfiDE9uQ5Dj1jvTaZWt3VBORJ52C5vjfh1Pdq_QYm9jO9ZewuzcsaDUSbnBB4QvWLG5JJmgIRzjtkizqTZK-WJlNN2mhiIxecL_jc4VA:1vnI0U:ANbpukrA_MVS40TVERifbok-UbY1YMlBLqfR9p1zgpA	2026-02-17 15:07:58.824225+00
04pd9ulxk256fi9nskktu03rgep3fg2i	.eJxVjEEOwiAQAP_C2ZBCQViP3n0DYdlFqgaS0p6MfzckPeh1ZjJvEeK-lbB3XsNC4iKMFadfiDE9uQ5Dj1jvTaZWt3VBORJ52C5vjfh1Pdq_QYm9jO9ZewuzcsaDUSbnBB4QvWLG5JJmgIRzjtkizqTZK-WJlNN2mhiIxecL_jc4VA:1vpx2c:Fg-nMiS4KdGp0p1ybxxBacf-wpuGzwFrPEdB3EB0qd0	2026-02-24 23:21:10.125451+00
\.


--
-- TOC entry 4429 (class 0 OID 134797)
-- Dependencies: 387
-- Data for Name: favorites_favoriteitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorites_favoriteitem (id, added_at, accessory_id, product_id, supply_id, favorites_id) FROM stdin;
11	2025-12-05 15:58:49.544393+00	2	\N	\N	1
38	2025-12-06 12:30:20.611004+00	\N	101	\N	1
40	2025-12-06 12:30:31.067723+00	\N	73	\N	1
\.


--
-- TOC entry 4427 (class 0 OID 134791)
-- Dependencies: 385
-- Data for Name: favorites_favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorites_favorites (id, created_at, updated_at, user_id) FROM stdin;
1	2025-12-01 17:56:50.051388+00	2025-12-01 17:56:50.051409+00	13
\.


--
-- TOC entry 4395 (class 0 OID 116784)
-- Dependencies: 353
-- Data for Name: flavor_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flavor_profile (id, name) FROM stdin;
6	Intense
7	
\.


--
-- TOC entry 4407 (class 0 OID 116860)
-- Dependencies: 365
-- Data for Name: order_positions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_positions (id, quantity, date, accessory_id, order_id, product_id, price) FROM stdin;
56	1	2026-01-07 14:53:31.389183+00	4	82	\N	19.00
57	1	2026-01-07 15:08:08.650165+00	7	83	\N	26.00
58	1	2026-01-07 15:08:08.72167+00	\N	83	73	2.20
59	3	2026-01-11 11:29:32.541313+00	\N	84	73	2.20
71	1	2026-02-03 17:37:01.257832+00	1	99	\N	20.00
74	1	2026-02-03 17:54:39.220351+00	\N	102	73	2.20
76	3	2026-02-04 16:17:38.938572+00	10	104	\N	30.00
77	1	2026-02-10 15:03:18.048212+00	\N	105	15	20.00
78	1	2026-02-10 15:16:11.192712+00	\N	106	15	20.00
79	2	2026-02-10 15:16:11.270503+00	\N	106	83	20.00
\.


--
-- TOC entry 4405 (class 0 OID 116852)
-- Dependencies: 363
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, order_notes, status, ttn, created_at, customer_id, discount_code_id, apartment_number, company_name, country, first_name, last_name, phone_number, region, state, street_name, zip_code, updated_at, currency) FROM stdin;
84		delivered	\N	2026-01-11 11:29:32.415014+00	13	2	15	Microsoft	Ukraine	Kateryna	Rost	+380502333395	Kharkiv	Kharkiv	Neskorenykh	11111	2026-02-03 16:51:56.732728+00	USD
83		in_transit	\N	2026-01-07 15:08:08.546994+00	13	2	15	Microsoft	Ukraine	Kateryna	Rost	+380502333395	Kharkiv	Kharkiv	Neskorenykh	11111	2026-02-03 16:57:09.932334+00	USD
102		processing	\N	2026-02-03 17:54:39.032416+00	13	\N	15	Microsoft	Ukraine	Kateryna	Rost	+380502333395	Kharkiv	Kharkiv	Neskorenykh	11111	2026-02-03 17:54:39.03266+00	UAH
99		shipping	\N	2026-02-03 17:37:01.148143+00	13	\N	15	Microsoft	Ukraine	Kateryna	Rost	+380502333395	Kharkiv	Kharkiv	Neskorenykh	11111	2026-02-10 08:36:05.516451+00	UAH
104		preparing	\N	2026-02-04 16:17:38.824418+00	13	\N	20	Microsoft	Ukraine	Kateryna	Rost	+380502333399	Kharkiv	Kharkiv	Neskorenykh	11111	2026-02-10 08:36:28.148734+00	USD
105		processing	\N	2026-02-10 15:03:17.93015+00	13	\N	20	Microsoft	Ukraine	Kateryna	Rost	+380502333399	Kharkiv	Kharkiv	Neskorenykh	11111	2026-02-10 15:03:17.930498+00	USD
106		delivered	\N	2026-02-10 15:16:11.085447+00	13	2	20	Microsoft	Ukraine	Kateryna	Rost	+380502333399	Kharkiv	Kharkiv	Neskorenykh	11111	2026-02-10 16:01:18.250274+00	USD
82		processing	\N	2026-01-07 14:53:31.263976+00	13	2	15	Microsoft	Ukraine	Kateryna	Rost	+380502333395	Kharkiv	Kharkiv	Neskorenykh	11111	2026-01-07 14:53:31.264259+00	USD
\.


--
-- TOC entry 4401 (class 0 OID 116806)
-- Dependencies: 359
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photo (id, url, "position", accessory_id, product_id) FROM stdin;
7	https://cdn.pacifiko.com/image/cache/catalog/p/Yjk2Y2FkND-250x250.jpg	1	1	\N
8	https://5.imimg.com/data5/OM/CS/MY-29080902/single-espresso-coffee-grinder-250x250.jpg	1	2	\N
9	https://cdn.shoplightspeed.com/shops/626057/files/51461095/250x250x1/image.jpg	1	3	\N
10	https://pentrubar.ro/5250-home_default/blue-latte-art-pen-motta-for-cappuccino-decoration.jpg	1	4	\N
11	https://www.scandinavia-design.fr/shop/129298-home_default/french-press-brewer-1l-hay-clear.jpg	1	5	\N
12	https://assets.wsimgs.com/wsimgs/rk/images/dp/wcm/202536/0186/breville-force-gauge-tamper-espresso-tamper-j.jpg	1	6	\N
13	https://assets.expondo.com/asset/product_photos/10013044_photo_4?twic=v1/contain=1024x250	1	7	\N
14	https://www.voltagerestaurantsupply.com/cdn/shop/files/rhino-coffee-gear-scales-28433482252352_250x250_crop_center.jpg?v=1716320601	1	8	\N
15	https://static.wixstatic.com/media/a57f41_8859d054fbd94ca2908ef7fc1a95e9df~mv2.png/v1/fill/w_250,h_250,q_30/a57f41_8859d054fbd94ca2908ef7fc1a95e9df~mv2.png	1	9	\N
16	https://www.voltagerestaurantsupply.com/cdn/shop/files/rhino-coffee-gear-scales-28433482252352_250x250_crop_center.jpg?v=1716320601	1	10	\N
17	https://5.imimg.com/data5/ECOM/Default/2023/7/321638297/WE/UW/YE/8500341/s-l2000-17170-250x250.jpg	1	11	\N
18	https://www.espressocoffeeshop.com/2441-home_default/rocket-spluga-coffee-grinder.jpg	1	12	\N
191	https://content2.rozetka.com.ua/goods/images/big/364966344.png	0	\N	71
192	https://content.rozetka.com.ua/goods/images/big/364966347.png	1	\N	71
195	https://content1.rozetka.com.ua/goods/images/big/532858546.png	0	\N	72
196	https://content1.rozetka.com.ua/goods/images/big/532858547.png	1	\N	72
197	https://content1.rozetka.com.ua/goods/images/big/364969772.png	2	\N	72
198	https://content2.rozetka.com.ua/goods/images/big/364969773.jpg	3	\N	72
199	https://content.rozetka.com.ua/goods/images/big/562188388.jpg	0	\N	73
200	https://content1.rozetka.com.ua/goods/images/big/562188389.jpg	1	\N	73
201	https://content1.rozetka.com.ua/goods/images/big/562188390.jpg	2	\N	73
202	https://content1.rozetka.com.ua/goods/images/big/534483389.jpg	0	\N	74
203	https://content.rozetka.com.ua/goods/images/big/534483390.jpg	1	\N	74
204	https://content.rozetka.com.ua/goods/images/big/318888009.jpg	0	\N	75
205	https://content1.rozetka.com.ua/goods/images/big/318889739.jpg	0	\N	76
206	https://content.rozetka.com.ua/goods/images/big/498783382.jpg	0	\N	77
207	https://content1.rozetka.com.ua/goods/images/big/557426244.webp	0	\N	78
208	https://content2.rozetka.com.ua/goods/images/big/362181994.jpg	0	\N	79
209	https://content1.rozetka.com.ua/goods/images/big/362182001.jpg	1	\N	79
210	https://content.rozetka.com.ua/goods/images/big/362182011.jpg	2	\N	79
211	https://content.rozetka.com.ua/goods/images/big/362182025.jpg	3	\N	79
212	https://content2.rozetka.com.ua/goods/images/big/362182043.jpg	4	\N	79
213	https://content.rozetka.com.ua/goods/images/big/556473473.jpg	0	\N	80
214	https://content1.rozetka.com.ua/goods/images/big/556473487.jpg	1	\N	80
215	https://content.rozetka.com.ua/goods/images/big/556473497.jpg	2	\N	80
216	https://content2.rozetka.com.ua/goods/images/big/556473507.jpg	3	\N	80
217	https://content.rozetka.com.ua/goods/images/big/545443628.jpg	0	\N	81
218	https://content.rozetka.com.ua/goods/images/big/553911363.png	0	\N	82
219	https://content.rozetka.com.ua/goods/images/big/475820913.jpg	1	\N	82
222	https://content.rozetka.com.ua/goods/images/big/558989313.png	0	\N	84
226	https://content.rozetka.com.ua/goods/images/big/538444625.jpg	0	\N	86
227	https://content2.rozetka.com.ua/goods/images/big/404253972.jpg	0	\N	87
228	https://content1.rozetka.com.ua/goods/images/big/404253973.jpg	1	\N	87
229	https://content2.rozetka.com.ua/goods/images/big/404253974.jpg	2	\N	87
230	https://content1.rozetka.com.ua/goods/images/big/457938964.png	0	\N	88
231	https://content2.rozetka.com.ua/goods/images/big/550658826.jpg	0	\N	89
232	https://content1.rozetka.com.ua/goods/images/big/550658839.jpg	1	\N	89
233	https://content1.rozetka.com.ua/goods/images/big/553576143.jpg	0	\N	90
246	https://coffeemart.com.ua/images/product_images/popup_images/6326_0.jpg	0	\N	95
247	https://coffeemart.com.ua/images/product_images/popup_images/6326_1.jpg	1	\N	95
248	https://content2.rozetka.com.ua/goods/images/big/554933145.png	0	\N	96
249	https://content2.rozetka.com.ua/goods/images/big/554933160.webp	1	\N	96
250	https://content1.rozetka.com.ua/goods/images/big/519626223.png	0	\N	97
251	https://content2.rozetka.com.ua/goods/images/big/519626231.png	1	\N	97
252	https://content1.rozetka.com.ua/goods/images/big/519626237.png	2	\N	97
253	https://content.rozetka.com.ua/goods/images/big/519626240.jpg	3	\N	97
254	https://content1.rozetka.com.ua/goods/images/big/557612479.jpg	0	\N	98
255	https://content1.rozetka.com.ua/goods/images/big/557612481.jpg	1	\N	98
256	https://content.rozetka.com.ua/goods/images/big/553974061.png	0	\N	99
257	https://content.rozetka.com.ua/goods/images/big/553974065.png	1	\N	99
258	https://content.rozetka.com.ua/goods/images/big/553974068.png	2	\N	99
259	https://content2.rozetka.com.ua/goods/images/big/550658971.jpg	0	\N	100
260	https://content2.rozetka.com.ua/goods/images/big/281953507.jpg	0	\N	101
261	https://content1.rozetka.com.ua/goods/images/big/282230110.png	1	\N	101
262	https://content.rozetka.com.ua/goods/images/big/282230111.png	2	\N	101
263	https://content2.rozetka.com.ua/goods/images/big/282230112.jpg	3	\N	101
264	https://content1.rozetka.com.ua/goods/images/big/282230113.png	4	\N	101
266	https://content1.rozetka.com.ua/goods/images/big/35701715.jpg	1	\N	102
268	https://content2.rozetka.com.ua/goods/images/big/35701798.png	3	\N	102
270	https://content.rozetka.com.ua/goods/images/big/35698692.jpg	0	\N	103
271	https://content2.rozetka.com.ua/goods/images/big/35698703.jpg	1	\N	103
272	https://content2.rozetka.com.ua/goods/images/big/35698710.jpg	2	\N	103
273	https://content1.rozetka.com.ua/goods/images/big/35698716.png	3	\N	103
274	https://content2.rozetka.com.ua/goods/images/big/35698724.png	4	\N	103
275	https://content1.rozetka.com.ua/goods/images/big/449953320.jpg	0	\N	104
276	https://content.rozetka.com.ua/goods/images/big/449954118.jpg	0	\N	105
277	https://content.rozetka.com.ua/goods/images/big/380888332.jpg	0	\N	106
278	https://content2.rozetka.com.ua/goods/images/big/380888339.jpg	1	\N	106
279	https://content.rozetka.com.ua/goods/images/big/380888344.jpg	2	\N	106
280	https://content.rozetka.com.ua/goods/images/big/374548848.jpg	0	\N	107
281	https://content2.rozetka.com.ua/goods/images/big/374548862.jpg	1	\N	107
282	https://content1.rozetka.com.ua/goods/images/big/374548868.jpg	2	\N	107
283	https://content1.rozetka.com.ua/goods/images/big/550658875.jpg	0	\N	108
284	https://content1.rozetka.com.ua/goods/images/big/550658885.jpg	1	\N	108
285	https://content1.rozetka.com.ua/goods/images/big/550658891.jpg	2	\N	108
286	https://content1.rozetka.com.ua/goods/images/big/393773688.jpg	0	\N	109
287	https://content.rozetka.com.ua/goods/images/big/483527513.png	0	\N	110
288	https://content.rozetka.com.ua/goods/images/big/483527517.jpg	1	\N	110
289	https://content1.rozetka.com.ua/goods/images/big/483527521.png	2	\N	110
290	https://content1.rozetka.com.ua/goods/images/big/333625296.jpg	0	\N	111
291	https://content.rozetka.com.ua/goods/images/big/333625307.png	1	\N	111
292	https://content1.rozetka.com.ua/goods/images/big/333625326.png	2	\N	111
293	https://content2.rozetka.com.ua/goods/images/big/333625348.png	3	\N	111
294	https://content1.rozetka.com.ua/goods/images/big/333625375.png	4	\N	111
295	https://content2.rozetka.com.ua/goods/images/big/333625407.png	5	\N	111
296	https://content1.rozetka.com.ua/goods/images/big/333667890.jpg	0	\N	112
297	https://content.rozetka.com.ua/goods/images/big/333667891.png	1	\N	112
298	https://content.rozetka.com.ua/goods/images/big/333667892.png	2	\N	112
299	https://content1.rozetka.com.ua/goods/images/big/333667893.png	3	\N	112
300	https://content2.rozetka.com.ua/goods/images/big/333667894.png	4	\N	112
301	https://content2.rozetka.com.ua/goods/images/big/333667895.png	5	\N	112
302	https://content1.rozetka.com.ua/goods/images/big/176311612.jpg	0	\N	113
303	https://content1.rozetka.com.ua/goods/images/big/176311624.jpg	1	\N	113
304	https://content1.rozetka.com.ua/goods/images/big/176311637.jpg	2	\N	113
305	https://content2.rozetka.com.ua/goods/images/big/532982610.jpg	0	\N	114
306	https://content1.rozetka.com.ua/goods/images/big/532984339.jpg	1	\N	114
307	https://content.rozetka.com.ua/goods/images/big/532982611.jpg	2	\N	114
308	https://content1.rozetka.com.ua/goods/images/big/176310919.jpg	0	\N	115
309	https://content.rozetka.com.ua/goods/images/big/176310956.jpg	1	\N	115
310	https://content.rozetka.com.ua/goods/images/big/176310967.jpg	2	\N	115
311	https://content.rozetka.com.ua/goods/images/big/257956813.jpg	0	\N	116
312	https://content1.rozetka.com.ua/goods/images/big/257956828.jpg	1	\N	116
313	https://content.rozetka.com.ua/goods/images/big/257956990.jpg	2	\N	116
314	https://content2.rozetka.com.ua/goods/images/big/257957011.jpg	3	\N	116
315	https://content2.rozetka.com.ua/goods/images/big/257957065.jpg	4	\N	116
316	https://content.rozetka.com.ua/goods/images/big/257957081.jpg	5	\N	116
317	https://content2.rozetka.com.ua/goods/images/big/554702970.jpg	0	\N	117
318	https://content2.rozetka.com.ua/goods/images/big/496844764.jpg	0	\N	118
319	https://content.rozetka.com.ua/goods/images/big/496844765.jpg	1	\N	118
320	https://content.rozetka.com.ua/goods/images/big/496844766.jpg	2	\N	118
321	https://content.rozetka.com.ua/goods/images/big/496844767.jpg	3	\N	118
322	https://content1.rozetka.com.ua/goods/images/big/496844768.jpg	4	\N	118
323	https://content1.rozetka.com.ua/goods/images/big/496844769.png	5	\N	118
324	https://content.rozetka.com.ua/goods/images/big/446162444.jpg	0	\N	119
325	https://content2.rozetka.com.ua/goods/images/big/446162445.jpg	1	\N	119
326	https://content1.rozetka.com.ua/goods/images/big/446162446.jpg	2	\N	119
327	https://content2.rozetka.com.ua/goods/images/big/446162447.jpg	3	\N	119
328	https://content1.rozetka.com.ua/goods/images/big/446162448.jpg	4	\N	119
329	https://content1.rozetka.com.ua/goods/images/big/286014207.jpg	0	\N	120
330	https://content2.rozetka.com.ua/goods/images/big/460499478.jpg	0	\N	121
331	https://content1.rozetka.com.ua/goods/images/big/151054150.jpg	1	\N	121
332	https://content2.rozetka.com.ua/goods/images/big/151054120.jpg	2	\N	121
333	https://content1.rozetka.com.ua/goods/images/big/501953199.jpg	0	\N	122
334	https://content1.rozetka.com.ua/goods/images/big/501953200.jpg	1	\N	122
335	https://content.rozetka.com.ua/goods/images/big/466575644.jpg	0	\N	123
336	https://content1.rozetka.com.ua/goods/images/big/508373824.png	0	\N	124
337	https://content2.rozetka.com.ua/goods/images/big/283059588.jpg	1	\N	124
338	https://content.rozetka.com.ua/goods/images/big/283059620.jpg	2	\N	124
339	https://content2.rozetka.com.ua/goods/images/big/283059642.jpg	3	\N	124
340	https://content1.rozetka.com.ua/goods/images/big/283059664.jpg	4	\N	124
341	https://content.rozetka.com.ua/goods/images/big/283059680.jpg	5	\N	124
342	https://content2.rozetka.com.ua/goods/images/big/508373823.png	6	\N	124
343	https://content.rozetka.com.ua/goods/images/big/508373825.png	7	\N	124
344	https://content.rozetka.com.ua/goods/images/big/508373826.png	8	\N	124
345	https://content.rozetka.com.ua/goods/images/big/508373828.png	9	\N	124
346	https://content2.rozetka.com.ua/goods/images/big/508373829.png	10	\N	124
347	https://content.rozetka.com.ua/goods/images/big/508370268.png	0	\N	125
348	https://content.rozetka.com.ua/goods/images/big/283070863.jpg	1	\N	125
349	https://content1.rozetka.com.ua/goods/images/big/283070874.jpg	2	\N	125
350	https://content.rozetka.com.ua/goods/images/big/283070894.jpg	3	\N	125
351	https://content.rozetka.com.ua/goods/images/big/283070913.jpg	4	\N	125
352	https://content.rozetka.com.ua/goods/images/big/283070924.jpg	5	\N	125
353	https://content2.rozetka.com.ua/goods/images/big/508370244.png	6	\N	125
354	https://content2.rozetka.com.ua/goods/images/big/508370297.png	7	\N	125
355	https://content1.rozetka.com.ua/goods/images/big/508370322.png	8	\N	125
356	https://content.rozetka.com.ua/goods/images/big/508370353.png	9	\N	125
357	https://content.rozetka.com.ua/goods/images/big/400215261.jpg	0	\N	126
358	https://content.rozetka.com.ua/goods/images/big/409506208.png	1	\N	126
359	https://content1.rozetka.com.ua/goods/images/big/409506211.png	2	\N	126
360	https://content.rozetka.com.ua/goods/images/big/520786172.png	0	\N	127
361	https://content2.rozetka.com.ua/goods/images/big/520786173.png	1	\N	127
362	https://content.rozetka.com.ua/goods/images/big/520792835.png	2	\N	127
363	https://content1.rozetka.com.ua/goods/images/big/520792837.png	3	\N	127
364	https://content2.rozetka.com.ua/goods/images/big/520792839.png	4	\N	127
365	https://content2.rozetka.com.ua/goods/images/big/248720516.jpg	0	\N	128
366	https://content2.rozetka.com.ua/goods/images/big/11565049.jpg	1	\N	128
367	https://content.rozetka.com.ua/goods/images/big/508351957.jpg	2	\N	128
368	https://content1.rozetka.com.ua/goods/images/big/508351958.png	3	\N	128
369	https://content1.rozetka.com.ua/goods/images/big/521226239.png	0	\N	129
370	https://content.rozetka.com.ua/goods/images/big/447553474.jpg	0	\N	130
371	https://content1.rozetka.com.ua/goods/images/big/461171247.jpg	0	\N	131
372	https://content.rozetka.com.ua/goods/images/big/469720957.jpg	0	\N	132
373	https://content2.rozetka.com.ua/goods/images/big/469721427.jpg	0	\N	133
374	https://content2.rozetka.com.ua/goods/images/big/497270521.jpg	0	\N	134
375	https://content.rozetka.com.ua/goods/images/big/497270503.jpg	0	\N	135
376	https://content2.rozetka.com.ua/goods/images/big/556432951.jpg	0	\N	136
377	https://content1.rozetka.com.ua/goods/images/big/447000002.jpg	0	\N	137
378	https://content2.rozetka.com.ua/goods/images/big/280897793.jpg	0	\N	138
379	https://content2.rozetka.com.ua/goods/images/big/280897224.jpg	0	\N	139
\.


--
-- TOC entry 4397 (class 0 OID 116790)
-- Dependencies: 355
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, sku, name, brand, caffeine_type, sort, roast, description, is_special) FROM stdin;
72	5984482241	Instant coffee NESCAFE Gold 	Nescafé	Caffeine	Arabica/robusta blend	Medium	Nescafe Gold Instant Coffee is a carefully crafted blend of Arabica and Robusta beans, roasted to a smooth medium finish. It offers a well-balanced taste with gentle richness and a delicate aroma. A perfect choice for those who appreciate everyday coffee with a refined touch.	f
75	4895836773	Coffee in capsules Nescafe Dolce Gusto Latte Macchiato	Nescafé	Caffeine Medium	Arabica/robusta blend	Medium	Nescafe Dolce Gusto Latte Macchiato Capsules combine Arabica and Robusta beans, roasted to a smooth medium level. Each capsule delivers a layered coffee experience with rich espresso and creamy milk froth. Perfect for enjoying a café-style latte at home in seconds.	f
76	4238872552	Coffee in capsules Nescafe Dolce Gusto Lungo	Nescafé	Caffeine Medium	Arabica	Medium	Nescafe Dolce Gusto Lungo Capsules combine Arabica and Robusta beans, roasted to a smooth medium level. Each capsule delivers a layered coffee experience with rich espresso and creamy milk froth. Perfect for enjoying a café-style latte at home in seconds.	f
77	7623051480	Coffee in capsules Nescafe Dolce Gusto Flat White	Nescafé	Caffeine Medium	Arabica/robusta blend	Medium	Nescafe Dolce Gusto Flat White Capsules combine Arabica and Robusta beans, roasted to a smooth medium level. Each capsule delivers a layered coffee experience with rich espresso and creamy milk froth. Perfect for enjoying a café-style latte at home in seconds.	f
78	1312294993	Coffee in capsules Nescafe Dolce Gusto ICED Frappe	Nescafé	Caffeine	Arabica/robusta blend	Medium	Nescafe Dolce Gusto ICED Frappe Capsules combine Arabica and Robusta beans, roasted to a smooth medium level. Each capsule delivers a layered coffee experience with rich espresso and creamy milk froth. Perfect for enjoying a café-style latte at home in seconds.	f
79	4202019376	Instant coffee Nescafé Decaf Taster's Choice	Nescafé	Caffeine	Arabica	Light	Nescafe Dolce Gusto Latte Macchiato Capsules are made from light-roasted Arabica beans, blended with a touch of Robusta for a gentle, balanced flavor. Each capsule creates a layered coffee experience with smooth espresso and creamy milk froth. Ideal for a quick, café-style latte at home.	f
80	3140714443	Instant coffee Nescafe Cappuccino Hazelnut Soluble Coffee with hazelnut	Nescafé	Caffeine Medium	Arabica	Medium	Nescafe Cappuccino Hazelnut Instant Coffee is made from medium-roasted Arabica beans, infused with a delightful hazelnut flavor. It creates a creamy, smooth cappuccino with a sweet nutty aroma. Perfect for a quick, indulgent coffee treat anytime.	f
81	4134218848	Coffee in grains Lavazza Qualita Oro	Lavazza	Caffeine Medium	Arabica	Medium	Lavazza Qualità Oro Coffee Beans are made from 100% Arabica beans, roasted to a smooth medium level. They deliver a sweet, aromatic flavor with a delicate balance of body and aroma. Perfect for grinding fresh and enjoying a high-quality coffee at home.	f
82	9611599105	Ground coffee Lavazza Crema&Gusto	Lavazza	Caffeine	Arabica/robusta blend	Medium	Lavazza Crema & Gusto Ground Coffee is a balanced blend of Arabica and Robusta beans, roasted to a medium level. It delivers a full-bodied flavor with a rich crema and a harmonious aroma. Perfect for preparing a smooth and satisfying cup of coffee at home.	f
84	2083551001	Coffee in grains Lavazza Crema e Aroma	Lavazza	Caffeine	Arabica	Medium	Lavazza Crema e Aroma Coffee Beans are made from 100% Arabica beans, roasted to a smooth medium level. They offer a rich, velvety flavor with a delicate aroma and a satisfying crema. Perfect for grinding fresh and enjoying a high-quality coffee experience at home.	f
87	1631126172	Coffee in capsules Lavazza Espresso Maestro lungo	Lavazza	Caffeine Medium	Arabica	Medium	Lavazza Espresso Maestro Lungo Capsules are made from 100% Arabica beans, roasted to a smooth medium level. Each capsule delivers a rich, balanced espresso with a gentle aroma and a velvety crema. Perfect for enjoying a high-quality, café-style lungo at home.	f
88	3380783100	Ground coffee Lavazza Club	Lavazza	Caffeine	Arabica/robusta blend	Medium	Lavazza Club Ground Coffee is a balanced blend of Arabica and Robusta beans, roasted to a smooth medium level. It delivers a full-bodied flavor with a rich aroma and a velvety crema. Perfect for preparing a satisfying cup of coffee at home.	f
90	7920464543	Coffee in capsules Lavazza A Modo Mio Dek 	Lavazza	Decaffeinated	Arabica	Medium	Lavazza A Modo Mio Dek Capsules are made from 100% Arabica beans, roasted to a smooth medium level and decaffeinated for a gentle coffee experience. Each capsule delivers a mild, aromatic flavor with a velvety crema. Perfect for enjoying a high-quality decaf coffee anytime at home.	f
86	4425757403	Coffee in capsules Lavazza NCC ALU Espresso Qualita Oro	Lavazza	Caffeine Medium	Arabica	Medium	Lavazza NCC ALU Espresso Qualità Oro Capsules are made from 100% Arabica beans, roasted to a smooth medium level. Each capsule delivers a rich, aromatic espresso with a velvety crema. Perfect for enjoying a premium café-style espresso conveniently at home.	f
89	9029315536	Coffee in capsules Lavazza Crema e Gusto	Lavazza	Decaffeinated	Arabica/robusta blend	Dark	Lavazza Crema e Gusto Capsules are made from a blend of Arabica and Robusta beans, dark-roasted for a bold and intense flavor. Each capsule delivers a rich coffee with a full-bodied taste and a creamy crema. Perfect for enjoying a strong, café-style coffee at home.	f
74	8382412732	Instant coffee NESCAFE Classic 100% granular	Nescafé	Caffeine	Robusta	Medium	Nescafe Classic Instant Coffee is made from 100% Robusta beans, roasted to a medium level for a balanced taste. Its granular form dissolves quickly, delivering a strong and invigorating coffee experience. Perfect for a quick, everyday cup of rich coffee.	f
73	1744050939	Instant coffee Nescafe Gold freeze-dried stack	Nescafé	Caffeine	Arabica	Medium	Nescafe Gold Freeze-Dried Instant Coffee is made from high-quality Arabica beans, roasted to a smooth medium level. Its freeze-dried process preserves the rich aroma and full-bodied flavor of freshly brewed coffee. Enjoy a premium coffee experience in seconds, anytime you desire.	f
85	SKU_85_1770722365626	Coffee in grains Lavazza Tierra	Lavazza	Caffeine Medium	Arabica	Medium	Lavazza Tierra Coffee Beans are made from 100% Arabica beans, roasted to a smooth medium level. They deliver a balanced, aromatic flavor with a gentle sweetness and a clean finish. Perfect for grinding fresh and enjoying an eco-friendly, high-quality coffee at home.	f
95	3438430576	Coffee in capsules Nespresso Vertuo Odacio	Nespresso	Caffeine	Arabica	Medium	Nespresso Vertuo Odacio Capsules are made from 100% Arabica beans, roasted to a smooth medium level. Each capsule delivers a bold, aromatic coffee with vibrant fruity and cereal notes. Perfect for enjoying a high-quality, café-style coffee at home.	f
96	8595409040	Coffee in capsules Nespresso Pistachio Vanilla Over Ice	Nespresso	Caffeine	Arabica	Medium	Nespresso Pistachio Vanilla Over Ice Capsules are made from 100% Arabica beans, roasted to a smooth medium level. Each capsule delivers a bold, aromatic coffee with vibrant fruity and cereal notes. Perfect for enjoying a high-quality, café-style coffee at home.	f
97	4534695262	Coffee in capsules Nespresso Arpeggio Decaffeinato	Nespresso	Decaffeinated	Arabica	Dark	Nespresso Arpeggio Decaffeinato Capsules are made from 100% Arabica beans, dark-roasted for a rich and full-bodied flavor without caffeine. Each capsule delivers a creamy, intense coffee with deep roasted notes and a smooth aroma. Perfect for enjoying a bold decaf espresso at home.	f
98	4544344234	Coffee in capsules Nespresso Sweet Vanilla Decaffeinato	Nespresso	Decaffeinated	Arabica	Medium	Nespresso Sweet Vanilla Decaffeinato Capsules are made from medium-roasted Arabica beans, carefully decaffeinated and infused with a gentle vanilla flavor. Each capsule delivers a smooth, aromatic coffee with subtle sweetness. Perfect for enjoying a flavorful decaf coffee at home anytime.	f
99	3401864660	Coffee in capsules Nespresso Vertuo Sweet Vanilla Decaffeinato	Nespresso	Decaffeinated	Arabica	Medium	Nespresso Vertuo Sweet Vanilla Decaffeinato Capsules are made from medium-roasted Arabica beans, carefully decaffeinated and infused with a gentle vanilla flavor. Each capsule delivers a smooth, aromatic coffee with subtle sweetness. Perfect for enjoying a flavorful decaf coffee at home anytime.	f
100	9713797659	Coffee in capsules Nespresso Vertuo Ristretto Intenso	Nespresso	Decaffeinated	Arabica/robusta blend	Dark	Nespresso Vertuo Ristretto Intenso Capsules are made from a blend of Arabica and Robusta beans, dark-roasted for a powerful, full-bodied flavor. Each capsule delivers an intense espresso with rich crema and bold roasted notes. Perfect for enjoying a strong, café-style coffee at home.	f
101	6836596664	Coffee Starbucks Blonde Starbucks Roast	Starbucks	Caffeine	Arabica	Light	Starbucks Blonde Roast Coffee is made from lightly roasted 100% Arabica beans, offering a smooth and mellow flavor. It delivers subtle sweetness and a gentle, approachable aroma. Perfect for enjoying a soft, flavorful cup of coffee at home.	f
103	5661005752	Coffee Starbucks House Blend	Starbucks	Caffeine	Arabica	Medium	Starbucks House Blend Coffee is made from medium-roasted 100% Arabica beans, offering a balanced and smooth flavor. It delivers rich chocolatey notes with a subtle nutty aroma. Perfect for enjoying a classic, everyday coffee at home.	f
104	2070320609	Coffee in capsules Starbucks Smooth Caramel	Starbucks	Caffeine Medium	Arabica	Light	Starbucks Smooth Caramel Capsules are made from lightly roasted 100% Arabica beans, infused with a sweet caramel flavor. Each capsule delivers a smooth, aromatic coffee with a gentle, creamy finish. Perfect for enjoying a flavored, café-style coffee at home.	f
105	1028409419	Coffee in capsules Starbucks Creamy Vanilla	Starbucks	Caffeine Medium	Arabica	Light	Starbucks Creamy Vanilla Capsules are made from lightly roasted 100% Arabica beans, infused with a smooth vanilla flavor. Each capsule delivers a creamy, aromatic coffee with subtle sweetness. Perfect for enjoying a flavorful, café-style coffee at home.	f
106	9809245146	Instant coffee Starbucks Premium Instant Caramel Latte	Starbucks	Caffeine	Arabica	Medium	Starbucks Premium Instant Caramel Latte is made from medium-roasted Arabica beans, blended to create a smooth, rich coffee experience. Infused with a sweet caramel flavor, it delivers a creamy and aromatic latte in seconds. Perfect for enjoying a café-style treat anytime at home.	f
107	9137600189	Coffee Starbucks Premium Instant White Mocha	Starbucks	Caffeine Medium	Robusta	Medium	Starbucks Premium Instant White Mocha Coffee is made from medium-roasted Robusta beans, offering a rich and indulgent flavor. It delivers a smooth, chocolatey coffee experience with a hint of sweetness. Perfect for enjoying a café-style mocha quickly at home.	f
108	2312253136	Coffee in capsules Starbucks Nespresso Single-Origin Guatemala	Starbucks	Decaffeinated	Arabica	Light	Starbucks Nespresso Single-Origin Guatemala Capsules are made from lightly roasted 100% Arabica beans. Each capsule delivers a smooth, bright coffee with delicate fruity and floral notes. Perfect for enjoying a refined, single-origin coffee experience at home.	f
109	5570808568	Coffee in capsules Starbucks Holiday Blend Toffee Nut	Starbucks	Caffeine Medium	Arabica	Light	Starbucks Holiday Blend Toffee Nut Capsules are made from lightly roasted 100% Arabica beans. Each capsule delivers a smooth, bright coffee with delicate fruity and floral notes. Perfect for enjoying a refined, single-origin coffee experience at home.	f
110	6479113389	Coffee in capsules Starbucks by Nespresso Espresso Roast	Starbucks	Caffeine	Arabica	Dark	Starbucks by Nespresso Espresso Roast Capsules are made from dark-roasted 100% Arabica beans for a bold and intense flavor. Each capsule delivers a rich espresso with a deep roasted aroma and velvety crema. Perfect for enjoying a strong, café-style espresso at home.	f
93	SKU_93_1770725538679	Coffee in capsules Nespresso Arpeggio	Nespresso	Caffeine Medium	Arabica	Dark	Nespresso Arpeggio Capsules are made from 100% Arabica beans, dark-roasted for an intense and full-bodied flavor. Each capsule delivers a rich, creamy coffee with deep roasted notes and a strong aroma. Perfect for enjoying a bold, café-style espresso at home.	f
102	SKU_102_1770732907157	Coffee Starbucks Veranda Blend	Starbucks	Caffeine	Arabica	Light	Starbucks Veranda Blend Coffee is made from lightly roasted 100% Arabica beans, offering a smooth and mellow flavor. It delivers subtle notes of soft cocoa and toasted nuts with a gentle aroma. Perfect for a calm, everyday coffee experience at home.	f
111	1294017407	Ground coffee L'OR Espresso Chocolate 	L'OR	Caffeine	Arabica	Dark	L'OR Espresso Chocolate Ground Coffee is a rich blend designed to deliver a smooth and indulgent espresso experience. It combines deep roasted coffee notes with subtle chocolate undertones for a luxurious taste. Perfect for preparing a decadent coffee treat at home.	f
112	2666243505	Ground coffee L'OR Espresso Caramel	L'OR	Caffeine	Arabica	Medium	L'OR Espresso Caramel Ground Coffee is made from medium-roasted Arabica beans, infused with a smooth caramel flavor. It delivers a rich, aromatic coffee with sweet, indulgent notes. Perfect for enjoying a flavorful, café-style espresso at home.	f
113	3805272144	Ground coffee L'OR Classic 100% Arabica	L'OR	Caffeine	Arabica	Medium	L'OR Classic Ground Coffee is made from 100% Arabica beans, roasted to a smooth medium level. It delivers a well-balanced, aromatic coffee with gentle notes of chocolate and nuts. Perfect for enjoying a high-quality, everyday coffee at home.	f
114	3527505577	Coffee L’OR Espresso Barista Brazil	L'OR	Caffeine	Arabica	Medium	L’OR Espresso Barista Brazil Coffee is made from medium-roasted 100% Arabica beans, offering a smooth and balanced flavor. It delivers notes of mild chocolate and nutty undertones with a rich aroma. Perfect for crafting a high-quality espresso or coffee drink at home.	f
115	9861469519	Ground coffee L'OR Forza	L'OR	Caffeine	Arabica	Dark	L'OR Forza Ground Coffee is made from dark-roasted 100% Arabica beans, delivering a bold and intense flavor. It offers a full-bodied coffee experience with rich roasted notes and a velvety crema. Perfect for enjoying a strong, café-style espresso at home.	f
116	6328388928	Coffee in capsules L'OR Espresso Decaffeinato	L'OR	Decaffeinated	Arabica	Medium	L'OR Espresso Decaffeinato Capsules are made from medium-roasted 100% Arabica beans, carefully decaffeinated for a gentle coffee experience. Each capsule delivers a smooth, aromatic espresso with balanced flavor and a velvety crema. Perfect for enjoying a high-quality decaf espresso at home.	f
117	3184617760	Coffee in capsules Nespresso Lor Uganda Limited Creations 	L'OR	Decaffeinated	Arabica	Medium	Nespresso L’OR Uganda Limited Creations Capsules are made from medium-roasted 100% Arabica beans. Each capsule delivers a smooth, aromatic coffee with subtle fruity and floral notes. Perfect for enjoying a refined, single-origin coffee experience at home.	f
118	8094922345	Coffee in capsules L’OR Extra Long	L'OR	Caffeine	Arabica	Medium	L’OR Extra Long Capsules are made from medium-roasted 100% Arabica beans, offering a smooth and balanced flavor. Each capsule delivers a mild, aromatic coffee with a gentle crema, perfect for a longer coffee experience. Ideal for enjoying a high-quality, café-style coffee at home.	f
119	2951406829	Coffee in grains L'OR Crema Absolute Classic	L'OR	Caffeine	Arabica/robusta blend	Medium	L'OR Crema Absolute Classic Coffee Beans are made from a balanced blend of Arabica and Robusta beans, roasted to a medium level. They deliver a smooth, full-bodied flavor with a rich crema and subtle aromatic notes. Perfect for grinding fresh and enjoying a high-quality coffee at home.	f
120	1043382630	Coffee in capsules L'OR Lungo Elegante	L'OR	Caffeine Medium	Arabica/robusta blend	Medium	L'OR Lungo Elegante Capsules are made from a blend of medium-roasted Arabica and Robusta beans. Each capsule delivers a smooth, well-balanced coffee with subtle aromatic notes and a delicate crema. Perfect for enjoying a refined, café-style lungo at home.	f
121	7069061187	Instant coffee Jacobs Monarch	Jacobs	Caffeine	Arabica	Medium	Jacobs Monarch Instant Coffee is made from medium-roasted 100% Arabica beans. It delivers a smooth, rich coffee flavor with a gentle aroma, perfect for a quick and satisfying cup. Ideal for enjoying a high-quality coffee experience anytime at home.	f
122	2212747756	Instant coffee Jacobs Barista Editions Americano	Jacobs	Caffeine	Arabica	Medium	Jacobs Barista Editions Americano Instant Coffee is made from medium-roasted 100% Arabica beans. It delivers a smooth, aromatic coffee with a mild, well-balanced flavor, perfect for a classic Americano. Ideal for a quick and satisfying coffee experience at home.	f
123	5675505598	Coffee drink Jacobs Milka Cappuccino Choco Nuts	Jacobs	Caffeine	Robusta	Medium	Jacobs Milka Cappuccino Choco Nuts Coffee Drink is made from medium-roasted Robusta beans, blended with chocolate and nut flavors. It delivers a creamy, sweet, and indulgent cappuccino experience. Perfect for enjoying a dessert-style coffee treat at home.	f
124	3974972095	Coffee in capsules Jacobs Espresso 7 Classico	Jacobs	Caffeine Medium	Arabica/robusta blend	Light	Jacobs Espresso 7 Classico Capsules are made from a blend of lightly roasted Arabica and Robusta beans. Each capsule delivers a smooth, mild espresso with a delicate aroma and gentle crema. Perfect for enjoying a classic, café-style espresso at home.	f
125	4625131761	Coffee in capsules Jacobs Lungo 8 Intenso	Jacobs	Caffeine Medium	Arabica/robusta blend	Dark	Jacobs Lungo 8 Intenso Capsules are made from a blend of dark-roasted Arabica and Robusta beans. Each capsule delivers a bold, full-bodied coffee with rich roasted notes and a velvety crema. Perfect for enjoying an intense, café-style lungo at home.	f
126	8719594827	Instant coffee Jacobs Cronat Gold 	Jacobs	Caffeine Medium	Arabica/robusta blend	Light	Jacobs Cronat Gold Instant Coffee is made from a blend of lightly roasted Arabica and Robusta beans. It delivers a smooth, mild flavor with a gentle aroma, perfect for a quick and satisfying coffee experience. Ideal for enjoying a refined coffee anytime at home.	f
127	5099986866	Coffee drink Jacobs Irish Coffee	Jacobs	Caffeine	Arabica/robusta blend	Medium	Jacobs Irish Coffee Drink is made from a blend of medium-roasted Arabica and Robusta beans. It delivers a smooth, aromatic coffee with a subtle hint of Irish cream flavor. Perfect for enjoying a rich and indulgent coffee experience at home.	f
128	1148920155	Instant coffee Jacobs Monarch Decaffeinato	Jacobs	Decaffeinated	Arabica	Medium	Jacobs Monarch Decaffeinato Instant Coffee is made from medium-roasted 100% Arabica beans, carefully decaffeinated. It delivers a smooth, aromatic coffee with a mild, well-balanced flavor. Perfect for enjoying a high-quality decaf coffee anytime at home.	f
129	5647717446	Coffee in grains JACOBS Crema Intenso	Jacobs	Caffeine	Arabica/robusta blend	Medium	JACOBS Crema Intenso Coffee Beans are made from a blend of medium-roasted Arabica and Robusta beans. They deliver a full-bodied, aromatic coffee with a rich crema and balanced flavor. Perfect for grinding fresh and enjoying a high-quality espresso or coffee at home.	f
130	7478166017	Instant coffee Jacobs Cronat Kraftig	Jacobs	Caffeine	Arabica	Medium	Jacobs Cronat Kraftig Instant Coffee is made from medium-roasted 100% Arabica beans. It delivers a strong, aromatic coffee with a rich, full-bodied flavor. Perfect for a quick and satisfying coffee experience at home.	f
131	6106299979	Coffee in grains Blaser Dom Kofe UA Ballerina	Blasercafe	Caffeine Medium	Arabica	Medium	Blaser Dom Kofe UA Ballerina Coffee Beans are made from medium-roasted 100% Arabica beans. They deliver a smooth, balanced flavor with delicate floral and fruity notes. Perfect for grinding fresh and enjoying a refined, high-quality coffee at home.	f
132	8098857645	Coffee in grains Blasercafe Sera	Blasercafe	Decaffeinated	Arabica/robusta blend	Medium	Blasercafe Sera Coffee Beans are made from a blend of medium-roasted Arabica and Robusta beans. They deliver a smooth, balanced flavor with subtle roasted and nutty notes. Perfect for grinding fresh and enjoying a rich, high-quality coffee at home.	f
133	7610501130	Coffee in grains Blasercafe Rosso&Nero	Blasercafe	Caffeine Medium	Arabica/robusta blend	Medium	Blasercafe Rosso & Nero Coffee Beans are made from a blend of medium-roasted Arabica and Robusta beans. They deliver a rich, full-bodied coffee with balanced flavors and a smooth aroma. Perfect for grinding fresh and enjoying a high-quality espresso or coffee at home.	f
134	8535553238	Coffee in grains Blasercafe Cote d'azur	Blasercafe	Caffeine Medium	Arabica	Medium	Blasercafe Cote d'Azur Coffee Beans are made from medium-roasted 100% Arabica beans. They deliver a smooth, aromatic coffee with subtle fruity and floral notes. Perfect for grinding fresh and enjoying a refined, high-quality coffee at home.	f
135	8802840742	Coffee in grains Blasercafe Colombia Supremo	Blasercafe	Caffeine Medium	Arabica	Medium	Blasercafe Colombia Supremo Coffee Beans are made from medium-roasted 100% Arabica beans. They offer a smooth, aromatic coffee with notes of cocoa and mild fruitiness. 	f
136	8214201140	Coffee in grains Blasercafe Lilla e Rose	Blasercafe	Caffeine Medium	Arabica/robusta blend	Medium	Blasercafe Lilla e Rose Coffee Beans are made from a blend of medium-roasted Arabica and Robusta beans. They deliver a smooth, well-balanced coffee with subtle floral and fruity notes. Perfect for grinding fresh and enjoying a refined, high-quality coffee at home.	f
137	3754425763	Coffee in grains Blasercafe Orient	Blasercafe	Caffeine Medium	Arabica	Medium	Blasercafe Orient Coffee Beans are made from medium-roasted 100% Arabica beans. They deliver a smooth, well-balanced coffee with subtle spicy and floral notes. Perfect for grinding fresh and enjoying a high-quality, aromatic coffee at home.	f
138	2623754395	Coffee in grains Blasercafe Symphony	Blasercafe	Caffeine	Arabica/robusta blend	Medium	Blasercafe Symphony Coffee Beans are made from a blend of medium-roasted Arabica and Robusta beans. They deliver a balanced, aromatic coffee with a smooth body and rich flavor. Perfect for grinding fresh and enjoying a high-quality espresso or coffee at home.	f
139	9895383194	Coffee in grains Blasercafe Sera Decaffeinato	Blasercafe	Decaffeinated	Arabica/robusta blend	Medium	Blasercafe Sera Decaffeinato Coffee Beans are made from a blend of medium-roasted Arabica and Robusta beans, carefully decaffeinated. They deliver a smooth, balanced coffee with mild roasted notes and a gentle aroma. Perfect for enjoying a high-quality decaf coffee at home.	f
91	SKU_91_1770722502234	Coffee in capsules Nespresso Vaniglia	Nespresso	Caffeine	Arabica	Light	Nespresso Vaniglia Capsules are made from lightly roasted Arabica beans, infused with a delicate vanilla flavor. Each capsule delivers a smooth, aromatic coffee with a subtle sweetness. Perfect for enjoying a flavored café-style coffee at home.	f
71	SKU_71_1770732871211	Nescafe Espresso instant coffee powder	Nescafé	Caffeine	Arabica	Medium	Nescafe Espresso Instant Coffee Powder is crafted from premium Arabica beans, roasted to a perfect medium level. It delivers a rich espresso flavor with a smooth balance of intensity and aroma. Enjoy a quick, authentic coffee experience anytime, anywhere.	t
83	SKU_83_1770722227227	Ground coffee Lavazza DEK Classico	Lavazza	Decaffeinated	Arabica	Dark	Lavazza DEK Classico Ground Coffee is made from 100% Arabica beans, dark-roasted for a rich and full flavor without caffeine. It offers a smooth, intense taste with a deep aroma, perfect for coffee lovers seeking decaf. Enjoy a classic coffee experience any time of day.	f
140	SKU_140_1770731864755	Coffee in grains Blasercafe Pura Vida	Blasercafe	Caffeine	Arabica	Medium	Blasercafe Pura Vida Coffee Beans are made from medium-roasted 100% Arabica beans. They deliver a smooth, balanced flavor with gentle floral and fruity notes. Perfect for grinding fresh and enjoying a high-quality coffee experience at home.	t
94	SKU_94_1770733368168	Coffee in capsules Nespresso Chiaro	Nespresso	Caffeine Medium	Arabica	Light	Nespresso Chiaro Capsules are made from lightly roasted 100% Arabica beans for a smooth and delicate flavor. Each capsule delivers a mild, aromatic coffee with subtle sweetness and gentle floral notes. Perfect for enjoying a refined, café-style coffee at home.	f
15	SKU_15_1770743608870	Movenpick Caffe Crema	Movenpick	Caffeine Medium	Arabica/robusta blend	Dark	Description Movenpick Caffe Crema coffee beans 1 kg\nMovenpick Caffe Crema is a blend that includes a lot of advantages. Thanks to only selected Arabica beans in its composition, this drink has a magical golden foam that will definitely please true coffee lovers. Moreover, Caffe Crema is a universal blend: its rich taste is equally well revealed in strong and invigorating drinks such as espresso, as well as airy drinks with milk or cream. Intense aroma and soft delicious taste - what could be better than the perfect combination of such properties in one cup of coffee?	f
18	MOVENPICKCLASSIC_1770829302289	Movenpick Classic	Movenpick	\N	\N	\N	MOVENPICK Classic is a capsule coffee made from 100% Arabica beans. The Arabica beans are harvested from Rainforest Alliance-certified plantations in South America and East Africa. They are roasted to a medium roast to highlight the pleasant acidity of the Arabica and impart nutty flavors. The capsules are compatible with Nespresso coffee machines, allowing you to quickly and easily prepare your favorite coffee. The flavor intensity is 4/10.	t
16	SKU_16_1770742938305	Movenpick Der Himmlische	Movenpick	Caffeine Medium	Arabica/robusta blend	Dark	Heavenly - this is exactly how the name of this mixture is translated from German. Indeed, the level of quality of the drink can be compared to heaven. Movenpick Der Himmlische contains only the best Arabica beans. They were grown and harvested by hand in the best lands of India, Central and South America and Africa. The impeccable taste of coffee delights with its richness and richness. And thanks to the long roasting of the beans, the aroma of the drink has become intense and so pleasant that it is simply unreal to miss the chance to make at least one sip of such perfect coffee.	f
17	SKU_17_1770743266899	Movenpick El Autentico	Movenpick	\N	Arabica/robusta blend	Dark	MOVENPICK El Autentico is a delightful new product that's ready to amaze the world with its unique properties. It features select Arabica beans (90%) and Robusta beans (10%) from the fertile lands of South and Central America, further confirming the absolute quality of the product! Its superb, balanced, and smooth taste will surely satisfy even the most discerning palates! The medium roast imparts a unique aroma with incredible freshness and richness. This blend is ideal for preparing various types of coffee!	f
\.


--
-- TOC entry 4399 (class 0 OID 116800)
-- Dependencies: 357
-- Data for Name: product_flavor_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_flavor_profiles (id, product_id, flavorprofile_id) FROM stdin;
14	15	6
15	16	7
16	17	7
17	18	7
\.


--
-- TOC entry 4436 (class 0 OID 263299)
-- Dependencies: 394
-- Data for Name: products_accessory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_accessory (id, sku, name, brand, description, price, category, is_special, quantity) FROM stdin;
13	19449056527	Reusable Coffee Filter	BeanWorks	Lightweight and easy to clean	101.01	\N	f	49
14	14254716946	Coffee Grinder	CafeLux	Compact design with ergonomic handle	95.25	\N	f	5
15	50153604847	Reusable Coffee Filter	BrewMaster	Lightweight and easy to clean	40.23	\N	f	35
16	40474552996	Latte Art Pen	BrewMaster	Perfect for home and professional use	111.04	\N	f	25
17	60956516001	French Press	CaffeineCo	High-quality stainless steel construction	58.84	\N	f	4
18	81756118648	Espresso Tamper	BeanWorks	Lightweight and easy to clean	103.95	\N	f	11
19	79228359713	Milk Frother	CafeLux	Durable and dishwasher safe	130.97	\N	f	7
20	67625001447	Coffee Scale	BrewMaster	Durable and dishwasher safe	133.65	\N	f	36
21	84539000134	Coffee Grinder	BeanWorks	Compact design with ergonomic handle	114.07	\N	f	48
22	83400686659	Milk Frother	AromaPlus	Compact design with ergonomic handle	133.99	\N	f	24
23	94770896806	Coffee Scale	BeanWorks	High-quality stainless steel construction	86.58	\N	f	4
24	42495897351	Coffee Scoop	CafeLux	High-quality stainless steel construction	114.44	\N	f	1
\.


--
-- TOC entry 4403 (class 0 OID 116812)
-- Dependencies: 361
-- Data for Name: products_photo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_photo (id, photo, product_id, created_at, updated_at) FROM stdin;
70	image/upload/v1770732828/uja98wydpjgxnvfynvua.png	102	2026-02-10 14:13:48.449609+00	2026-02-10 14:13:48.449633+00
71	image/upload/v1770732829/lymahzwykvf7svubd4bo.png	102	2026-02-10 14:13:49.159873+00	2026-02-10 14:13:49.159891+00
74	image/upload/v1770733370/aywan4zqw2ljb7kva8vv.jpg	94	2026-02-10 14:22:50.025048+00	2026-02-10 14:22:50.025071+00
75	image/upload/v1770733371/r7anw1tgsl2hcmsslxlc.jpg	94	2026-02-10 14:22:51.47187+00	2026-02-10 14:22:51.471896+00
76	image/upload/v1770742941/vojngpcsrutqaaradjjv.jpg	16	2026-02-10 17:02:20.709615+00	2026-02-10 17:02:20.709634+00
77	image/upload/v1770742941/vlykazxypcvys2yveubs.jpg	16	2026-02-10 17:02:21.753703+00	2026-02-10 17:02:21.753764+00
78	image/upload/v1770743151/dg34s2bjfbwce10vkbgn.jpg	17	2026-02-10 17:05:50.872856+00	2026-02-10 17:05:50.872883+00
79	image/upload/v1770743151/pxd2vjizx6eocg7y1uka.jpg	17	2026-02-10 17:05:51.657634+00	2026-02-10 17:05:51.657656+00
47	image/upload/v1770722230/hq4myjgckzalo2ztjyhi.jpg	83	2026-02-10 11:17:10.142588+00	2026-02-10 11:17:10.142612+00
48	image/upload/v1770722231/t3stvewcuqjtaiqq9zma.jpg	83	2026-02-10 11:17:11.239117+00	2026-02-10 11:17:11.239143+00
49	image/upload/v1770722369/ai2ntsb5mzcvrgizlenj.jpg	85	2026-02-10 11:19:29.035452+00	2026-02-10 11:19:29.035475+00
50	image/upload/v1770722369/lqtcwlwzuacoe2exgnid.jpg	85	2026-02-10 11:19:29.501517+00	2026-02-10 11:19:29.501536+00
51	image/upload/v1770722508/o6s5mb41uzjeulej4i0i.jpg	91	2026-02-10 11:21:48.642238+00	2026-02-10 11:21:48.642264+00
52	image/upload/v1770722509/mtckpjedky49ud9ijde2.jpg	91	2026-02-10 11:21:49.129684+00	2026-02-10 11:21:49.129706+00
55	image/upload/v1770725464/tsedzta9pnunibj5l5pv.jpg	93	2026-02-10 12:11:03.597833+00	2026-02-10 12:11:03.597858+00
57	image/upload/v1770725542/xgg56euewxfsstxvhapg.jpg	93	2026-02-10 12:12:21.964632+00	2026-02-10 12:12:21.964656+00
60	image/upload/v1770731689/znx6noqixd0xesfbtyew.png	15	2026-02-10 13:54:47.986642+00	2026-02-10 13:54:47.986666+00
61	image/upload/v1770731691/oxtaf1ejiyjjfvg3047o.png	15	2026-02-10 13:54:51.280609+00	2026-02-10 13:54:51.280639+00
62	image/upload/v1770731867/iamlk4vetq5qovbebppu.png	140	2026-02-10 13:57:47.074594+00	2026-02-10 13:57:47.074619+00
63	image/upload/v1770731868/ry1t8shdlkpq2zifcaed.png	140	2026-02-10 13:57:48.177006+00	2026-02-10 13:57:48.177026+00
\.


--
-- TOC entry 4409 (class 0 OID 116898)
-- Dependencies: 367
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, grade, comment, created_at, updated_at, customer_id) FROM stdin;
\.


--
-- TOC entry 4412 (class 0 OID 116921)
-- Dependencies: 370
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, name, letter) FROM stdin;
\.


--
-- TOC entry 4414 (class 0 OID 116927)
-- Dependencies: 372
-- Data for Name: supplies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supplies (id, serving_type, price, weight, quantity, product_id) FROM stdin;
17	Ground	200.00	1.00	35	17
15	Ground	1999.00	1.00	35	15
16	Ground	200.00	1.00	35	16
244	Ground	200.00	1.00	35	72
245	Ground	200.00	1.00	35	74
363	Ground	200.00	1.00	35	109
364	Ground	200.00	1.00	35	110
365	Ground	200.00	1.00	35	116
242	Ground	120.00	1.00	35	71
18	Ground	25.00	500.00	15	18
307	Ground	200.00	1.00	35	96
308	Ground	200.00	1.00	35	96
309	Ground	200.00	1.00	35	97
310	Ground	200.00	1.00	35	97
311	Ground	200.00	1.00	35	97
312	Ground	200.00	1.00	35	98
313	Ground	200.00	1.00	35	98
314	Ground	200.00	1.00	35	98
315	Ground	200.00	1.00	35	100
316	Ground	200.00	1.00	35	100
317	Ground	200.00	1.00	35	100
318	Ground	200.00	1.00	35	140
319	Ground	200.00	1.00	35	140
320	Ground	200.00	1.00	35	140
321	Ground	200.00	1.00	35	139
322	Ground	200.00	1.00	35	139
323	Ground	200.00	1.00	35	139
324	Ground	200.00	1.00	35	138
325	Ground	200.00	1.00	35	138
326	Ground	200.00	1.00	35	138
328	Ground	200.00	1.00	35	137
408	Ground	200.00	1.00	35	122
409	Ground	200.00	1.00	35	121
411	Ground	200.00	1.00	35	121
412	Ground	200.00	1.00	35	122
413	Ground	200.00	1.00	35	123
417	Ground	200.00	1.00	35	114
418	Ground	200.00	1.00	35	106
420	Ground	200.00	1.00	35	107
421	Ground	200.00	1.00	35	106
422	Ground	200.00	1.00	35	106
423	Ground	200.00	1.00	35	107
427	Ground	200.00	1.00	35	103
428	Ground	200.00	1.00	35	102
430	Ground	200.00	1.00	35	101
431	Ground	200.00	1.00	35	102
432	Ground	200.00	1.00	35	103
434	Ground	200.00	1.00	35	73
435	Ground	200.00	1.00	35	73
436	Ground	200.00	1.00	35	99
437	Ground	200.00	1.00	35	99
438	Ground	200.00	1.00	35	99
439	Ground	200.00	1.00	35	99
419	Ground	200.00	1.00	35	107
406	Ground	200.00	1.00	35	123
377	Ground	200.00	1.00	35	120
424	Ground	200.00	1.00	35	101
241	Ground	100.00	1.00	35	71
426	Ground	200.00	1.00	35	103
433	Ground	200.00	1.00	35	73
425	Ground	200.00	1.00	35	102
404	Ground	200.00	1.00	35	121
329	Ground	200.00	1.00	35	137
330	Ground	200.00	1.00	35	137
331	Ground	200.00	1.00	35	136
332	Ground	200.00	1.00	35	136
333	Ground	200.00	1.00	35	136
334	Ground	200.00	1.00	35	135
335	Ground	200.00	1.00	35	135
336	Ground	200.00	1.00	35	135
337	Ground	200.00	1.00	35	134
338	Ground	200.00	1.00	35	134
340	Ground	200.00	1.00	35	134
341	Ground	200.00	1.00	35	133
342	Ground	200.00	1.00	35	133
343	Ground	200.00	1.00	35	133
344	Ground	200.00	1.00	35	132
345	Ground	200.00	1.00	35	132
346	Ground	200.00	1.00	35	132
347	Ground	200.00	1.00	35	131
348	Ground	200.00	1.00	35	131
349	Ground	200.00	1.00	35	131
350	Ground	200.00	1.00	35	129
351	Ground	200.00	1.00	35	129
352	Ground	200.00	1.00	35	129
353	Ground	200.00	1.00	35	119
354	Ground	200.00	1.00	35	119
355	Ground	200.00	1.00	35	104
243	Ground	200.00	1.00	35	72
366	Ground	200.00	1.00	35	117
367	Ground	200.00	1.00	35	118
368	Ground	200.00	1.00	35	118
369	Ground	200.00	1.00	35	117
356	Ground	200.00	1.00	35	104
370	Ground	200.00	1.00	35	116
371	Ground	200.00	1.00	35	124
269	Ground	200.00	1.00	35	83
372	Ground	200.00	1.00	35	125
373	Ground	200.00	1.00	35	125
374	Ground	200.00	1.00	35	124
375	Ground	200.00	1.00	35	124
376	Ground	200.00	1.00	35	125
378	Ground	200.00	1.00	35	120
379	Ground	200.00	1.00	35	120
380	Ground	200.00	1.00	35	113
381	Ground	200.00	1.00	35	112
357	Ground	200.00	1.00	35	105
246	Ground	200.00	1.00	35	74
247	Ground	200.00	1.00	35	75
248	Ground	200.00	1.00	35	75
249	Ground	200.00	1.00	35	75
358	Ground	200.00	1.00	35	108
250	Ground	200.00	1.00	35	76
251	Ground	200.00	1.00	35	76
252	Ground	200.00	1.00	35	77
253	Ground	200.00	1.00	35	77
254	Ground	200.00	1.00	35	77
255	Ground	200.00	1.00	35	78
256	Ground	200.00	1.00	35	78
257	Ground	200.00	1.00	35	78
258	Ground	200.00	1.00	35	79
259	Ground	200.00	1.00	35	79
260	Ground	200.00	1.00	35	79
261	Ground	200.00	1.00	35	80
262	Ground	200.00	1.00	35	80
263	Ground	200.00	1.00	35	80
264	Ground	200.00	1.00	35	81
265	Ground	200.00	1.00	35	81
266	Ground	200.00	1.00	35	81
267	Ground	200.00	1.00	35	82
268	Ground	200.00	1.00	35	82
359	Ground	200.00	1.00	35	108
360	Ground	200.00	1.00	35	109
361	Ground	200.00	1.00	35	110
362	Ground	200.00	1.00	35	109
270	Ground	200.00	1.00	35	83
271	Ground	200.00	1.00	35	84
272	Ground	200.00	1.00	35	84
273	Ground	200.00	1.00	35	85
274	Ground	200.00	1.00	35	85
275	Ground	200.00	1.00	35	85
276	Ground	200.00	1.00	35	86
277	Ground	200.00	1.00	35	86
278	Ground	200.00	1.00	35	86
279	Ground	200.00	1.00	35	87
280	Ground	200.00	1.00	35	87
281	Ground	200.00	1.00	35	87
283	Ground	200.00	1.00	35	88
284	Ground	200.00	1.00	35	88
285	Ground	200.00	1.00	35	88
286	Ground	200.00	1.00	35	89
287	Ground	200.00	1.00	35	89
288	Ground	200.00	1.00	35	89
289	Ground	200.00	1.00	35	90
290	Ground	200.00	1.00	35	90
291	Ground	200.00	1.00	35	91
292	Ground	200.00	1.00	35	91
293	Ground	200.00	1.00	35	91
297	Ground	200.00	1.00	35	93
298	Ground	200.00	1.00	35	93
299	Ground	200.00	1.00	35	93
300	Ground	200.00	1.00	35	94
301	Ground	200.00	1.00	35	94
302	Ground	200.00	1.00	35	94
303	Ground	200.00	1.00	35	95
304	Ground	200.00	1.00	35	95
305	Ground	200.00	1.00	35	95
306	Ground	200.00	1.00	35	96
382	Ground	200.00	1.00	35	111
383	Ground	200.00	1.00	35	111
384	Ground	200.00	1.00	35	112
385	Ground	200.00	1.00	35	113
386	Ground	200.00	1.00	35	113
387	Ground	200.00	1.00	35	112
388	Ground	200.00	1.00	35	111
389	Ground	200.00	1.00	35	115
390	Ground	200.00	1.00	35	115
391	Ground	200.00	1.00	35	115
393	Ground	200.00	1.00	35	128
394	Ground	200.00	1.00	35	128
395	Ground	200.00	1.00	35	130
396	Ground	200.00	1.00	35	130
397	Ground	200.00	1.00	35	128
398	Ground	200.00	1.00	35	126
399	Ground	200.00	1.00	35	127
400	Ground	200.00	1.00	35	127
401	Ground	200.00	1.00	35	126
402	Ground	200.00	1.00	35	126
403	Ground	200.00	1.00	35	127
405	Ground	200.00	1.00	35	122
407	Ground	200.00	1.00	35	123
392	Ground	200.00	1.00	35	130
416	Ground	200.00	1.00	35	114
\.


--
-- TOC entry 4416 (class 0 OID 116941)
-- Dependencies: 374
-- Data for Name: token_blacklist_blacklistedtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token_blacklist_blacklistedtoken (id, blacklisted_at, token_id) FROM stdin;
1	2025-09-23 23:21:13.410957+00	3
2	2025-12-05 14:50:17.462305+00	231
3	2025-12-29 19:33:47.075437+00	428
4	2025-12-29 19:37:08.143555+00	429
5	2025-12-29 19:48:08.925569+00	430
6	2025-12-29 20:09:10.727692+00	433
7	2025-12-29 20:27:04.501681+00	435
8	2025-12-29 20:58:20.617037+00	438
9	2025-12-29 20:59:16.160436+00	439
10	2025-12-29 21:11:13.627407+00	440
11	2025-12-29 21:44:16.944996+00	442
12	2025-12-29 21:49:22.791783+00	443
13	2026-01-02 11:00:22.611911+00	462
14	2026-01-02 16:56:07.282966+00	474
15	2026-01-03 17:49:25.441565+00	496
16	2026-01-04 10:02:56.22345+00	501
17	2026-01-04 20:32:16.048244+00	521
18	2026-01-04 20:33:04.836012+00	523
19	2026-01-04 20:33:42.998943+00	524
20	2026-01-04 20:56:47.672508+00	530
21	2026-01-04 20:57:56.851579+00	531
22	2026-01-04 20:58:27.635636+00	533
23	2026-01-05 10:29:07.935725+00	535
24	2026-01-05 10:31:58.412074+00	536
25	2026-01-05 10:39:23.105678+00	538
26	2026-01-05 19:01:52.872491+00	540
27	2026-01-05 20:06:17.56315+00	543
28	2026-01-05 20:09:57.624455+00	544
29	2026-01-05 22:13:15.409009+00	551
30	2026-01-06 11:53:07.429358+00	558
31	2026-01-07 10:37:10.413913+00	560
32	2026-01-07 10:38:55.759164+00	561
33	2026-01-07 11:30:03.303671+00	562
34	2026-01-07 11:30:53.349266+00	563
35	2026-01-07 13:28:24.688268+00	566
36	2026-01-07 14:16:41.733494+00	570
37	2026-01-07 14:46:56.249125+00	571
38	2026-01-07 15:23:31.982133+00	572
39	2026-01-07 15:47:08.744256+00	573
40	2026-01-07 16:42:25.542588+00	576
41	2026-01-07 17:14:21.982029+00	577
42	2026-01-07 17:44:47.387273+00	578
43	2026-01-09 14:05:06.7366+00	579
44	2026-01-09 14:36:48.533374+00	581
45	2026-01-09 15:07:23.198215+00	582
46	2026-01-11 11:28:13.778728+00	574
47	2026-01-11 11:28:16.85885+00	588
48	2026-01-11 11:44:59.350322+00	575
49	2026-01-11 11:45:02.177796+00	592
50	2026-01-11 11:48:33.778943+00	594
51	2026-01-11 11:49:03.065679+00	596
52	2026-01-29 08:36:26.481143+00	603
53	2026-01-29 09:53:29.704231+00	604
54	2026-01-29 15:07:01.625538+00	605
55	2026-01-29 16:02:33.795077+00	608
56	2026-01-29 16:07:04.048107+00	609
57	2026-02-02 12:07:01.120705+00	619
58	2026-02-02 15:21:52.64568+00	620
59	2026-02-02 15:28:46.762831+00	621
60	2026-02-03 15:06:07.51961+00	629
61	2026-02-03 16:42:16.131276+00	631
62	2026-02-03 16:42:22.103074+00	632
63	2026-02-03 16:43:40.14521+00	633
64	2026-02-03 17:15:02.226592+00	634
65	2026-02-03 17:25:50.143483+00	635
66	2026-02-04 10:30:00.937327+00	630
67	2026-02-04 14:55:38.785138+00	637
68	2026-02-04 15:12:32.963712+00	638
69	2026-02-04 15:55:50.354254+00	640
70	2026-02-04 16:13:28.782585+00	641
71	2026-02-04 16:27:24.229263+00	643
72	2026-02-05 10:39:45.513642+00	644
73	2026-02-05 11:22:28.27529+00	645
74	2026-02-05 11:22:29.422709+00	646
75	2026-02-05 12:36:04.799859+00	648
76	2026-02-05 13:34:52.927932+00	649
77	2026-02-05 14:09:42.274941+00	650
78	2026-02-05 15:03:36.670065+00	651
79	2026-02-05 15:33:46.304623+00	652
80	2026-02-06 06:55:10.649939+00	653
81	2026-02-06 10:50:21.468757+00	654
82	2026-02-08 14:53:36.180473+00	655
83	2026-02-08 15:26:39.748835+00	656
84	2026-02-08 16:02:25.765313+00	657
85	2026-02-08 16:33:01.372037+00	658
86	2026-02-08 17:04:20.596727+00	659
87	2026-02-09 07:55:28.06124+00	660
88	2026-02-09 09:21:16.011253+00	664
89	2026-02-09 10:37:35.460113+00	666
90	2026-02-09 11:26:23.337468+00	667
91	2026-02-09 12:35:35.252743+00	668
92	2026-02-09 13:07:39.161244+00	673
93	2026-02-09 14:12:00.893373+00	676
94	2026-02-09 14:47:43.351162+00	678
95	2026-02-09 15:18:04.683882+00	679
96	2026-02-09 16:03:52.236944+00	680
97	2026-02-09 16:34:49.951091+00	681
98	2026-02-09 17:05:07.83149+00	682
99	2026-02-09 17:35:34.188007+00	683
100	2026-02-10 08:24:33.459185+00	674
101	2026-02-10 08:59:59.325461+00	685
102	2026-02-10 09:35:14.586586+00	686
103	2026-02-10 10:19:19.20735+00	687
104	2026-02-10 10:50:56.573784+00	688
105	2026-02-10 11:21:46.149898+00	689
106	2026-02-10 12:09:36.863754+00	690
107	2026-02-10 13:04:04.371645+00	691
108	2026-02-10 13:34:27.762277+00	692
109	2026-02-10 14:06:37.629839+00	693
110	2026-02-10 14:36:41.920332+00	694
111	2026-02-10 15:01:34.483917+00	695
112	2026-02-10 15:34:56.059105+00	696
113	2026-02-10 15:35:04.623602+00	697
114	2026-02-10 15:36:08.078756+00	699
115	2026-02-10 16:25:13.542409+00	702
116	2026-02-10 16:25:51.783462+00	700
117	2026-02-10 16:25:52.477077+00	703
118	2026-02-10 16:56:34.376413+00	704
119	2026-02-10 17:28:44.433883+00	705
120	2026-02-10 20:51:41.540894+00	706
121	2026-02-11 06:51:44.602062+00	707
122	2026-02-11 16:56:35.025279+00	708
\.


--
-- TOC entry 4418 (class 0 OID 116947)
-- Dependencies: 376
-- Data for Name: token_blacklist_outstandingtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token_blacklist_outstandingtoken (id, token, created_at, expires_at, user_id, jti, jti_hex) FROM stdin;
1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODY2OTc0NywiaWF0IjoxNzU4NjY5NDQ3LCJqdGkiOiI5MGNlYzc5NGI2OTY0ZTBlYWJiMzQzYjBjYmUwODg3NyIsInVzZXJfaWQiOiI0In0.2EwswwiWa9rduetW2ZLFCmnh4QOJL7n_xApxSz5Qhf0	2025-09-23 23:17:27.178605+00	2025-09-23 23:22:27+00	4	90cec794b6964e0eabb343b0cbe08877	\N
2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODY2OTg4MywiaWF0IjoxNzU4NjY5NTgzLCJqdGkiOiJhOGFhMTNkZmM2MjE0NzRjODJmN2I5YjE4ODMyNTAyOSIsInVzZXJfaWQiOiI0In0.H1ONhkc9v-7NZRn0sPIR2sITr_k3yWj0RiqPgo1nBwk	2025-09-23 23:19:43.587911+00	2025-09-23 23:24:43+00	4	a8aa13dfc621474c82f7b9b188325029	\N
3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NTg2NzMxNDAsImlhdCI6MTc1ODY2OTYwMCwianRpIjoiZjIzYTI1MGY4YTg3NDY1ZWEwYjZmOTZlNzNlZmJhMWMiLCJ1c2VyX2lkIjoiNCJ9.8TCgPWOFFHEKMOM_WHlueRhh8BApTzSOBYfSLQQjZpc	2025-09-23 23:20:00.403304+00	2025-09-24 00:19:00+00	4	f23a250f8a87465ea0b6f96e73efba1c	\N
4	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODY3MTc0NCwiaWF0IjoxNzU4NjcxNDQ0LCJqdGkiOiIxYjQzZjAwMTBhNmU0OGQ1YjJkNmM0ZTE2NmQyMTI0MCIsInVzZXJfaWQiOiI3In0.JHhSMX0S6MEtXEWWER6cDmiXaNHQO06F2RAbTEz3bz8	2025-09-23 23:50:44.119869+00	2025-09-23 23:55:44+00	7	1b43f0010a6e48d5b2d6c4e166d21240	\N
5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4NzQwNTcyLCJpYXQiOjE3NTg3MzcwMzIsImp0aSI6IjFiYzMyOTdiZDVjYzQ3YWFiYjRjZGNkYmMxZWQ4NDNjIiwidXNlcl9pZCI6IjgifQ.QsxnXW9G2OqVWub00Zo8ur4zkWLjAJqlG4CAXIh0AWE	2025-09-24 18:03:52.90311+00	2025-09-24 19:02:52+00	8	1bc3297bd5cc47aabb4cdcdbc1ed843c	\N
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODc0MDU3MywiaWF0IjoxNzU4NzM3MDMzLCJqdGkiOiJmOTU0Zjc3NzcwMGQ0ZWZmOTBhZTc5MDEzMDM1MzBiOCIsInVzZXJfaWQiOiI4In0.pfF27660VMt3zPaOIrhO49x6LK68jRVFiU2L1w4goIg	2025-09-24 18:03:53.209688+00	2025-09-24 19:02:53+00	8	f954f777700d4eff90ae7901303530b8	\N
7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4NzQxNTM3LCJpYXQiOjE3NTg3Mzc5OTcsImp0aSI6ImU3YzhiMGY0Mzg1MTRjMjc5ZmZjOTNmY2FkOGI0YTQzIiwidXNlcl9pZCI6IjgifQ.UBYAnZdRKLme1PFzBc8EoVrASgqRxP5aI73Ku0rWphs	2025-09-24 18:19:57.252504+00	2025-09-24 19:18:57+00	8	e7c8b0f438514c279ffc93fcad8b4a43	\N
8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODc0MTUzNywiaWF0IjoxNzU4NzM3OTk3LCJqdGkiOiJlYTg3YzY5Y2ZjZWU0MjgwYWFlNzlmMTAwYTMwMjc0YiIsInVzZXJfaWQiOiI4In0.UdvhUXEw7mNbfP0YwJFGYb240y5a7_nQhw4lVna1NYY	2025-09-24 18:19:57.536175+00	2025-09-24 19:18:57+00	8	ea87c69cfcee4280aae79f100a30274b	\N
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODc2Mjg2MywiaWF0IjoxNzU4NzYyNTYzLCJqdGkiOiIxYjA1ODUzMzhkMWU0ZThiOWU2NWU1MjNmOTljMmJlMyIsInVzZXJfaWQiOiIxMCJ9.h0jq_jQYnK4r1EOv46dVgqQwW8D2t_XjW_WgOfs8evQ	2025-09-25 01:09:23.702364+00	2025-09-25 01:14:23+00	10	1b0585338d1e4e8b9e65e523f99c2be3	\N
10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODc2NDA5OCwiaWF0IjoxNzU4NzYzNzk4LCJqdGkiOiIxZjgyYmZjZTNkMTE0MmIzYjgxMzhlMDM2ZGIyMDRmZiIsInVzZXJfaWQiOiIxMCJ9.ha0ku0Rk1uRAbSPSHt-fZQwas9JblkEILLYD5kS3pTk	2025-09-25 01:29:58.703059+00	2025-09-25 01:34:58+00	10	1f82bfce3d1142b3b8138e036db204ff	\N
11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODc2NDEzOSwiaWF0IjoxNzU4NzYzODM5LCJqdGkiOiJkNTIwNWU1ZGVhOWE0MDRhOGUxNGE3ZmY2YzkzNDU1MSIsInVzZXJfaWQiOiIxMCJ9.xIDm5KYGrUgoMlnAiv2jv3AC6yQYcPiPUNAu77wWO1k	2025-09-25 01:30:39.804748+00	2025-09-25 01:35:39+00	10	d5205e5dea9a404a8e14a7ff6c934551	\N
12	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODc2NDY3NCwiaWF0IjoxNzU4NzY0Mzc0LCJqdGkiOiIwNmEwNWE5ZDAwOTM0ZjQ4YmI0OTg5NTNmNDI3YWQxMyIsInVzZXJfaWQiOiIxMCJ9.bj882odB2figNISeWCkl8NkKgRSEZhYrbguLHRszwUA	2025-09-25 01:39:34.815228+00	2025-09-25 01:44:34+00	10	06a05a9d00934f48bb498953f427ad13	\N
13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4Nzc5Nzk0LCJpYXQiOjE3NTg3NzYyNTQsImp0aSI6IjY0ZGQ4OWM0Mzg3ZTQyNThiOTZhOTkyZGM2NjYwYzYzIiwidXNlcl9pZCI6IjEwIn0.7OI-b50BNuPiTpG3b2XZ7fMyfuR79s1yw6ssOwJF4kQ	2025-09-25 04:57:34.180586+00	2025-09-25 05:56:34+00	10	64dd89c4387e4258b96a992dc6660c63	\N
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODc3OTc5NCwiaWF0IjoxNzU4Nzc2MjU0LCJqdGkiOiIwODI5YWY4NjkxMDY0NjI4YjgxNWVhNjgxZjFhZjA1NSIsInVzZXJfaWQiOiIxMCJ9.v_qmXq9pD_yk6CxLa7yHYpGERJmki8VIXOaigossgXU	2025-09-25 04:57:34.283661+00	2025-09-25 05:56:34+00	10	0829af8691064628b815ea681f1af055	\N
15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4NzgwMjQzLCJpYXQiOjE3NTg3NzY3MDMsImp0aSI6IjZkZjIwYjBlYjNmMTQ5MDU4NzIxZTcyNDE1ZDQxNzgzIiwidXNlcl9pZCI6IjEwIn0.hHn-Kpn6ZdGf4WJHrIUNpMaSIIem2QvAYGiZg2aXBcA	2025-09-25 05:05:03.389513+00	2025-09-25 06:04:03+00	10	6df20b0eb3f149058721e72415d41783	\N
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODc4MDI0MywiaWF0IjoxNzU4Nzc2NzAzLCJqdGkiOiJhNjBmYTQxNjlmMWM0Zjk1ODczZGNlZDMyNzUwMmU5NyIsInVzZXJfaWQiOiIxMCJ9.p-Uu-w9NRiiAd3AwpndARWGk8iaDxX39AcBNjMHZX4c	2025-09-25 05:05:03.423551+00	2025-09-25 06:04:03+00	10	a60fa4169f1c4f95873dced327502e97	\N
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4ODIwNjM0LCJpYXQiOjE3NTg4MTcwOTQsImp0aSI6ImYxYmU0ZTJiNjIyMjQ1Mzg4MDllMjcyZDJiYjMzNmJiIiwidXNlcl9pZCI6IjEwIn0.gSq0ZMH06KF07kSX0tS5CC7Ha7zltUES0cE0mPua85s	2025-09-25 16:18:14.601827+00	2025-09-25 17:17:14+00	10	f1be4e2b62224538809e272d2bb336bb	\N
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODgyMDYzNCwiaWF0IjoxNzU4ODE3MDk0LCJqdGkiOiIwZmRmODFhY2MzNmY0ZDdiYTUzMzNmZmVmN2Y4YTg0ZCIsInVzZXJfaWQiOiIxMCJ9.6RmBIn0hbH8KBSCQmVUZaBMitzS6hsFt39uo9Zp666o	2025-09-25 16:18:14.649679+00	2025-09-25 17:17:14+00	10	0fdf81acc36f4d7ba5333ffef7f8a84d	\N
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4ODIyNDI0LCJpYXQiOjE3NTg4MTg4ODQsImp0aSI6IjUxZTBmNGQwMDliMTRiNThiMjgyOGU2YWNmZmFmNmQzIiwidXNlcl9pZCI6IjEwIn0.PqItKj-SGwcnHCVteZVgtDABCmLhjiZ8W3WkDqPOvWk	2025-09-25 16:48:04.388724+00	2025-09-25 17:47:04+00	10	51e0f4d009b14b58b2828e6acffaf6d3	\N
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODgyMjQyNCwiaWF0IjoxNzU4ODE4ODg0LCJqdGkiOiI3MzVhODA4OGYzN2Q0ODRhOGM3YmZkNjMxOWMwNDllOCIsInVzZXJfaWQiOiIxMCJ9.7Xgp_w5r9sKYJvrGO0QdMwY2pF2i92vTyXjg1ERl5mU	2025-09-25 16:48:04.428826+00	2025-09-25 17:47:04+00	10	735a8088f37d484a8c7bfd6319c049e8	\N
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4ODIzMDM3LCJpYXQiOjE3NTg4MTk0OTcsImp0aSI6IjQ4ZGIxMzhmNGZkNzQzOTZiNmEwZDk0MWJlMWYxYzhiIiwidXNlcl9pZCI6IjEwIn0.QER0-Ndm5qWV6VtJSnbMfgnAndclo97riA1_RB64n_A	2025-09-25 16:58:17.40913+00	2025-09-25 17:57:17+00	10	48db138f4fd74396b6a0d941be1f1c8b	\N
22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODgyMzAzNywiaWF0IjoxNzU4ODE5NDk3LCJqdGkiOiI0ZmUzMWI2MTk0YmQ0ZjRiODdiZTc1Y2UwMjIyODM2NyIsInVzZXJfaWQiOiIxMCJ9.NFsihz_C8Mjj78d62zYZfTQnq0mDBU7hdKko-WILSZc	2025-09-25 16:58:17.44134+00	2025-09-25 17:57:17+00	10	4fe31b6194bd4f4b87be75ce02228367	\N
23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4ODIzNDAyLCJpYXQiOjE3NTg4MTk4NjIsImp0aSI6ImI3N2NlOGM0MzJkMDQxZWQ5ZWQ5Zjc4NTgzZDEzMTZjIiwidXNlcl9pZCI6IjEwIn0.7SV-9jML_COID7a-hAZMGGqFzhueAotslvDrQ2KlqlU	2025-09-25 17:04:22.290868+00	2025-09-25 18:03:22+00	10	b77ce8c432d041ed9ed9f78583d1316c	\N
24	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODgyMzQwMiwiaWF0IjoxNzU4ODE5ODYyLCJqdGkiOiI1MGY2YzhlOTg1Yjg0NjhiYmQ5ODA5NDA4Y2RhNGZkNSIsInVzZXJfaWQiOiIxMCJ9.nut1NzrBXajGQj7m4NrSIZZ2meGORE3LvBkRTbg2spk	2025-09-25 17:04:22.756126+00	2025-09-25 18:03:22+00	10	50f6c8e985b8468bbd9809408cda4fd5	\N
25	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4ODIzOTM5LCJpYXQiOjE3NTg4MjAzOTksImp0aSI6ImU1MWU3MDQ5MWMxNzQ2MGFhZTVjNzJjODYzOTMyYzg5IiwidXNlcl9pZCI6IjEwIn0.beHZvVOKGGVTkjn5iTKl0l5QhGKtccOjp4psrYvX2oM	2025-09-25 17:13:19.461196+00	2025-09-25 18:12:19+00	10	e51e70491c17460aae5c72c863932c89	\N
26	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODgyMzkzOSwiaWF0IjoxNzU4ODIwMzk5LCJqdGkiOiIxNDg2ZDZjMjU1MzQ0NmE4ODYwZjdlY2U0NThkMWU4NiIsInVzZXJfaWQiOiIxMCJ9.CY0ukc04G3Qn-opzlj7X8jJdTnm7H5Wi2yuApNiZVVI	2025-09-25 17:13:19.489517+00	2025-09-25 18:12:19+00	10	1486d6c2553446a8860f7ece458d1e86	\N
27	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4ODI0NzQzLCJpYXQiOjE3NTg4MjEyMDMsImp0aSI6IjM0MzI4ZTM1ZDdhNzQyNmRiNTMyZmU1ZDlmMWE5NDhjIiwidXNlcl9pZCI6IjEwIn0.ZJC3YpAWGCCVEk-sF9ZQ_OToljMvcXyLUu6DF5zqPg4	2025-09-25 17:26:43.39075+00	2025-09-25 18:25:43+00	10	34328e35d7a7426db532fe5d9f1a948c	\N
28	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODgyNDc0NCwiaWF0IjoxNzU4ODIxMjA0LCJqdGkiOiJlNzhiNzE1NGU2NmM0ZmRjYWI5MjNjYmVjMTYyYzUxMyIsInVzZXJfaWQiOiIxMCJ9.fO9EXEUfaWM8G40Z9m-MryePDDc0jlAZa7yfyH-aHes	2025-09-25 17:26:44.568875+00	2025-09-25 18:25:44+00	10	e78b7154e66c4fdcab923cbec162c513	\N
29	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4ODI1MTg3LCJpYXQiOjE3NTg4MjE2NDcsImp0aSI6IjVmOGI5ZDEyNjI2OTQ1MDhiZWJhMTI2Mjc5YWY0MjE5IiwidXNlcl9pZCI6IjEwIn0.PYHQhaRQOKoRCe1lTlxSwoBiqJo51TYnRXZXYLdkkhw	2025-09-25 17:34:07.722516+00	2025-09-25 18:33:07+00	10	5f8b9d1262694508beba126279af4219	\N
30	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODgyNTE4OCwiaWF0IjoxNzU4ODIxNjQ4LCJqdGkiOiJiM2ZiYjYxNmQ3ZTI0Mjk0ODE0NGRjY2VkZTc3MjMzMCIsInVzZXJfaWQiOiIxMCJ9.DGBW52802Er-cA33uc13iEsRNxMGBdAgFSOkLLiDOJo	2025-09-25 17:34:08.049486+00	2025-09-25 18:33:08+00	10	b3fbb616d7e242948144dccede772330	\N
31	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4ODI1MzY2LCJpYXQiOjE3NTg4MjE4MjYsImp0aSI6ImNlZDE3MzJlMjU5MjQwZTc5NGY1N2JkM2UwM2FkOWRlIiwidXNlcl9pZCI6IjEwIn0.d-Wr9VOAxeZ_w4ScF-T8QisY9kBqJQ6Is3yRCizUva8	2025-09-25 17:37:06.796853+00	2025-09-25 18:36:06+00	10	ced1732e259240e794f57bd3e03ad9de	\N
32	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODgyNTM2NiwiaWF0IjoxNzU4ODIxODI2LCJqdGkiOiI4NWIxNjViZWNmZjY0ZWIyOGFhYTIxNjE1NTdkNzFhZSIsInVzZXJfaWQiOiIxMCJ9.pTyF_Nf_p88J77O2UkMVT8lRTYlsvOav279werrfEHU	2025-09-25 17:37:06.822559+00	2025-09-25 18:36:06+00	10	85b165becff64eb28aaa2161557d71ae	\N
33	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4ODI3MjY5LCJpYXQiOjE3NTg4MjM3MjksImp0aSI6IjljOWZjYTQ4Y2ZlMzRiMzM5OWNiZjRkNjU3MjE3MzYxIiwidXNlcl9pZCI6IjEwIn0.fu27YisOfowNq0sPqWkGqFzHmOAHkPcvSSo8rwY4v5E	2025-09-25 18:08:49.669236+00	2025-09-25 19:07:49+00	10	9c9fca48cfe34b3399cbf4d657217361	\N
34	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODgyNzI2OSwiaWF0IjoxNzU4ODIzNzI5LCJqdGkiOiI2MTU4OWFlOGMwNDY0NzQ5OWYwNjI1ZGE3NDU2ODg0MiIsInVzZXJfaWQiOiIxMCJ9.bHoQO1kox1EqoppZi3PzKC5bZ7Pmo4hfxE9i5MnU_bo	2025-09-25 18:08:49.693332+00	2025-09-25 19:07:49+00	10	61589ae8c04647499f0625da74568842	\N
35	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4ODI3Mzc2LCJpYXQiOjE3NTg4MjM4MzYsImp0aSI6ImY2M2U4M2FjNGE1YTQ5NDE5MWRkNTQ0MGUyZTFlZmEzIiwidXNlcl9pZCI6IjEwIn0.FK6NG2pIWhW0qaPMzycgFvGKL3sEKdI6UeHJkt1IGwU	2025-09-25 18:10:36.866656+00	2025-09-25 19:09:36+00	10	f63e83ac4a5a494191dd5440e2e1efa3	\N
36	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODgyNzM3NiwiaWF0IjoxNzU4ODIzODM2LCJqdGkiOiIwZWY1Y2UzY2EwOGU0NGJiODE3M2M2YzRkYzRiOWZlYiIsInVzZXJfaWQiOiIxMCJ9.zxYQ8juHn7YN-M3vBP4xd2DyafmPNDnD1dpNEwmQulA	2025-09-25 18:10:36.973957+00	2025-09-25 19:09:36+00	10	0ef5ce3ca08e44bb8173c6c4dc4b9feb	\N
37	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU4ODI3NDQ5LCJpYXQiOjE3NTg4MjM5MDksImp0aSI6ImM2OTViZmZkODJkNjQzNTc5ZWY4NDBiOGE3ZWUwMzM1IiwidXNlcl9pZCI6IjEwIn0.bkJwb58eiVmUSpqz7GSpMI8uO1SsKTTkukijwrQX_mI	2025-09-25 18:11:49.280137+00	2025-09-25 19:10:49+00	10	c695bffd82d643579ef840b8a7ee0335	\N
38	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1ODgyNzQ0OSwiaWF0IjoxNzU4ODIzOTA5LCJqdGkiOiI0NmQ4YzU3NGUyNTk0NmJmOTQxNDQzOTZjOGMxNmIxMCIsInVzZXJfaWQiOiIxMCJ9.awdXus1ZiaD_sszqctHVUi5aeN0VdUHSLcSChOsRFis	2025-09-25 18:11:49.304597+00	2025-09-25 19:10:49+00	10	46d8c574e25946bf94144396c8c16b10	\N
39	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5MDgxODI2LCJpYXQiOjE3NTkwNzgyODYsImp0aSI6ImE4YzBmYmU2MTFkMTRhZWNhNTBiOWY0OGJiNmMwOWUxIiwidXNlcl9pZCI6IjgifQ.bpooxjARKO82Gt_W5dpNr7o6rlC00yY4MT_QqT0YOYA	2025-09-28 16:51:26.609244+00	2025-09-28 17:50:26+00	8	a8c0fbe611d14aeca50b9f48bb6c09e1	\N
40	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTA4MTgyNiwiaWF0IjoxNzU5MDc4Mjg2LCJqdGkiOiIyMDBkYjM1MzU1YTg0YmI3ODYyMDg2MmZmYTU4NGJhOSIsInVzZXJfaWQiOiI4In0.cFgyPgftB9jcynJ9RRdvVwRH0RC8MqO_--42El4WBbM	2025-09-28 16:51:26.929424+00	2025-09-28 17:50:26+00	8	200db35355a84bb78620862ffa584ba9	\N
41	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5MDgyMTc5LCJpYXQiOjE3NTkwNzg2MzksImp0aSI6ImI4NWQ2NjA3NzFiMzRjOWVhZDJjNTk5ZDE0ZGVmNTBkIiwidXNlcl9pZCI6IjgifQ.lSByG3RE-yUH8ESvo-vny5zPyAJzAHNCpS4CoCmpzwA	2025-09-28 16:57:19.186764+00	2025-09-28 17:56:19+00	8	b85d660771b34c9ead2c599d14def50d	\N
42	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTA4MjE3OSwiaWF0IjoxNzU5MDc4NjM5LCJqdGkiOiI5NGM3YjkxYThmNDQ0ZDVhYTQzMzFlZTc1ZDdkZjQxOCIsInVzZXJfaWQiOiI4In0.hlJzsC1qWTcOLkUOvqnei0VsGMEtv7uhu4xXJWP_90g	2025-09-28 16:57:19.390975+00	2025-09-28 17:56:19+00	8	94c7b91a8f444d5aa4331ee75d7df418	\N
43	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTA3OTcyOCwiaWF0IjoxNzU5MDc5NDI4LCJqdGkiOiI0M2M5YWE3NzgzMmY0YWUzODM4Mjc5YTNmNDQyYTgyMiIsInVzZXJfaWQiOiIxMSJ9.0i7cgTzxkgyBDlwpJwgbRCoEzV38XSqx_ENCczCFbhs	2025-09-28 17:10:28.527028+00	2025-09-28 17:15:28+00	11	43c9aa77832f4ae3838279a3f442a822	\N
44	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTA4MDEyMywiaWF0IjoxNzU5MDc5ODIzLCJqdGkiOiIxYzI4ZjI2MWE0NDM0ZTM4ODcwOWZhNTg5ZjY0ODI0ZCIsInVzZXJfaWQiOiIxIn0.whxh8xtkFgsFWRLuEd9u0NgtQ3EHMZGFBiMCeJUJ5eU	2025-09-28 17:17:03.245062+00	2025-09-28 17:22:03+00	1	1c28f261a4434e388709fa589f64824d	\N
45	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTI1MTUzNywiaWF0IjoxNzU5MjUxMjM3LCJqdGkiOiI1NWZjNDQxYTdhMGU0N2I5YWNmNzc1NTA3ZGUxYzg5MCIsInVzZXJfaWQiOiIxMiJ9.9dyG74c-ti48y1odU0t-pzUIUXwir8-tKVs7yhkKHAU	2025-09-30 16:53:57.907449+00	2025-09-30 16:58:57+00	12	55fc441a7a0e47b9acf775507de1c890	\N
46	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc0NTE0LCJpYXQiOjE3NTk2NzA5NzQsImp0aSI6ImMyYWYwNDdlOWRjNzRiNWQ5N2E3YTlmMjg2ODBkMmI1IiwidXNlcl9pZCI6IjEwIn0.zHxujKD_IqFrg5OnSfrTNItQmOEugC2UA1PWAY6U_Ro	2025-10-05 13:29:34.877342+00	2025-10-05 14:28:34+00	10	c2af047e9dc74b5d97a7a9f28680d2b5	\N
47	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NDUxNSwiaWF0IjoxNzU5NjcwOTc1LCJqdGkiOiI0OTYyMmI3NTA1Yzk0ZDAzOTkwZTNjYzViYTI1ZGNlMyIsInVzZXJfaWQiOiIxMCJ9.nLHEAVLZb1ayYIbmefH1kkXVOx-NRzy65wq2RiBaMCU	2025-10-05 13:29:35.020346+00	2025-10-05 14:28:35+00	10	49622b7505c94d03990e3cc5ba25dce3	\N
48	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc0OTkwLCJpYXQiOjE3NTk2NzE0NTAsImp0aSI6ImIwMDkzNDIwYWJkMDQ3Y2NiOTlhOTc5YTM5MDA1MGVhIiwidXNlcl9pZCI6IjEwIn0.FYAjkk6kaLEjm9KT6dpqEUcga7yD3wfMctsoZTKG8w0	2025-10-05 13:37:30.654405+00	2025-10-05 14:36:30+00	10	b0093420abd047ccb99a979a390050ea	\N
49	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NDk5MCwiaWF0IjoxNzU5NjcxNDUwLCJqdGkiOiJmMTNiYzE3ODNlZGM0MmQ2OWE4MGVhZWQ3MWEwOWU2NiIsInVzZXJfaWQiOiIxMCJ9.e_oZDQHmljxxK2Xs6BTCV1MeB8A9aYFToaa06X6m1QU	2025-10-05 13:37:30.681329+00	2025-10-05 14:36:30+00	10	f13bc1783edc42d69a80eaed71a09e66	\N
50	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1MTU2LCJpYXQiOjE3NTk2NzE2MTYsImp0aSI6IjQ1YjAwMTIwM2I2NzQwYWU5MjdkODY2YjQ5YWQwNWNhIiwidXNlcl9pZCI6IjEwIn0.-tyTytg0gWQS1sTKmD6nBzwfxT2V-Jnu_odx0Tteiys	2025-10-05 13:40:16.951353+00	2025-10-05 14:39:16+00	10	45b001203b6740ae927d866b49ad05ca	\N
51	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTE1NiwiaWF0IjoxNzU5NjcxNjE2LCJqdGkiOiJlYmY4YTA5N2Q2MWE0ZGU2ODdiMDkwNDdkYzdhZjNmNyIsInVzZXJfaWQiOiIxMCJ9.w1gO79N-YNU5Gwrev7n5SHN1vyc_3U0fcu5y2n3L004	2025-10-05 13:40:16.974837+00	2025-10-05 14:39:16+00	10	ebf8a097d61a4de687b09047dc7af3f7	\N
52	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1MjQzLCJpYXQiOjE3NTk2NzE3MDMsImp0aSI6IjAzNjgzMTMxOTI0MTRkOGJiNWJjZGRmMGYzZjAwY2ZkIiwidXNlcl9pZCI6IjEwIn0.afycneQ-YgplH7-QN4Nt8PEjQKeU8n_d-W9M42CpRGQ	2025-10-05 13:41:43.553304+00	2025-10-05 14:40:43+00	10	0368313192414d8bb5bcddf0f3f00cfd	\N
53	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTI0MywiaWF0IjoxNzU5NjcxNzAzLCJqdGkiOiIzN2VmZDhiZGE3Y2E0MmVjOWNjNzk0OGQ1MWQ4ZTYzOSIsInVzZXJfaWQiOiIxMCJ9.GWptxH13Xri2UdWFSQHZvVyimN-ziLdTXRfb9ngGgRE	2025-10-05 13:41:43.577367+00	2025-10-05 14:40:43+00	10	37efd8bda7ca42ec9cc7948d51d8e639	\N
54	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1MzA5LCJpYXQiOjE3NTk2NzE3NjksImp0aSI6IjIyODk1NTc2NjNiODRjZGNiYWY4ZmY3NmUxOWYxNWU0IiwidXNlcl9pZCI6IjEwIn0.0VVkIIN1hYrP7ENKhcBk-LlVg8_ECE_U916KIOQpZss	2025-10-05 13:42:49.536876+00	2025-10-05 14:41:49+00	10	2289557663b84cdcbaf8ff76e19f15e4	\N
55	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTMwOSwiaWF0IjoxNzU5NjcxNzY5LCJqdGkiOiJkNTYxMzc0MTI5Mzg0MWU1ODRiOWE1NzQ5NmRlYWNhYyIsInVzZXJfaWQiOiIxMCJ9.f8Jtvpsk0OHWO3RdulkAZ2zeaUcioyhxT3G0LvrNgV0	2025-10-05 13:42:49.559519+00	2025-10-05 14:41:49+00	10	d5613741293841e584b9a57496deacac	\N
56	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1MzU5LCJpYXQiOjE3NTk2NzE4MTksImp0aSI6ImIxYmExZGE5MGMwNDRhYjU5NzFkZDM2MTdkNjNjYjlhIiwidXNlcl9pZCI6IjEwIn0.g8HvnpRkXg-74cLUwywkcIKWn7cAz88Wq7iPbGKdzTA	2025-10-05 13:43:39.344717+00	2025-10-05 14:42:39+00	10	b1ba1da90c044ab5971dd3617d63cb9a	\N
57	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTM1OSwiaWF0IjoxNzU5NjcxODE5LCJqdGkiOiI0MWQ5OWRjMzdjMzA0NmIyODEwOTI5OTdmMDBkZGQ3MCIsInVzZXJfaWQiOiIxMCJ9.0xdq5b2lNNJWPKFvdoXllJWrhrUxx5qRGh3bmMCTSPA	2025-10-05 13:43:39.368422+00	2025-10-05 14:42:39+00	10	41d99dc37c3046b281092997f00ddd70	\N
58	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1MzcyLCJpYXQiOjE3NTk2NzE4MzIsImp0aSI6ImU0N2VhZDhhODllZDQ3MWJiYWYyNjkzOTBhYjcxMmU0IiwidXNlcl9pZCI6IjEwIn0.8vAvYHQUdXaicCIlXYzHXcBkyGgKka-q0sXko3e_jZ4	2025-10-05 13:43:52.140107+00	2025-10-05 14:42:52+00	10	e47ead8a89ed471bbaf269390ab712e4	\N
59	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTM3MiwiaWF0IjoxNzU5NjcxODMyLCJqdGkiOiIwMjIxYmE2ZDUyYmU0OTQ4OWQ1Yzg3MjgwYmM4ZDRlYyIsInVzZXJfaWQiOiIxMCJ9.d1CS0uuMDpOry4EdI35QFmkYiYvCCaRSlNzNGSkULtM	2025-10-05 13:43:52.163585+00	2025-10-05 14:42:52+00	10	0221ba6d52be49489d5c87280bc8d4ec	\N
60	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1NDAxLCJpYXQiOjE3NTk2NzE4NjEsImp0aSI6ImM5NWQyYmEyNzU5NjQwMjZhYTIxY2UzYzcxMDkzYmQyIiwidXNlcl9pZCI6IjEwIn0.GEmS4B_KCBcuyQPQaR17_VfyrnJB9A5aM_9mLsF1WlQ	2025-10-05 13:44:21.343924+00	2025-10-05 14:43:21+00	10	c95d2ba275964026aa21ce3c71093bd2	\N
61	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTQwMSwiaWF0IjoxNzU5NjcxODYxLCJqdGkiOiI4NDg3NTU3NjM1NGM0NzhiYTZiZDE4NDU5ODU0MGIyZCIsInVzZXJfaWQiOiIxMCJ9.C15-q3C6oOZpmrJClQsnX1FakJlG67D5H-HLFtRCf7U	2025-10-05 13:44:21.367155+00	2025-10-05 14:43:21+00	10	84875576354c478ba6bd184598540b2d	\N
62	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1NDQ1LCJpYXQiOjE3NTk2NzE5MDUsImp0aSI6ImMwYzYxZjIyMTg5ZDQ5ZTI5MzYzNzY1ZTgxZDBhOGNmIiwidXNlcl9pZCI6IjEwIn0.7VP6Dj0JV-Zw3ra-a7BPWgtLvHfyRJNuUHtaOMYsCyY	2025-10-05 13:45:05.263288+00	2025-10-05 14:44:05+00	10	c0c61f22189d49e29363765e81d0a8cf	\N
63	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTQ0NSwiaWF0IjoxNzU5NjcxOTA1LCJqdGkiOiI0M2M3OThjYWY2ZWY0MDhlOWJkNmU5ZjgwYzhjODcxZCIsInVzZXJfaWQiOiIxMCJ9.kgFHtAb8DO8dyITbYQN7RonoKiLjrfoUR4a-cFEJHe4	2025-10-05 13:45:05.288248+00	2025-10-05 14:44:05+00	10	43c798caf6ef408e9bd6e9f80c8c871d	\N
64	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1NDk5LCJpYXQiOjE3NTk2NzE5NTksImp0aSI6ImEzNjY4ZDIxY2QyZjQ0ZWQ4N2FkYWMyZTAxMzEwNjhmIiwidXNlcl9pZCI6IjEwIn0._m5P8_VRW5i_XhCL_EMwbs8gl8TZL6n7GGA1HPVPBR4	2025-10-05 13:45:59.17545+00	2025-10-05 14:44:59+00	10	a3668d21cd2f44ed87adac2e0131068f	\N
65	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTQ5OSwiaWF0IjoxNzU5NjcxOTU5LCJqdGkiOiJkMjQ5ZGZhMDE1NDg0MzRiODdlN2NlY2Y2Njg5M2E2NyIsInVzZXJfaWQiOiIxMCJ9.5kmx_7DNftn_kf8b3bVbxhcO5JQ40Q6gQoq1ZhxjPdQ	2025-10-05 13:45:59.198478+00	2025-10-05 14:44:59+00	10	d249dfa01548434b87e7cecf66893a67	\N
66	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1NTM3LCJpYXQiOjE3NTk2NzE5OTcsImp0aSI6ImMyMWYyNjdlMWIxNzQwMzFhMWFkYzM5Yjk0YjAxZDQyIiwidXNlcl9pZCI6IjEwIn0.MAAfieqiNTuRfboPf-UnANsgOaW3TE0f61No6I-ZWHc	2025-10-05 13:46:37.543767+00	2025-10-05 14:45:37+00	10	c21f267e1b174031a1adc39b94b01d42	\N
67	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTUzNywiaWF0IjoxNzU5NjcxOTk3LCJqdGkiOiJlNzk2ZjI5N2ZmYTY0OWE0YTQ2ZGUzNTY5OGIwNjU1YSIsInVzZXJfaWQiOiIxMCJ9.H1gBFLlXfrQtSu6WYFk-mnLn-9HJNQBstWw36sNcolQ	2025-10-05 13:46:37.566265+00	2025-10-05 14:45:37+00	10	e796f297ffa649a4a46de35698b0655a	\N
68	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1NTg0LCJpYXQiOjE3NTk2NzIwNDQsImp0aSI6Ijk4MzU2YWM1MTRkNDQzMmJiOTJiMDBjMjIyNjM1ZWU3IiwidXNlcl9pZCI6IjEwIn0.mqlBhbbZkW-xiAgwsqvGTORVBjUXhLWyeuZoigsVcd4	2025-10-05 13:47:24.561689+00	2025-10-05 14:46:24+00	10	98356ac514d4432bb92b00c222635ee7	\N
69	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTU4NCwiaWF0IjoxNzU5NjcyMDQ0LCJqdGkiOiIxOTU2MDQ0ODQyOWE0OThkOTAwYjRlMmEwNjk3Y2UxZCIsInVzZXJfaWQiOiIxMCJ9.n1WzCGA9gMg404QEl4IHOZ4kO80DRnYR_P2aX9H1Quk	2025-10-05 13:47:24.585039+00	2025-10-05 14:46:24+00	10	19560448429a498d900b4e2a0697ce1d	\N
70	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1NjM1LCJpYXQiOjE3NTk2NzIwOTUsImp0aSI6IjE0N2FlYmFhNGM2ZDQ1ZDJiOGFlNzBkZTc1YTY4ZTZiIiwidXNlcl9pZCI6IjEwIn0.ZH9I7HAODAL0PGO0oQR8bHGlwCT4OGLN1fY7-JGZ87c	2025-10-05 13:48:15.063717+00	2025-10-05 14:47:15+00	10	147aebaa4c6d45d2b8ae70de75a68e6b	\N
71	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTYzNSwiaWF0IjoxNzU5NjcyMDk1LCJqdGkiOiJlMjZkM2E0MjA3NWQ0ZTdhOWFmMDc5MTQwZmQ2ZmM2YSIsInVzZXJfaWQiOiIxMCJ9.SOR3PUSFyeNXTF0VIrzxRSZEmbYZe9QBzbr-5qc3hg0	2025-10-05 13:48:15.087716+00	2025-10-05 14:47:15+00	10	e26d3a42075d4e7a9af079140fd6fc6a	\N
72	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc1NjYxLCJpYXQiOjE3NTk2NzIxMjEsImp0aSI6ImYwOWEzOWI2YTA0ZjQxNmE5NmYzMDAxZDRlYzQ2NTg5IiwidXNlcl9pZCI6IjEwIn0.M8S8HDHABEQop6NHHv1JkhA45gIv5HDtTAAOF_0gf4o	2025-10-05 13:48:41.948463+00	2025-10-05 14:47:41+00	10	f09a39b6a04f416a96f3001d4ec46589	\N
73	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NTY2MSwiaWF0IjoxNzU5NjcyMTIxLCJqdGkiOiJkNTk2YTE5M2FlYTI0ODhjYjkwM2E3ZTI3YzEzYTFiOCIsInVzZXJfaWQiOiIxMCJ9.RP7HC6yD-CSHw59Ht9vyV0Syj-Ey5OCPvBRfHivNupA	2025-10-05 13:48:41.972794+00	2025-10-05 14:47:41+00	10	d596a193aea2488cb903a7e27c13a1b8	\N
74	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc2NTU4LCJpYXQiOjE3NTk2NzMwMTgsImp0aSI6ImQzN2RlMDYwNDQ1YTRiMDlhNTI2NTk0ODMyNGYzMDY0IiwidXNlcl9pZCI6IjEwIn0.5I6h4C2yaXkUIDIPaSNbQiw9fjfPE4hhy9-js_5-ot4	2025-10-05 14:03:38.848447+00	2025-10-05 15:02:38+00	10	d37de060445a4b09a5265948324f3064	\N
75	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NjU1OCwiaWF0IjoxNzU5NjczMDE4LCJqdGkiOiJhOWI4M2UyYzU2N2U0MTgyODM0N2VmZjUyNDZkNDY3ZiIsInVzZXJfaWQiOiIxMCJ9.WjI2TjHZ20U_oV_J118t2wRkzFrS0nP59DlER-3xX1w	2025-10-05 14:03:38.871483+00	2025-10-05 15:02:38+00	10	a9b83e2c567e41828347eff5246d467f	\N
76	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc3NDAyLCJpYXQiOjE3NTk2NzM4NjIsImp0aSI6IjI1YTEzMDk2ZTBlMTQ3YTRhZjBjN2FiNWI5N2IwNjZkIiwidXNlcl9pZCI6IjEwIn0.lMYMtTH6Iu52oCC02ceFZruH8-olxSWkYwgn9jSLuus	2025-10-05 14:17:42.281184+00	2025-10-05 15:16:42+00	10	25a13096e0e147a4af0c7ab5b97b066d	\N
77	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NzQwMiwiaWF0IjoxNzU5NjczODYyLCJqdGkiOiIyZDgxZmM1MDZjYWE0NTM2ODQ5MzFhYmVkZmE2YTBjMyIsInVzZXJfaWQiOiIxMCJ9.M_O5rBrrqNUe3fWCLXHzLOsPRgmkdUH7GIzcihaxrOg	2025-10-05 14:17:42.306331+00	2025-10-05 15:16:42+00	10	2d81fc506caa453684931abedfa6a0c3	\N
78	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc3NDIzLCJpYXQiOjE3NTk2NzM4ODMsImp0aSI6ImFlNTI5ZDQ0ZjRjMjQzODZhZjYwOGZmMjVmNmVmZGNiIiwidXNlcl9pZCI6IjEwIn0.Y15SsOyZe9UjsXRzk3DZhDmBAqJycNeFflC4b_zPvYI	2025-10-05 14:18:03.148346+00	2025-10-05 15:17:03+00	10	ae529d44f4c24386af608ff25f6efdcb	\N
79	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NzQyMywiaWF0IjoxNzU5NjczODgzLCJqdGkiOiI2N2I0YzhhODA3MTQ0MmFiOWMwNTVkNWEyN2YyN2E4MCIsInVzZXJfaWQiOiIxMCJ9.fZLNPPiF5wlMkrTGP1xXLIYvA7pZgknF5914oZsNkPE	2025-10-05 14:18:03.172737+00	2025-10-05 15:17:03+00	10	67b4c8a8071442ab9c055d5a27f27a80	\N
80	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc3OTI1LCJpYXQiOjE3NTk2NzQzODUsImp0aSI6ImEzN2EzZTY1YmNkNzRjYjViMWQ0MjI1Nzc1MjIwZDRkIiwidXNlcl9pZCI6IjEwIn0.cla_9Wvnak6uaNd0x5WdXPCt5EsWQuqx4rApJd39Yvs	2025-10-05 14:26:25.365711+00	2025-10-05 15:25:25+00	10	a37a3e65bcd74cb5b1d4225775220d4d	\N
81	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NzkyNSwiaWF0IjoxNzU5Njc0Mzg1LCJqdGkiOiI4NjcwZDQ0MGFjMTc0YTUyYjFiNTBjYmJhODQ0ZWRkYiIsInVzZXJfaWQiOiIxMCJ9.914BZk6hgN0YBszu1bTY3ag9JddB7yy86gVYch8x_gQ	2025-10-05 14:26:25.391517+00	2025-10-05 15:25:25+00	10	8670d440ac174a52b1b50cbba844eddb	\N
82	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc3OTM1LCJpYXQiOjE3NTk2NzQzOTUsImp0aSI6IjM5OGZjNmU3YjY1ODQ4MjY4ZTE3ZDJkZjYyNDdjYzA1IiwidXNlcl9pZCI6IjEwIn0.xn7c7lavtvQCOSI9JT-JcPpf7dRFAfYeroNZhrdmJ1c	2025-10-05 14:26:35.600393+00	2025-10-05 15:25:35+00	10	398fc6e7b65848268e17d2df6247cc05	\N
83	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3NzkzNSwiaWF0IjoxNzU5Njc0Mzk1LCJqdGkiOiJmOGQyYmVmOTM4ZTY0MjkwODg4NDFjYTYwNTliNzRjYSIsInVzZXJfaWQiOiIxMCJ9.7tcaV8VLxXwNdwnF28MiNjboUy55WlpRcbLP34QXtSI	2025-10-05 14:26:35.624606+00	2025-10-05 15:25:35+00	10	f8d2bef938e6429088841ca6059b74ca	\N
84	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc4MDU4LCJpYXQiOjE3NTk2NzQ1MTgsImp0aSI6IjU3MjAxOTA4YjI2YjRmYTA4YjZlMTUwMGY1NTFjZWQwIiwidXNlcl9pZCI6IjEwIn0.zCQgBTDsUYvpvMAHimeGDNha5T5eXS7o4f2fkjhOnA4	2025-10-05 14:28:38.385329+00	2025-10-05 15:27:38+00	10	57201908b26b4fa08b6e1500f551ced0	\N
85	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3ODA1OCwiaWF0IjoxNzU5Njc0NTE4LCJqdGkiOiIyNTQ2ZDE2MGY5ZjA0OGY5ODZjNGY5MTJmYzQ4OTJlZCIsInVzZXJfaWQiOiIxMCJ9.QGlt3Ow5pITUyNJiD2qC2eVOo-1RP7cyr07C9O2JTXs	2025-10-05 14:28:38.409644+00	2025-10-05 15:27:38+00	10	2546d160f9f048f986c4f912fc4892ed	\N
86	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc4MTg2LCJpYXQiOjE3NTk2NzQ2NDYsImp0aSI6IjRlZDMzNjhlYzYxMTQ3ODU4OWRhZjA2ZmNjMWUxYzllIiwidXNlcl9pZCI6IjEwIn0.GX303dzU9NjEB2-pNqFzxpl6fnfm0MCZXdYhrENvxWI	2025-10-05 14:30:46.048623+00	2025-10-05 15:29:46+00	10	4ed3368ec611478589daf06fcc1e1c9e	\N
87	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3ODE4NiwiaWF0IjoxNzU5Njc0NjQ2LCJqdGkiOiIyMzZiYmEyMDFkNGE0ZjJiYjI2OTliOTgyOTc1ZTQzNCIsInVzZXJfaWQiOiIxMCJ9.fYbI-2ENhZaT4x8o5-0pZcUd5kLuyUGz_oy9pVMO_t0	2025-10-05 14:30:46.072427+00	2025-10-05 15:29:46+00	10	236bba201d4a4f2bb2699b982975e434	\N
88	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc4MzE1LCJpYXQiOjE3NTk2NzQ3NzUsImp0aSI6ImVkMTAyNGZjNTU4ODRmNWNhMzczM2I2ODYyZWI1NTZjIiwidXNlcl9pZCI6IjEwIn0.ruzsY91wRLX8itgs56-8IdviktYeIuCrkWiiwCg0j4A	2025-10-05 14:32:55.274747+00	2025-10-05 15:31:55+00	10	ed1024fc55884f5ca3733b6862eb556c	\N
89	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3ODMxNSwiaWF0IjoxNzU5Njc0Nzc1LCJqdGkiOiJlZTJjMTg4NzQ5OTk0ZTcwYWEyMzc2ZDBiZmE4ZjE2MyIsInVzZXJfaWQiOiIxMCJ9.UHavYZf6TKMBU_TD-y39h4lWmtjhISJQPd1-LDYrx-Q	2025-10-05 14:32:55.298352+00	2025-10-05 15:31:55+00	10	ee2c188749994e70aa2376d0bfa8f163	\N
90	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc4NDUyLCJpYXQiOjE3NTk2NzQ5MTIsImp0aSI6ImNjYWQ5OTVkYmMyZjQ0OWE5MWJiNDkwYjg0ZGNhMjIxIiwidXNlcl9pZCI6IjEwIn0.EXZG2xYJWGk4cQFEJxfJu04SWc1zC6JE6EYqnVEkjJM	2025-10-05 14:35:12.061538+00	2025-10-05 15:34:12+00	10	ccad995dbc2f449a91bb490b84dca221	\N
91	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3ODQ1MiwiaWF0IjoxNzU5Njc0OTEyLCJqdGkiOiI3NDM4NDBkMTNjZWY0ODMyYWFkMjQzNmFlMjIxMmY1NCIsInVzZXJfaWQiOiIxMCJ9.6SDh_csvvYGfUpppCOwqwzdR-8Z4xjFdSY7K5IFhtJk	2025-10-05 14:35:12.085854+00	2025-10-05 15:34:12+00	10	743840d13cef4832aad2436ae2212f54	\N
92	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc5NDcwLCJpYXQiOjE3NTk2NzU5MzAsImp0aSI6IjFhODQ2NWI3ZDdlMTRlNDlhMDQ2NjViZjIwMWE5MTcxIiwidXNlcl9pZCI6IjEwIn0.eaQ1uHVx12CswJrK-E_TozR5-7in8wMHZtur8GSi7qk	2025-10-05 14:52:10.1492+00	2025-10-05 15:51:10+00	10	1a8465b7d7e14e49a04665bf201a9171	\N
93	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3OTQ3MCwiaWF0IjoxNzU5Njc1OTMwLCJqdGkiOiIwZDBkN2Y1MDg3NzU0MjM5OTJiNDU2MjUwNjg5YjBmMSIsInVzZXJfaWQiOiIxMCJ9.nV86YtaQCjDwyo91d-QBWLdvXIKSMU0L08FCF10LZYs	2025-10-05 14:52:10.172713+00	2025-10-05 15:51:10+00	10	0d0d7f508775423992b456250689b0f1	\N
94	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc5NTU1LCJpYXQiOjE3NTk2NzYwMTUsImp0aSI6IjgxOTUwZTBkNGU1ZjQ5M2FhNjE0ZWZlMTA3OWY1ZTg2IiwidXNlcl9pZCI6IjEwIn0.OMVWnsgIO88g8J4gtOKTI6uetK-9xpTytuRDDpC-3qs	2025-10-05 14:53:35.949167+00	2025-10-05 15:52:35+00	10	81950e0d4e5f493aa614efe1079f5e86	\N
95	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3OTU1NSwiaWF0IjoxNzU5Njc2MDE1LCJqdGkiOiI3YzZhYWUyZDY1Mjg0N2IzYTJhM2VjM2Q4MjQ5ODc0ZSIsInVzZXJfaWQiOiIxMCJ9.ov50fdzj6t9N_SiN3HR-INp0ysOokio4j9EJ3ta9nbs	2025-10-05 14:53:35.974288+00	2025-10-05 15:52:35+00	10	7c6aae2d652847b3a2a3ec3d8249874e	\N
96	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5Njc5ODg4LCJpYXQiOjE3NTk2NzYzNDgsImp0aSI6ImY5YmQ0NTU5NTI4YjRkYjc5ZGJmZmUzMDJmZDhiZjA5IiwidXNlcl9pZCI6IjEwIn0.eJyCjxvdAgjvzr_A-lH8andM28aNkVNnnmeSiLa34IQ	2025-10-05 14:59:08.116436+00	2025-10-05 15:58:08+00	10	f9bd4559528b4db79dbffe302fd8bf09	\N
97	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY3OTg4OCwiaWF0IjoxNzU5Njc2MzQ4LCJqdGkiOiI5YTc0ZTYwYzYxZTQ0OWM3YjljODlhZTczNjNkMTVlMSIsInVzZXJfaWQiOiIxMCJ9.9nDd7vj-HjSc8L9YsZ22COzCHem4meHYnjBNq4mEpeo	2025-10-05 14:59:08.144592+00	2025-10-05 15:58:08+00	10	9a74e60c61e449c7b9c89ae7363d15e1	\N
98	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5NjgwMDAwLCJpYXQiOjE3NTk2NzY0NjAsImp0aSI6IjJkZGZhMTlmMGI2ODRlNjk4ZmNmZjRlMjE0NzkwOTQ2IiwidXNlcl9pZCI6IjEwIn0.1z1GU2rpqA-D_kfFpbYdxJkMx3XrphmOixj1TO3DeRg	2025-10-05 15:01:00.646951+00	2025-10-05 16:00:00+00	10	2ddfa19f0b684e698fcff4e214790946	\N
99	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY4MDAwMCwiaWF0IjoxNzU5Njc2NDYwLCJqdGkiOiIyYWE0YzIxMmUyMDk0NTMxYmFiM2EzNTJmMGQxNDRkZSIsInVzZXJfaWQiOiIxMCJ9.o36H_swE5V3npAZEFkEMRVlgSW_5d2le2VtsfeInf0c	2025-10-05 15:01:00.673416+00	2025-10-05 16:00:00+00	10	2aa4c212e2094531bab3a352f0d144de	\N
100	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5NjgwMjg0LCJpYXQiOjE3NTk2NzY3NDQsImp0aSI6ImQ4MjhmNGU2ZTYwYjRmYWViOGY0YTYzNmFkODU4MGNlIiwidXNlcl9pZCI6IjEwIn0.ppc7qXbB2inUajTQv8QIzeNx1v1L5gUKL4GDiPME_gc	2025-10-05 15:05:44.754853+00	2025-10-05 16:04:44+00	10	d828f4e6e60b4faeb8f4a636ad8580ce	\N
101	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY4MDI4NCwiaWF0IjoxNzU5Njc2NzQ0LCJqdGkiOiI4ZmFhNTc2NjYxYjk0MmNlYjYzNGQ0MGY2YzIxZDQ4NCIsInVzZXJfaWQiOiIxMCJ9.t9B_w6xS3MHT9-TyDLC5FBkuH_4G0-pKlXgrAD0K310	2025-10-05 15:05:44.78066+00	2025-10-05 16:04:44+00	10	8faa576661b942ceb634d40f6c21d484	\N
102	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5NjgwNTU5LCJpYXQiOjE3NTk2NzcwMTksImp0aSI6ImUwYmJiZDkxYjFjZDRhYjQ5MzZiYjJkYjRkOTI2Yjk1IiwidXNlcl9pZCI6IjEwIn0.OWmgMzF4-AW8NY1Jlm3WGq2bPBgKuy9p8AU_MWUoHr0	2025-10-05 15:10:19.062642+00	2025-10-05 16:09:19+00	10	e0bbbd91b1cd4ab4936bb2db4d926b95	\N
103	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY4MDU1OSwiaWF0IjoxNzU5Njc3MDE5LCJqdGkiOiI1ODI4OWM0MTQ5Yzg0ZDkzOWNiOWZhZDE0NWVlMWRlNSIsInVzZXJfaWQiOiIxMCJ9._gqYueH-JnUEgXcpbTlZvkbua8l7jDrdux70GX4oN5c	2025-10-05 15:10:19.088335+00	2025-10-05 16:09:19+00	10	58289c4149c84d939cb9fad145ee1de5	\N
104	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5NjgxMTgxLCJpYXQiOjE3NTk2Nzc2NDEsImp0aSI6IjM1N2NiMjU1NTM2NzQ3ZGJiOGQ1YmRjYTkyY2FiYzU1IiwidXNlcl9pZCI6IjEwIn0.Z5KYXu-LTEFMN6XUGndutZUnzT_KhMc7-hkttuHopXA	2025-10-05 15:20:41.684462+00	2025-10-05 16:19:41+00	10	357cb255536747dbb8d5bdca92cabc55	\N
105	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY4MTE4MSwiaWF0IjoxNzU5Njc3NjQxLCJqdGkiOiIwYTFiY2QwMTExODQ0ZjQ5YTgyYzM2OTkwZWU5ZjJmYSIsInVzZXJfaWQiOiIxMCJ9.VuC4dYJAZQ9VuO8SNiir-EsLa1smp78thRHshFNVhOw	2025-10-05 15:20:41.711092+00	2025-10-05 16:19:41+00	10	0a1bcd0111844f49a82c36990ee9f2fa	\N
106	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5NjgxMzIzLCJpYXQiOjE3NTk2Nzc3ODMsImp0aSI6ImE0MjViZGI1ZDA3MjQ5ODlhMzRhN2RkMDY0ODBiMTI4IiwidXNlcl9pZCI6IjEwIn0.NLLUfhOF7JN5EjFWaeQZ8ytw5AVKJgpmQYEZop0ynVY	2025-10-05 15:23:03.44885+00	2025-10-05 16:22:03+00	10	a425bdb5d0724989a34a7dd06480b128	\N
107	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY4MTMyMywiaWF0IjoxNzU5Njc3NzgzLCJqdGkiOiJmZTdkZDRjZDllYzU0MjVhYWYxOWI2ZWNlYWMxMzgxMyIsInVzZXJfaWQiOiIxMCJ9.8YXnu5DZ0PAjOy_zGmUKL4PDyAMFeYcHKgKkOkMaZl4	2025-10-05 15:23:03.471906+00	2025-10-05 16:22:03+00	10	fe7dd4cd9ec5425aaf19b6eceac13813	\N
108	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5NjgxNjI4LCJpYXQiOjE3NTk2NzgwODgsImp0aSI6Ijc0NGYzMzNjN2NjYjQzMTRhYWQ1MzAyMTUzNjI0MzNmIiwidXNlcl9pZCI6IjEwIn0.IUoNMMNJL7Up9MepxJnrkAmZxt2r9oQPt_Slah6rJC8	2025-10-05 15:28:08.354657+00	2025-10-05 16:27:08+00	10	744f333c7ccb4314aad530215362433f	\N
109	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY4MTYyOCwiaWF0IjoxNzU5Njc4MDg4LCJqdGkiOiJkYWM2NTBlZDg4NGU0MDQxOGRiM2ZlMzU5MjVmNWY3MyIsInVzZXJfaWQiOiIxMCJ9.PiBD5wMjAotcB3fYRZMl_WfCNTvkNRB0JlEl7t3RPBE	2025-10-05 15:28:08.382522+00	2025-10-05 16:27:08+00	10	dac650ed884e40418db3fe35925f5f73	\N
110	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5NjgxNjY1LCJpYXQiOjE3NTk2NzgxMjUsImp0aSI6ImE0ZTYwYjk5YTg1MDQyMjU5ZWRhZGJkNDZlMDA5MWI2IiwidXNlcl9pZCI6IjEwIn0.oYVse9WyDLrP4Ys1k50IRcFXxFN5ms3InLDl1Y4RsnI	2025-10-05 15:28:45.672712+00	2025-10-05 16:27:45+00	10	a4e60b99a85042259edadbd46e0091b6	\N
111	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY4MTY2NSwiaWF0IjoxNzU5Njc4MTI1LCJqdGkiOiIxNGY1Njk3YmFlMmI0NTY2OTJiMzY4ZTA1YmY0ZjYwZiIsInVzZXJfaWQiOiIxMCJ9.52Q_vHTft-mWjgrf2DWvyyE9HS0GkD3p_UZKAlzM818	2025-10-05 15:28:45.695826+00	2025-10-05 16:27:45+00	10	14f5697bae2b456692b368e05bf4f60f	\N
112	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5NjgyMTUwLCJpYXQiOjE3NTk2Nzg2MTAsImp0aSI6IjcxMmNlOGY0NTkyYTRlYTdiYWRmMTg5Y2Y1OWM4NWI3IiwidXNlcl9pZCI6IjEwIn0.8PLAXIZUrSOghZho7t4ziYhn1jrCdH0FEPyIPTqqrYk	2025-10-05 15:36:50.400138+00	2025-10-05 16:35:50+00	10	712ce8f4592a4ea7badf189cf59c85b7	\N
113	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY4MjE1MCwiaWF0IjoxNzU5Njc4NjEwLCJqdGkiOiI4MTFhM2M0NjExOTg0ZDQwYTU5MGE1MmQ3MWFjZWIxYSIsInVzZXJfaWQiOiIxMCJ9.dV3T0jOStvF3_KloLyqoyM-wU3BGQ6XE5gwSpehooMI	2025-10-05 15:36:50.426829+00	2025-10-05 16:35:50+00	10	811a3c4611984d40a590a52d71aceb1a	\N
114	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5NjgyMjU0LCJpYXQiOjE3NTk2Nzg3MTQsImp0aSI6IjFkZjYyNzE4YWI2NzRjYzZiZGYxYTJkZmM5ZjgyYzdiIiwidXNlcl9pZCI6IjEwIn0.KprHMFDlmY2CyRFIPZfCglqvTyQLk72aS7NYp0NlZzM	2025-10-05 15:38:34.670166+00	2025-10-05 16:37:34+00	10	1df62718ab674cc6bdf1a2dfc9f82c7b	\N
115	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY4MjI1NCwiaWF0IjoxNzU5Njc4NzE0LCJqdGkiOiJkMTY5ZmExZGFiZjg0ZjU1YmY5NzEwNDE5NjZlZTA1ZiIsInVzZXJfaWQiOiIxMCJ9.fO-mXNQW9mdeZqyCjBS6L5eD76v20RpFS8QNtEQ0tf0	2025-10-05 15:38:34.694131+00	2025-10-05 16:37:34+00	10	d169fa1dabf84f55bf971041966ee05f	\N
116	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzU5NjgzMTQxLCJpYXQiOjE3NTk2Nzk2MDEsImp0aSI6IjYzNThkYWM3MTA3ZDRmZjZiNjA5ODJkZWJjMTBhY2FlIiwidXNlcl9pZCI6IjEwIn0.AcWYXPiiLOmLuLlapJYjWvvjvbTiIDjWsnOuO_nLKGw	2025-10-05 15:53:21.047326+00	2025-10-05 16:52:21+00	10	6358dac7107d4ff6b60982debc10acae	\N
117	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1OTY4MzE0MSwiaWF0IjoxNzU5Njc5NjAxLCJqdGkiOiJjZWU4OGFjODFlZDA0YzAzYjNlNTE0OGYxZTE5OWIxYyIsInVzZXJfaWQiOiIxMCJ9.HxtnB8c1XDSjxr_MRNA0gj7hY21UhJXVB70AaiMtL4k	2025-10-05 15:53:21.073427+00	2025-10-05 16:52:21+00	10	cee88ac81ed04c03b3e5148f1e199b1c	\N
118	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwMjcyMTE2LCJpYXQiOjE3NjAyNjg1NzYsImp0aSI6IjcyOWMxYjk1MGY0OTQxNzNhODlkNWU3Y2FlZGEwNjhkIiwidXNlcl9pZCI6IjEwIn0.QYSQ1KezC5yrvcAyVIIHLVx9G4NsMfoK45D-KFrlVAs	2025-10-12 11:29:36.96164+00	2025-10-12 12:28:36+00	10	729c1b950f494173a89d5e7caeda068d	\N
119	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDI3MjExNywiaWF0IjoxNzYwMjY4NTc3LCJqdGkiOiIyYmNiM2E1YjE4ZWY0MjJhYTY2ZmVkNjM2M2UwOWIxYiIsInVzZXJfaWQiOiIxMCJ9.V_N38XJIgySW_TzhIgY8tJn3281ILw1ADy6jK1RxpLE	2025-10-12 11:29:37.153081+00	2025-10-12 12:28:37+00	10	2bcb3a5b18ef422aa66fed6363e09b1b	\N
120	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwMjcyMjE4LCJpYXQiOjE3NjAyNjg2NzgsImp0aSI6ImY4MjY5N2NlMDIzYTQ4Y2RhNWNjZGE5YWIwOTkzNjA2IiwidXNlcl9pZCI6IjEwIn0.OrjOVgOff7nZmOdz-3bFw_RdBbASyRYIjPeMXuGqMW0	2025-10-12 11:31:18.755124+00	2025-10-12 12:30:18+00	10	f82697ce023a48cda5ccda9ab0993606	\N
121	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDI3MjIxOCwiaWF0IjoxNzYwMjY4Njc4LCJqdGkiOiI4NDllNGZmMDNhY2M0OTBhYmQ4MzAzMDNmNGIxMDc3ZiIsInVzZXJfaWQiOiIxMCJ9.JRFwtNwNunqkHVVV8Ej8twH6_OPsYPX4-SobFdIyYVQ	2025-10-12 11:31:18.778985+00	2025-10-12 12:30:18+00	10	849e4ff03acc490abd830303f4b1077f	\N
122	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwMjcyNDQ4LCJpYXQiOjE3NjAyNjg5MDgsImp0aSI6IjEzZjkwZTBlYmFkYzQzYjQ5NmZjZTJiNzQwNzc2YWVmIiwidXNlcl9pZCI6IjEwIn0.-JHk_VLQOUw2MQwSwTngGzn72jeVUBLrNlsuEOxm0wE	2025-10-12 11:35:08.241287+00	2025-10-12 12:34:08+00	10	13f90e0ebadc43b496fce2b740776aef	\N
123	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDI3MjQ0OCwiaWF0IjoxNzYwMjY4OTA4LCJqdGkiOiI1MGY5YmYzOTViMjQ0MTU5OTc1NGE2NTFhZmU4MzRjZSIsInVzZXJfaWQiOiIxMCJ9.YN3eDL2o8BAPQZttZEpkGf6vQWOzNrLLDug0eh2uprI	2025-10-12 11:35:08.271759+00	2025-10-12 12:34:08+00	10	50f9bf395b2441599754a651afe834ce	\N
124	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwMjcyNTcxLCJpYXQiOjE3NjAyNjkwMzEsImp0aSI6IjI4ZTUyNzkwMmExMjQxY2M4MzVmZjJmNWRkZWE5N2IyIiwidXNlcl9pZCI6IjEwIn0.7qsRbP5149w2m-IOGtpk2hL0wS1f_wpAnVtku7fBW4s	2025-10-12 11:37:11.545038+00	2025-10-12 12:36:11+00	10	28e527902a1241cc835ff2f5ddea97b2	\N
125	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDI3MjU3MSwiaWF0IjoxNzYwMjY5MDMxLCJqdGkiOiJmN2UxNTE2MzM4YTY0MTY4OTE0Zjc4NmUxZTA4N2IwNCIsInVzZXJfaWQiOiIxMCJ9.sZcxgyMPd_Dd03nltvpiseBXfrNgeF0yX455shWWCNc	2025-10-12 11:37:11.575685+00	2025-10-12 12:36:11+00	10	f7e1516338a64168914f786e1e087b04	\N
126	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwMjcyOTM5LCJpYXQiOjE3NjAyNjkzOTksImp0aSI6ImNlOTY2OTZmOTY4ZTRmZWNiYTUwZWVhZGM5NmRjMDNmIiwidXNlcl9pZCI6IjEwIn0.xa23v-haWkaUNMeHjLflFk_NeSDuVj34SK3LzSv9LWk	2025-10-12 11:43:19.643022+00	2025-10-12 12:42:19+00	10	ce96696f968e4fecba50eeadc96dc03f	\N
127	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDI3MjkzOSwiaWF0IjoxNzYwMjY5Mzk5LCJqdGkiOiI0MmQ5MzY3YWM1OTg0NWYyYWE1MGRiMTdhMDA4ZmI5OSIsInVzZXJfaWQiOiIxMCJ9.1hoKx5sCHAPCBGYWrpEbjqyfUWD_i_Wbs0BqmlSpxJc	2025-10-12 11:43:19.676708+00	2025-10-12 12:42:19+00	10	42d9367ac59845f2aa50db17a008fb99	\N
128	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwMjczNzQ0LCJpYXQiOjE3NjAyNzAyMDQsImp0aSI6IjliODU0MDM0ODVkYzRhOGU5YTI5YTBkZjRmODBjODk4IiwidXNlcl9pZCI6IjEwIn0.DBHMkGJhDv9N0J0F5WcBP0haBKdm9canmoJYKCbJYH8	2025-10-12 11:56:44.375937+00	2025-10-12 12:55:44+00	10	9b85403485dc4a8e9a29a0df4f80c898	\N
129	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDI3Mzc0NCwiaWF0IjoxNzYwMjcwMjA0LCJqdGkiOiI2YjgzY2M3MjE5YzI0MWU2ODgyZWYzMjZjY2MyYTBkNiIsInVzZXJfaWQiOiIxMCJ9.rTs7XvQEApYx1orN7mOKAlHFcinQ-btaBt7gCEGDEv4	2025-10-12 11:56:44.416011+00	2025-10-12 12:55:44+00	10	6b83cc7219c241e6882ef326ccc2a0d6	\N
130	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwMjczODAxLCJpYXQiOjE3NjAyNzAyNjEsImp0aSI6IjE2Zjc1NWU5OGE3NjRkOGZhOTU3NjZhNjA2MjljN2RiIiwidXNlcl9pZCI6IjEwIn0.HJI6aPRZtU63ZKyaSga2bH_xio5dpHgWD8FyG_4MKS0	2025-10-12 11:57:41.364076+00	2025-10-12 12:56:41+00	10	16f755e98a764d8fa95766a60629c7db	\N
131	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDI3MzgwMSwiaWF0IjoxNzYwMjcwMjYxLCJqdGkiOiI1YzIwMzdlOGMzNTk0YmJkODVkNTcwNWY2ZmQzOWM4MCIsInVzZXJfaWQiOiIxMCJ9.NsDIJtb0LguMgUUiQe8iRv86HluplPdr5YzuKw9L8G0	2025-10-12 11:57:41.390347+00	2025-10-12 12:56:41+00	10	5c2037e8c3594bbd85d5705f6fd39c80	\N
132	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDM2NjEwLCJpYXQiOjE3NjA0MzMwNzAsImp0aSI6IjBjMTJmOGY3ZDkwNjRkNDQ5OWRkM2U0ZDJjMjkwZmYzIiwidXNlcl9pZCI6IjEwIn0.91tai3AouZG6KlYR673XnXC262P5c-PSMVEVYpGnYxY	2025-10-14 09:11:10.508337+00	2025-10-14 10:10:10+00	10	0c12f8f7d9064d4499dd3e4d2c290ff3	\N
133	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQzNjYxMCwiaWF0IjoxNzYwNDMzMDcwLCJqdGkiOiJjMjgzZGQ2NTZmYTk0YTEyOGUxMmNmNTQyZWQ1NThhNCIsInVzZXJfaWQiOiIxMCJ9.-L5MTMWP-Li3bvZza3tITMzNywftgXD2hXMx-ABX5B8	2025-10-14 09:11:10.673609+00	2025-10-14 10:10:10+00	10	c283dd656fa94a128e12cf542ed558a4	\N
134	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDM2NjQzLCJpYXQiOjE3NjA0MzMxMDMsImp0aSI6ImZmZWQzMzRlYWVjMjQ1NmQ5ODJkMjQyZjVlODI0ZDk5IiwidXNlcl9pZCI6IjEwIn0.lvvhk0HrvdVB-mucI-6AkjTNn0_PTQ5gdJLmO91ka3c	2025-10-14 09:11:43.875755+00	2025-10-14 10:10:43+00	10	ffed334eaec2456d982d242f5e824d99	\N
135	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQzNjY0MywiaWF0IjoxNzYwNDMzMTAzLCJqdGkiOiI0NzUwZWNmMTMxYzQ0MWFmYWVjNTE0OTk3ZTdmZWZkYSIsInVzZXJfaWQiOiIxMCJ9.O7l9PNXV3W9Qyviz-LBwl0d8caS5iCaFdsyUJzvkTTA	2025-10-14 09:11:43.90108+00	2025-10-14 10:10:43+00	10	4750ecf131c441afaec514997e7fefda	\N
136	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQxMTY0LCJpYXQiOjE3NjA0Mzc2MjQsImp0aSI6ImQyNzViOTAxMTRlNzQ0MmU4YTE2MWJkMmM4M2MyNTllIiwidXNlcl9pZCI6IjEwIn0.H0wv81UA675gAYcfi7qHeeHR7ydelnfpsBfDmV1Xm-s	2025-10-14 10:27:04.294183+00	2025-10-14 11:26:04+00	10	d275b90114e7442e8a161bd2c83c259e	\N
137	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0MTE2NCwiaWF0IjoxNzYwNDM3NjI0LCJqdGkiOiIwNmQ3ODU2YTYyZWU0ODcyOTNjMDAxNWRmMzdmYjQ2YSIsInVzZXJfaWQiOiIxMCJ9.BIpg1wCL9R9Cusg-6P0jg-PM-3q1hEtooaO4vygWBLE	2025-10-14 10:27:04.473746+00	2025-10-14 11:26:04+00	10	06d7856a62ee487293c0015df37fb46a	\N
138	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQxMzE2LCJpYXQiOjE3NjA0Mzc3NzYsImp0aSI6ImQ1MGNhZTI5MjI2ZDQ2YjU5NmIyMzk3ZTQ2NDBlMGUyIiwidXNlcl9pZCI6IjEwIn0.o3REEMHBxy_VLmueir0GtyRUbHRyYDAcQ6EPSYpN5hs	2025-10-14 10:29:36.693902+00	2025-10-14 11:28:36+00	10	d50cae29226d46b596b2397e4640e0e2	\N
139	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0MTMxNiwiaWF0IjoxNzYwNDM3Nzc2LCJqdGkiOiIzOTQxZDUzZjY0M2M0YTY3ODEwMDc2ZmRiOWVlNzI0MiIsInVzZXJfaWQiOiIxMCJ9.7VL-V5vvCYA1pFs0L-VgDFgzhjyp5u228tSkVF4mzGg	2025-10-14 10:29:36.720041+00	2025-10-14 11:28:36+00	10	3941d53f643c4a67810076fdb9ee7242	\N
140	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQxNDA2LCJpYXQiOjE3NjA0Mzc4NjYsImp0aSI6ImZjNDkwYTg1MTgxZjQxZDc5MTBjMjUyODExODg4ZTM0IiwidXNlcl9pZCI6IjEwIn0.g0H9z-KWZlJFJ0zkBt_6xj8kPzXpq637SIh7d6qqL7Y	2025-10-14 10:31:06.791391+00	2025-10-14 11:30:06+00	10	fc490a85181f41d7910c252811888e34	\N
141	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0MTQwNiwiaWF0IjoxNzYwNDM3ODY2LCJqdGkiOiIxMDIxYjAwOTk2ZjE0YzExYTUyOWZlMWIxZDA0NWUwOCIsInVzZXJfaWQiOiIxMCJ9.5m9-y-XxD0DgiTm5swlxPUFz-EsW6HvyZU0P_4K-LkI	2025-10-14 10:31:06.815454+00	2025-10-14 11:30:06+00	10	1021b00996f14c11a529fe1b1d045e08	\N
142	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQxNjMxLCJpYXQiOjE3NjA0MzgwOTEsImp0aSI6IjZjZjQ3NDdmMTIzMDQxZDlhNTdhOTI5MTU4Y2FjNjhkIiwidXNlcl9pZCI6IjEwIn0.7QaY0S5_jyuOO-rfZuAr3LcIa6ABKeVWyTGSrh2g1TQ	2025-10-14 10:34:51.424116+00	2025-10-14 11:33:51+00	10	6cf4747f123041d9a57a929158cac68d	\N
143	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0MTYzMSwiaWF0IjoxNzYwNDM4MDkxLCJqdGkiOiI3ZTRiYzBlYTJiZGY0YjNjOGFlZDc1YzlmNTNiYzhjNiIsInVzZXJfaWQiOiIxMCJ9.s9t0ENDLih-V2fezBWeqTlAV1aw_U6s5SapBwcQMCmg	2025-10-14 10:34:51.459183+00	2025-10-14 11:33:51+00	10	7e4bc0ea2bdf4b3c8aed75c9f53bc8c6	\N
144	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQxNjQ4LCJpYXQiOjE3NjA0MzgxMDgsImp0aSI6ImZmNTdkMWY2NjBhNTQ4MjE4YTM2ZTRlYjNiYTk2YTg4IiwidXNlcl9pZCI6IjEwIn0.mOt_AYNcLIwM5K8pPR9P-HnHsXgOfEbG0ha7jNNn2hw	2025-10-14 10:35:08.689916+00	2025-10-14 11:34:08+00	10	ff57d1f660a548218a36e4eb3ba96a88	\N
145	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0MTY0OCwiaWF0IjoxNzYwNDM4MTA4LCJqdGkiOiJiM2ZjYWVmNmMwOWM0ODQzYjMyNTUxYjlhOTY5ODQ4NCIsInVzZXJfaWQiOiIxMCJ9.wN-o8SlZt94BQZv5jZ5HHfptRhXCcSZAWnam2ZR3JI4	2025-10-14 10:35:08.714192+00	2025-10-14 11:34:08+00	10	b3fcaef6c09c4843b32551b9a9698484	\N
146	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQxNzcwLCJpYXQiOjE3NjA0MzgyMzAsImp0aSI6IjhjMTU3MTcyNmUxYTRlNTVhYTNjZjQ4YTBiYmU2ZDM4IiwidXNlcl9pZCI6IjEwIn0.-RM4bNp7aH7l9dlPB4xwniF5HjEU9KVkSRgqWw7y_-Y	2025-10-14 10:37:10.485821+00	2025-10-14 11:36:10+00	10	8c1571726e1a4e55aa3cf48a0bbe6d38	\N
147	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0MTc3MCwiaWF0IjoxNzYwNDM4MjMwLCJqdGkiOiIwOTRmYjVjMDc4MDk0YjNlYjg3NTYyOWFiOTkzMGQ0ZCIsInVzZXJfaWQiOiIxMCJ9.LO-TkWDbyJO9kPITF6csMHVeeKwDe5Zwj4KdKgQHCiw	2025-10-14 10:37:10.510247+00	2025-10-14 11:36:10+00	10	094fb5c078094b3eb875629ab9930d4d	\N
148	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQxNzg3LCJpYXQiOjE3NjA0MzgyNDcsImp0aSI6ImJjMDI1ZTY2MDNhZTRlMDBhNGM4YTc1NmE3YWJiODQzIiwidXNlcl9pZCI6IjEwIn0.TppAVlbZkOIDloSCEgxllQYN1--SWlOdFpN2YHdgvBg	2025-10-14 10:37:27.288718+00	2025-10-14 11:36:27+00	10	bc025e6603ae4e00a4c8a756a7abb843	\N
149	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0MTc4NywiaWF0IjoxNzYwNDM4MjQ3LCJqdGkiOiJkOGY0NTQ2ZjljYWQ0Yzk3OWNjYjVlNDg5NzljM2Q0MSIsInVzZXJfaWQiOiIxMCJ9.mdYylQfxqeOG58YmmHDdzpkbUwH3v6isr7abgzrahqc	2025-10-14 10:37:27.313659+00	2025-10-14 11:36:27+00	10	d8f4546f9cad4c979ccb5e48979c3d41	\N
150	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDI3OTYsImlhdCI6MTc2MDQzOTI1NiwianRpIjoiODJjYmM3NTg1NjAxNGExYTliYTc2OTk4MjUwNDlkODMiLCJ1c2VyX2lkIjoiMTAifQ.-MJ-_YwkIsXhyl7UVnKNAGioQOgia_W95ToOqPiN7ac	2025-10-14 10:54:16.955755+00	2025-10-14 11:53:16+00	10	82cbc75856014a1a9ba7699825049d83	\N
151	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDI5NjYsImlhdCI6MTc2MDQzOTQyNiwianRpIjoiMDFiNWYwNTZiMTExNDdiYWI3MzM2ZjllMGU1OGY4ZjQiLCJ1c2VyX2lkIjoiMTAifQ.je85u3ZFDwomKSVMpWDt86ZCdk-NZWCd1-5ctSFkIiY	2025-10-14 10:57:06.500831+00	2025-10-14 11:56:06+00	10	01b5f056b11147bab7336f9e0e58f8f4	\N
152	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDMxNTcsImlhdCI6MTc2MDQzOTYxNywianRpIjoiMzJmM2FkY2MzZWY5NGFjOWFiOWM5NTViZGM2MjM3ZDIiLCJ1c2VyX2lkIjoiMTAifQ.RUeYh8N4rhCg75BN60CbsJdDbxhtrRVVWbw5G35ufU8	2025-10-14 11:00:17.827327+00	2025-10-14 11:59:17+00	10	32f3adcc3ef94ac9ab9c955bdc6237d2	\N
153	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQzMzM4LCJpYXQiOjE3NjA0Mzk3OTgsImp0aSI6IjkwNTBhNDk1MTA1ODRjYjVhNGI5MDFkODk3YjllYTk2IiwidXNlcl9pZCI6IjEwIn0.OKVjkZJ0UBjFz1-KXEfGBumCKjASzu1bzSwtwwfaH9E	2025-10-14 11:03:18.882227+00	2025-10-14 12:02:18+00	10	9050a49510584cb5a4b901d897b9ea96	\N
154	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0MzMzOCwiaWF0IjoxNzYwNDM5Nzk4LCJqdGkiOiJiN2RlNzZjYmU1ZmI0ZTVjOTdkMTIzNTQ4YzVkN2Y4MCIsInVzZXJfaWQiOiIxMCJ9.DScDXcNPgNyBkVtaUQuesYhOFjXNdb7QvsmgBJ1O-ew	2025-10-14 11:03:18.910149+00	2025-10-14 12:02:18+00	10	b7de76cbe5fb4e5c97d123548c5d7f80	\N
155	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDMzNjgsImlhdCI6MTc2MDQzOTgyOCwianRpIjoiNDQ0MDRmMjJmNWFiNDI3ZDg5Mjk1NWJjNWEwOGVlZjMiLCJ1c2VyX2lkIjoiMTAifQ.xrcfHwTLXWxZAWFelFFJzr5F1cJoEVy3tGqtdfbpVP4	2025-10-14 11:03:48.068279+00	2025-10-14 12:02:48+00	10	44404f22f5ab427d892955bc5a08eef3	\N
156	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDM1NDksImlhdCI6MTc2MDQ0MDAwOSwianRpIjoiNzMwMmEyNmQ4NTY0NDM4ZDkyZjRjOTcxY2JkZWVkN2UiLCJ1c2VyX2lkIjoiMTAifQ.v1uvfepMH52mfJqA7g91m8ieK3jUXANiphWrDZSFZgg	2025-10-14 11:06:49.645085+00	2025-10-14 12:05:49+00	10	7302a26d8564438d92f4c971cbdeed7e	\N
157	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDM3MzQsImlhdCI6MTc2MDQ0MDE5NCwianRpIjoiYTJmZTJkYjUzNGQ0NDNjNTgxYjE4ODA2OGUzMjdkZGUiLCJ1c2VyX2lkIjoiMTAifQ.zcNwjWwVG_ZaoMvsBxZm3HkSlIfLVN5bSLftSD-PQPM	2025-10-14 11:09:54.925143+00	2025-10-14 12:08:54+00	10	a2fe2db534d443c581b188068e327dde	\N
158	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDM4MDQsImlhdCI6MTc2MDQ0MDI2NCwianRpIjoiZDVmNGIyMmI0N2NkNDE5OGE4NTUzMWFmMDk1MTVjMGEiLCJ1c2VyX2lkIjoiMTAifQ.O6CFlIwubwgbMQGccChCzj8hLfIDnu6B3yQyQK35aRU	2025-10-14 11:11:04.192841+00	2025-10-14 12:10:04+00	10	d5f4b22b47cd4198a85531af09515c0a	\N
159	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDM5MjcsImlhdCI6MTc2MDQ0MDM4NywianRpIjoiZmZhMzI5NWFmZGUxNGY3ZDk3MzIxZjk4MDM5OGFlNTAiLCJ1c2VyX2lkIjoiMTAifQ.bjkkbMFBZp_8kkajo7kOUd5KWlzQh3YE7UWUZdRTebg	2025-10-14 11:13:07.717787+00	2025-10-14 12:12:07+00	10	ffa3295afde14f7d97321f980398ae50	\N
160	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQ0MzM4LCJpYXQiOjE3NjA0NDA3OTgsImp0aSI6IjM2OTdmMGEzZGM3ZjQ4YTA4ZTY5OWFkMjI5ZGVmOGJhIiwidXNlcl9pZCI6IjEwIn0.QleKmtpQPntPyBVpFQUTW3JTF8Ur7ycPtqt-tnb2nEs	2025-10-14 11:19:58.693971+00	2025-10-14 12:18:58+00	10	3697f0a3dc7f48a08e699ad229def8ba	\N
161	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0NDMzOCwiaWF0IjoxNzYwNDQwNzk4LCJqdGkiOiI3Y2U1MTc5MjUzNzg0NjVjYTIzYWQyYTNjNjg0ZTVjYyIsInVzZXJfaWQiOiIxMCJ9.PEuiTISRh761LxpFZYYG9sG7eR9luIM2IsocmGFDdUo	2025-10-14 11:19:58.721568+00	2025-10-14 12:18:58+00	10	7ce517925378465ca23ad2a3c684e5cc	\N
162	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDQzNTAsImlhdCI6MTc2MDQ0MDgxMCwianRpIjoiOGY4NzVkMTAwNWE5NDY3Zjk2MGU0YTJhYTg2ZDlhOWUiLCJ1c2VyX2lkIjoiMTAifQ.KTAB_j56TDjEW2zdzpxp-8S1gQsK9FzSPfmnMthid2U	2025-10-14 11:20:10.72672+00	2025-10-14 12:19:10+00	10	8f875d1005a9467f960e4a2aa86d9a9e	\N
163	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDQ1MjAsImlhdCI6MTc2MDQ0MDk4MCwianRpIjoiNjdhMmQ2NjVjMjRjNDNiOThkOGE0OTQ4YzM1ZjI1MGQiLCJ1c2VyX2lkIjoiMTAifQ.pxeweyYL0v2pBBxpfQeZ33OJaj6Kp185_03i5FKhsyw	2025-10-14 11:23:00.2298+00	2025-10-14 12:22:00+00	10	67a2d665c24c43b98d8a4948c35f250d	\N
164	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDQ3OTYsImlhdCI6MTc2MDQ0MTI1NiwianRpIjoiYjE0MTZhMjkxMjFmNGRlYjk3MjUxYWNiN2ZlNzlkYzUiLCJ1c2VyX2lkIjoiMTAifQ.UYi18egvM72Kh4U5BYx1YBsqlGr07iN4ZbwSsCFbpTo	2025-10-14 11:27:36.521699+00	2025-10-14 12:26:36+00	10	b1416a29121f4deb97251acb7fe79dc5	\N
165	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDQ4MjUsImlhdCI6MTc2MDQ0MTI4NSwianRpIjoiYTRmYTc1MjZiN2Y0NDE1Zjg3ZDJkYTk0NmNiMmUzMTUiLCJ1c2VyX2lkIjoiMTAifQ.ZFAEa_E3QTnGlvAsjCg1RHtFxBe27Hv2DE5_7BrHJYs	2025-10-14 11:28:05.6117+00	2025-10-14 12:27:05+00	10	a4fa7526b7f4415f87d2da946cb2e315	\N
166	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDUwMTMsImlhdCI6MTc2MDQ0MTQ3MywianRpIjoiM2MwMzdjYzVmMmJiNGFmZjk5YmU0NWYwYjMyMmRhYzMiLCJ1c2VyX2lkIjoiMTAifQ.nMM4xuaX1KBl2Pny_wFx_Ip_7iMmIff6IRpqaPFM4_c	2025-10-14 11:31:13.374095+00	2025-10-14 12:30:13+00	10	3c037cc5f2bb4aff99be45f0b322dac3	\N
167	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQ1MDg0LCJpYXQiOjE3NjA0NDE1NDQsImp0aSI6ImFjNWQ0NTUxODU2YzRlOWZiYWE3Yjc5MmQ2Nzc4YTIxIiwidXNlcl9pZCI6IjEwIn0.S_VvR-_js8qSImU0HVb-FTlsiJoTQENzLAikHrL0hpA	2025-10-14 11:32:24.817914+00	2025-10-14 12:31:24+00	10	ac5d4551856c4e9fbaa7b792d6778a21	\N
168	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0NTA4NCwiaWF0IjoxNzYwNDQxNTQ0LCJqdGkiOiI3NDUwYTYwNjk0NzA0MjYxYjgzNTYxOGQzYzFlODNlMSIsInVzZXJfaWQiOiIxMCJ9.LLxPhzUO6SIJCLMA-PVjWAZd-PoJi-i8xc79WSfGy1Q	2025-10-14 11:32:24.866037+00	2025-10-14 12:31:24+00	10	7450a60694704261b835618d3c1e83e1	\N
169	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDUyNDgsImlhdCI6MTc2MDQ0MTcwOCwianRpIjoiNWRjZTVhODVlZjExNDZhNTg2NzYwYmMwNDNiYmE3NmEiLCJ1c2VyX2lkIjoiMTAifQ.oykv4Fqi9uQos3oH0mx8TONsryoTAkGg4n4-WeYnLSI	2025-10-14 11:35:08.077347+00	2025-10-14 12:34:08+00	10	5dce5a85ef1146a586760bc043bba76a	\N
170	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDUzODIsImlhdCI6MTc2MDQ0MTg0MiwianRpIjoiNGU4NTIyYmMyYzljNDEwMzlmZTZkMDQ3ZjE5NDlkNjQiLCJ1c2VyX2lkIjoiMTAifQ.gGXZ0dRhvNemKUH15BE5pFNAa4xXwru7EW5mAv0abjI	2025-10-14 11:37:22.842761+00	2025-10-14 12:36:22+00	10	4e8522bc2c9c41039fe6d047f1949d64	\N
171	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjA0NDU1MTgsImlhdCI6MTc2MDQ0MTk3OCwianRpIjoiODhlYWZjMzcyNGQyNDlkYzgxODVkMjY2YzY3ZDhkNTYiLCJ1c2VyX2lkIjoiMTAifQ.VHRgYRXSSK-MOvTR-XW9dP-nlYmjhnDIaQTCyo27dng	2025-10-14 11:39:38.623585+00	2025-10-14 12:38:38+00	10	88eafc3724d249dc8185d266c67d8d56	\N
172	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQ3Njc1LCJpYXQiOjE3NjA0NDQxMzUsImp0aSI6IjFkM2I4N2Y5MTkyMTQ0YmFiZDJiMjI5NDE3MmRkYjhlIiwidXNlcl9pZCI6IjEwIn0.ijQ721CkJExNJ1iZsba9zyGHyHMgWcM4KxreH1_Wy44	2025-10-14 12:15:35.425+00	2025-10-14 13:14:35+00	10	1d3b87f9192144babd2b2294172ddb8e	\N
173	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0NzY3NiwiaWF0IjoxNzYwNDQ0MTM2LCJqdGkiOiIzNTc4OTc1YjdlYjA0NGFkOGI4MjRmZTE2YjU0NmJmYiIsInVzZXJfaWQiOiIxMCJ9.lmzkJg4IqYk7wKc5Q8QyqoIqpEPzfGXaMBKzkf3_Rcs	2025-10-14 12:15:36.049662+00	2025-10-14 13:14:36+00	10	3578975b7eb044ad8b824fe16b546bfb	\N
174	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDQ4MDE5LCJpYXQiOjE3NjA0NDQ0NzksImp0aSI6IjU4Mzc0OWZmOWVmNzQ0YmU5ZWI5N2NhNzAzNjUwNTZmIiwidXNlcl9pZCI6IjEwIn0.fJomyr2jszFPtwVTircBZ1IOrN5JkHzyDfxnbD_IAP4	2025-10-14 12:21:19.176407+00	2025-10-14 13:20:19+00	10	583749ff9ef744be9eb97ca70365056f	\N
175	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ0ODAxOSwiaWF0IjoxNzYwNDQ0NDc5LCJqdGkiOiJkNjExZDI0NmVlM2I0Nzg0Yjg1NzUyMWYxOTRjN2MxZiIsInVzZXJfaWQiOiIxMCJ9.IljdwRJZ9nHEu9PkCWcW5rxfLRbDras0jhmCwQXPBDQ	2025-10-14 12:21:19.20821+00	2025-10-14 13:20:19+00	10	d611d246ee3b4784b857521f194c7c1f	\N
176	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzYwNDg1ODMzLCJpYXQiOjE3NjA0ODIyOTMsImp0aSI6ImRlYzY0NTFiYTQ3MTQ3OGQ5MzZjZjNlNzZkMTVhN2Q3IiwidXNlcl9pZCI6IjEwIn0.1EBEmyqLOYEr25RRmeytDU4dTKPFbO_yrG5TiFg3Kmg	2025-10-14 22:51:33.824211+00	2025-10-14 23:50:33+00	10	dec6451ba471478d936cf3e76d15a7d7	\N
177	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2MDQ4NTgzMywiaWF0IjoxNzYwNDgyMjkzLCJqdGkiOiI3ZGIwYWUzMDNmYWQ0YjczYWRhY2RhNzAwYTY1ZWU4ZiIsInVzZXJfaWQiOiIxMCJ9.xO8DHiarnyM58QtiWI-4vU2vCcsuxMua_bfk1A-vwp4	2025-10-14 22:51:33.988969+00	2025-10-14 23:50:33+00	10	7db0ae303fad4b73adacda700a65ee8f	\N
178	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDU4NDU1NywiaWF0IjoxNzY0NTg0MjU3LCJqdGkiOiIxNTgyMDBlNDk4Mjc0MmNhYjQ5ZGYyZDg5NmVmY2FjMSIsInVzZXJfaWQiOiIxMyJ9.9AHfFxKehAQ9MCBvGlWc_nyt8x3hyV4d2m2z7pPb2SI	2025-12-01 10:17:37.450318+00	2025-12-01 10:22:37+00	13	158200e4982742cab49df2d896efcac1	\N
179	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDYwODQzOSwiaWF0IjoxNzY0NjA4MTM5LCJqdGkiOiJjZjFmMGRlNjZlNDY0ODQyOTNiOTNlZDVjODg2MmMzMSIsInVzZXJfaWQiOiIxNSJ9.hmMCIrVRvfArV1JGRwl91dUfUBxyLtwy9D3kzZdHFSI	2025-12-01 16:55:39.252658+00	2025-12-01 17:00:39+00	15	cf1f0de66e46484293b93ed5c8862c31	\N
180	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDYwODY3OCwiaWF0IjoxNzY0NjA4Mzc4LCJqdGkiOiJiZmI3Zjk4NTFmNzY0ZGUyOWY0MjExYjBlNjJiYzBjNSIsInVzZXJfaWQiOiIxNiJ9.B_lfxZxTosawD-DmTyo3EIgXwnC-NfXrHmbbJ3MTBRw	2025-12-01 16:59:38.245678+00	2025-12-01 17:04:38+00	16	bfb7f9851f764de29f4211b0e62bc0c5	\N
181	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDYwOTkyNCwiaWF0IjoxNzY0NjA5NjI0LCJqdGkiOiI3MGFlOGViODc3NjQ0YWVjYTViZmFkOWM2YTIxMWM5NiIsInVzZXJfaWQiOiIxNyJ9.S4LYPkD4NqeLtwqPOmfB5NS2h5MRcUrZdM-WXlil51U	2025-12-01 17:20:24.940684+00	2025-12-01 17:25:24+00	17	70ae8eb877644aeca5bfad9c6a211c96	\N
182	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDYxMDQ0OSwiaWF0IjoxNzY0NjEwMTQ5LCJqdGkiOiIxOGZkNzc1Y2M4YzU0MzM5ODgyOGIxNmMyODM3MmJlMiIsInVzZXJfaWQiOiIxOCJ9.ZVeFQyVzIT0F3mdftnBQZKKtuvIS5dQAzx5kihQ4HnI	2025-12-01 17:29:09.251143+00	2025-12-01 17:34:09+00	18	18fd775cc8c543398828b16c28372be2	\N
183	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDYxMDU3MywiaWF0IjoxNzY0NjEwMjczLCJqdGkiOiI1NzhiOTg5MzM4ZDk0YmQ5YTEwODA1Y2QwZjQxMTM1ZiIsInVzZXJfaWQiOiIxOSJ9.nsiPb4eUhgv6PuiyoapdvJ_DeIXiGK_Ot-njgEwIwbQ	2025-12-01 17:31:13.946048+00	2025-12-01 17:36:13+00	19	578b989338d94bd9a10805cd0f41135f	\N
184	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDYxMDY4MSwiaWF0IjoxNzY0NjEwMzgxLCJqdGkiOiJkZmNiODA3OTAxNjY0NTI5YjNkNzYzMGJmN2RhZTI5MiIsInVzZXJfaWQiOiIyMCJ9.DS73QSi40INg7bgn2iNKnr9S02ZvgrnHAJfhJkrOfH0	2025-12-01 17:33:01.248856+00	2025-12-01 17:38:01+00	20	dfcb807901664529b3d7630bf7dae292	\N
185	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDYxMTA4MSwiaWF0IjoxNzY0NjEwNzgxLCJqdGkiOiI3YzQzOTA3YzExZDM0ZjI5OWRkNTIyYzUzN2Y2MDM5YSIsInVzZXJfaWQiOiIyMSJ9.a8UbsdV6rUybGMa0HBne6LgZhDwBjleEwd1U_UlqDeY	2025-12-01 17:39:41.647589+00	2025-12-01 17:44:41+00	21	7c43907c11d34f299dd522c537f6039a	\N
186	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDYxMjEwMCwiaWF0IjoxNzY0NjExODAwLCJqdGkiOiJkYWEzZmQzYjNhOTg0MmNjODAzNzYyNDNkMTA5NGM3ZiIsInVzZXJfaWQiOiIxMyJ9.MmqOpvOFs9l-q0w_n2rTqr6a_qnmy-_lHMUJLucr9xM	2025-12-01 17:56:40.04068+00	2025-12-01 18:01:40+00	13	daa3fd3b3a9842cc80376243d1094c7f	\N
187	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDYxMjExNywiaWF0IjoxNzY0NjExODE3LCJqdGkiOiJhOWI2NTI3NzNmZWQ0MzdlYmNkMTdiMjE1MzZjMDAzZCIsInVzZXJfaWQiOiIxMyJ9.32TSeRYeJkrjIlcuPbn4jJHdcQAKncmOrkL55rfFWM0	2025-12-01 17:56:57.551191+00	2025-12-01 18:01:57+00	13	a9b652773fed437ebcd17b21536c003d	\N
188	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY2NjEzNSwiaWF0IjoxNzY0NjY1ODM1LCJqdGkiOiJjMmUwOGIwZDhhNGU0NzMzYWM4YzAxODYzM2RkYmU2OSIsInVzZXJfaWQiOiIyMiJ9.soJt-E4e1cQ9VKppgvcH_OdRyd5hE3g0cOXbxlofvBU	2025-12-02 08:57:15.332639+00	2025-12-02 09:02:15+00	22	c2e08b0d8a4e4733ac8c018633ddbe69	\N
189	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY2NjgwOCwiaWF0IjoxNzY0NjY2NTA4LCJqdGkiOiI1MmI3YmE2YzY5ZGU0ZGRjOWIyOTM5YWI4Mzk1ZWMwOCIsInVzZXJfaWQiOiIyMyJ9.8HMksvlwgJoN8FaP_NWl5-Dps-dZmX2POhbs_qmzHi4	2025-12-02 09:08:28.542896+00	2025-12-02 09:13:28+00	23	52b7ba6c69de4ddc9b2939ab8395ec08	\N
190	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY2ODM5MSwiaWF0IjoxNzY0NjY4MDkxLCJqdGkiOiJhNDMzMzQzOWZlMzc0Y2U2YWY3NTkwZjdmZTI5MzRlOCIsInVzZXJfaWQiOiIyMyJ9.zvw_RvIS4OotwNHl9zGqf9t8_MAgHQebck8tW9Y-pOE	2025-12-02 09:34:51.042327+00	2025-12-02 09:39:51+00	23	a4333439fe374ce6af7590f7fe2934e8	\N
191	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY2OTY5MiwiaWF0IjoxNzY0NjY5MzkyLCJqdGkiOiJjZDY4YWMwNjAzYWQ0MDIxODdjZjI4YWUwNDk0NDJjNiIsInVzZXJfaWQiOiIyNCJ9.uuUH2QFt7av6--JtoNNyBEs6ll-kCL09ziWuxsg74aE	2025-12-02 09:56:32.153147+00	2025-12-02 10:01:32+00	24	cd68ac0603ad402187cf28ae049442c6	\N
192	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY3MDAyNiwiaWF0IjoxNzY0NjY5NzI2LCJqdGkiOiI1NjI5NDMyNDkzZjQ0ZTg1OTRhZjY3N2MwZGU2MDZlYiIsInVzZXJfaWQiOiIxMyJ9.LrkEcgWIjTs-WzL8QPz9flEALYVrbXQ79NnR8ihWDBc	2025-12-02 10:02:06.764824+00	2025-12-02 10:07:06+00	13	5629432493f44e8594af677c0de606eb	\N
193	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY3MTk2MCwiaWF0IjoxNzY0NjcxNjYwLCJqdGkiOiIzMjU1MTU4MDZlZTY0MWQ5YTRmMTY4OGM5N2RiNjIxNiIsInVzZXJfaWQiOiIxMyJ9.RuBBEqKrpycVYjvtzsJk5BRBE2cGEF44BvZ8_ogiB-E	2025-12-02 10:34:20.330272+00	2025-12-02 10:39:20+00	13	325515806ee641d9a4f1688c97db6216	\N
194	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY3NDA2MywiaWF0IjoxNzY0NjczNzYzLCJqdGkiOiI3ZTJhZjBiZWUzY2E0ZjY4OGEzODRhZTdmMDk4MGQ5ZSIsInVzZXJfaWQiOiIxMyJ9.I3Nifaj3OAhOBU_L2TBbhl5pK8zW-UHBPWLv4DuUvdE	2025-12-02 11:09:23.226106+00	2025-12-02 11:14:23+00	13	7e2af0bee3ca4f688a384ae7f0980d9e	\N
195	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY3NDUyMiwiaWF0IjoxNzY0Njc0MjIyLCJqdGkiOiJhYzQzNTUwMDNiMDE0MmM0YTVkMTIyZTZlNDNjODg5MyIsInVzZXJfaWQiOiIxMyJ9.S4ZQoB_FXLsZxupQA1bTVXNCb8uMcxUtTBb28oKUVSY	2025-12-02 11:17:02.320437+00	2025-12-02 11:22:02+00	13	ac4355003b0142c4a5d122e6e43c8893	\N
196	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY3NTM0MSwiaWF0IjoxNzY0Njc1MDQxLCJqdGkiOiIxNjhkM2ZjZTE4Y2Q0ZWI1OGYwNWQ0MjFiYzZlODM2YyIsInVzZXJfaWQiOiIxMyJ9.FikD-Yc4kLnG5yg4PCnUEtGQDOgV-ZwfderqqWE72as	2025-12-02 11:30:41.529731+00	2025-12-02 11:35:41+00	13	168d3fce18cd4eb58f05d421bc6e836c	\N
197	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY3NTc0NSwiaWF0IjoxNzY0Njc1NDQ1LCJqdGkiOiJhNzI2NWM2MzAyNDQ0M2MyODVkMWQ3YzMwZjkwM2UwZCIsInVzZXJfaWQiOiIxMyJ9.O7if9Eqrs4b6F7V9kMFpKQi82BopKTD1BDe0Se4o0ps	2025-12-02 11:37:25.530155+00	2025-12-02 11:42:25+00	13	a7265c63024443c285d1d7c30f903e0d	\N
198	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY3NjIwNiwiaWF0IjoxNzY0Njc1OTA2LCJqdGkiOiI5MDViNzAzZTYxYTM0Yjc0OTBlMGEyZGY0MTE3MDE5YSIsInVzZXJfaWQiOiIxMyJ9.LrmE5Fy3aUoEHboBYtwXxh-WFOULUnyI_3kLwpvgHy8	2025-12-02 11:45:06.322262+00	2025-12-02 11:50:06+00	13	905b703e61a34b7490e0a2df4117019a	\N
199	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY3Njc0NSwiaWF0IjoxNzY0Njc2NDQ1LCJqdGkiOiJmNmQwMDA1NzAzMWY0MTMwOGQ5YzYxNjE5M2EwNmE3MyIsInVzZXJfaWQiOiIyMSJ9.guI0Od_VccX3fpiQX0M7wTbi5TeYuTe83nA66YzgqQk	2025-12-02 11:54:05.827257+00	2025-12-02 11:59:05+00	21	f6d00057031f41308d9c616193a06a73	\N
200	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY3NzA0MiwiaWF0IjoxNzY0Njc2NzQyLCJqdGkiOiI3M2JhY2UxYjU4MWQ0OTAxYjZlMmM1Mzc5NWQxZTZkOSIsInVzZXJfaWQiOiIxMyJ9.ki-SPj090TXNsDax7oPYga9bQpylFg5BCweh3FwrBd8	2025-12-02 11:59:02.019731+00	2025-12-02 12:04:02+00	13	73bace1b581d4901b6e2c53795d1e6d9	\N
201	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDY3NzY4NCwiaWF0IjoxNzY0Njc3Mzg0LCJqdGkiOiI2NjIwYmRkOGNhODU0ZjY4ODM1YjdjMmE1ZDc4YTlmYyIsInVzZXJfaWQiOiIxMyJ9.5n3rouqxaEhHWEebYyAJuPNq3nAbOwmeLf36j__LxQw	2025-12-02 12:09:44.929715+00	2025-12-02 12:14:44+00	13	6620bdd8ca854f68835b7c2a5d78a9fc	\N
202	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDgzNzgwNCwiaWF0IjoxNzY0ODM3NTA0LCJqdGkiOiJjMGZhMGVhMzU2Y2U0MzNlYjUyN2U4N2Q0ODg3MzI5NCIsInVzZXJfaWQiOiIxMyJ9._vjvfJvmd4v_ULf02dYG8p2Fdl46QozDBwICLTI2q4k	2025-12-04 08:38:24.009831+00	2025-12-04 08:43:24+00	13	c0fa0ea356ce433eb527e87d48873294	\N
203	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDgzNzk1OCwiaWF0IjoxNzY0ODM3NjU4LCJqdGkiOiI3MWY5ODVmMzQ0YmE0Yjk2YTUzNjdjYzc4NDE0MjE4ZSIsInVzZXJfaWQiOiIxMyJ9.VM1yPXROu8EkWC-GuCI6l4ASSYODm6zV7hgA5hvJmgY	2025-12-04 08:40:58.115448+00	2025-12-04 08:45:58+00	13	71f985f344ba4b96a5367cc78414218e	\N
204	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDgzODc0MCwiaWF0IjoxNzY0ODM4NDQwLCJqdGkiOiI0MzY5MmVhZjhkYTY0Y2I5OGEzOTNmOTZiNGU4ZmVkYyIsInVzZXJfaWQiOiIxMyJ9.KdA8lGMBdpvOo-0rUEPSryQPDxb_utsriVdNLavhB7M	2025-12-04 08:54:00.818567+00	2025-12-04 08:59:00+00	13	43692eaf8da64cb98a393f96b4e8fedc	\N
205	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0MDMzNywiaWF0IjoxNzY0ODQwMDM3LCJqdGkiOiI3OWI2YjI5ZTg0NTQ0Yzg5YmM4MDM2N2VjMGFlYzUyYyIsInVzZXJfaWQiOiIxMyJ9.PXbhYbGY7o5ZywJQ3NPOKuxRXdho62Nhb-MLFjdw3aQ	2025-12-04 09:20:37.108938+00	2025-12-04 09:25:37+00	13	79b6b29e84544c89bc80367ec0aec52c	\N
206	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0MDg1MywiaWF0IjoxNzY0ODQwNTUzLCJqdGkiOiIxMzcwY2FjYjBmNDA0MzA3OTljMGJjMjQ0Y2U1NDQ5MyIsInVzZXJfaWQiOiIxMyJ9.bRijdr7n1ehU_OKyD83PBgzRApTl49qfaHVEkJi3s0g	2025-12-04 09:29:13.118287+00	2025-12-04 09:34:13+00	13	1370cacb0f40430799c0bc244ce54493	\N
207	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0MTc4NSwiaWF0IjoxNzY0ODQxNDg1LCJqdGkiOiJiMjViYTY2MWQ1OTk0OGM1OTdhNGM1NTUyYzE2NjY1MyIsInVzZXJfaWQiOiIxMyJ9.md2jrcc5WfswUzbx-RazjcVK9CJxNUiSngWe7JMI7iM	2025-12-04 09:44:45.319259+00	2025-12-04 09:49:45+00	13	b25ba661d59948c597a4c5552c166653	\N
208	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0MjA3OSwiaWF0IjoxNzY0ODQxNzc5LCJqdGkiOiJlNmJmY2M2OTcyYjU0ZGVmYWUxYTRkYTg3YTgyODM0MSIsInVzZXJfaWQiOiIxMyJ9.7-jRphK49MUUNMdmmc6XqV4VK6opO4wxglGsGnsAI44	2025-12-04 09:49:39.420573+00	2025-12-04 09:54:39+00	13	e6bfcc6972b54defae1a4da87a828341	\N
209	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0MjE4MywiaWF0IjoxNzY0ODQxODgzLCJqdGkiOiJhOTk1MWU4NGVhNzc0NDNhYjk1ODRiMDM4Y2ZhNmQwZiIsInVzZXJfaWQiOiIxMyJ9.1zg-vcj-XewvRJB3TVF3Nxa-KfaG5gkj0bv44Ket02E	2025-12-04 09:51:23.01155+00	2025-12-04 09:56:23+00	13	a9951e84ea77443ab9584b038cfa6d0f	\N
210	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0MjIzMCwiaWF0IjoxNzY0ODQxOTMwLCJqdGkiOiJhOWUwNDhiYTA1M2Y0OWZmYjE1YmQ0NGY2YjVhZWM1OSIsInVzZXJfaWQiOiIxMyJ9.kq0VE12EckBeErA3o7rMVVdofgzcRFvTZBv5q3Omhi0	2025-12-04 09:52:10.108137+00	2025-12-04 09:57:10+00	13	a9e048ba053f49ffb15bd44f6b5aec59	\N
211	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0Mjc5MiwiaWF0IjoxNzY0ODQyNDkyLCJqdGkiOiJhMjgzNTQ2NjNjMzk0NDg1YTg1NmIyODRlMWVhOWJjNyIsInVzZXJfaWQiOiIxMyJ9.fj6quSdmvAv8RVkWkgDKmlteIi6wTMQf7s3ahj1-iNE	2025-12-04 10:01:32.917116+00	2025-12-04 10:06:32+00	13	a28354663c394485a856b284e1ea9bc7	\N
212	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0Mzg2NSwiaWF0IjoxNzY0ODQzNTY1LCJqdGkiOiI4ZDI5NzNkZmNiMDI0MTU1YjdlMmEwMmYzYWI3ZGJiMiIsInVzZXJfaWQiOiIxMyJ9.-qbuSmO76iPPxZ0J4INyIZlN8z8A3pzoh5YvlEeXtAE	2025-12-04 10:19:25.383446+00	2025-12-04 10:24:25+00	13	8d2973dfcb024155b7e2a02f3ab7dbb2	\N
213	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0NDI3MCwiaWF0IjoxNzY0ODQzOTcwLCJqdGkiOiJlNTc2NzMxNDlmZGI0MjBmODgxNThkMmM1YjI3ZDJhMCIsInVzZXJfaWQiOiIxMyJ9.VkQq40pyobZ86QKEKAPUqw9N_CyLVxBsGOmJnEJ2kmA	2025-12-04 10:26:10.891357+00	2025-12-04 10:31:10+00	13	e57673149fdb420f88158d2c5b27d2a0	\N
214	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0NDc4MiwiaWF0IjoxNzY0ODQ0NDgyLCJqdGkiOiIwNjg4NGNmMjk5NGQ0NWVjYWQ3MzYzOTJiOWMzYjM3ZiIsInVzZXJfaWQiOiIxMyJ9.LYY6SUInUiG-KpU0CQvnzQNFn4GVTDt8ScofOnML5QY	2025-12-04 10:34:42.18084+00	2025-12-04 10:39:42+00	13	06884cf2994d45ecad736392b9c3b37f	\N
215	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0NTA0NSwiaWF0IjoxNzY0ODQ0NzQ1LCJqdGkiOiIzMTc2NDQ3YzFiMTI0M2FmOWJhOGUzZjFiYzU5NmI3OCIsInVzZXJfaWQiOiIxMyJ9.B5aP6fTO0c020n-uX-DCaEKJXArwGO2FymXa4-a75AY	2025-12-04 10:39:05.477223+00	2025-12-04 10:44:05+00	13	3176447c1b1243af9ba8e3f1bc596b78	\N
216	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg0ODMzOCwiaWF0IjoxNzY0ODQ4MDM4LCJqdGkiOiIyYzI5Y2JkOTQ1ODk0NWVkOGZjOWI5ZTYzNDMxNDc5NyIsInVzZXJfaWQiOiIxMyJ9.qI8mwoKDejZSqei66WI52jETLROs2Pa_1j62GzvMSEI	2025-12-04 11:33:58.037281+00	2025-12-04 11:38:58+00	13	2c29cbd9458945ed8fc9b9e634314797	\N
217	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg2Mjk5NCwiaWF0IjoxNzY0ODYyNjk0LCJqdGkiOiJlODBhNDg3OWZjMTQ0MTRkYjBiZjVhZjlmNGUzODY5MCIsInVzZXJfaWQiOiIyNSJ9.9i2xjhfJkM4MlAQo1ysclSvWcJjlGlxepSIoxR5Woxc	2025-12-04 15:38:14.577311+00	2025-12-04 15:43:14+00	25	e80a4879fc14414db0bf5af9f4e38690	\N
218	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg2MzA2OSwiaWF0IjoxNzY0ODYyNzY5LCJqdGkiOiIyMDcwZmVmODVmZGU0NjM3OWRkZmU4OTJjMjZiNjUwOSIsInVzZXJfaWQiOiIyNSJ9.ZmUj3F40MTftKbD0iNMYXkjXju-rD0ilIXOTKw55jW0	2025-12-04 15:39:29.88062+00	2025-12-04 15:44:29+00	25	2070fef85fde46379ddfe892c26b6509	\N
219	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg2NDY1NywiaWF0IjoxNzY0ODY0MzU3LCJqdGkiOiI2NTk3OTkyNDA0MmI0ODE0ODA0N2E0ZjgyNDI1YTBhYyIsInVzZXJfaWQiOiIyNSJ9.vnlB8JHqVk4EvpMDr1bKevMBkRcUKYpMKcdZ1I4Ned4	2025-12-04 16:05:57.979658+00	2025-12-04 16:10:57+00	25	65979924042b48148047a4f82425a0ac	\N
220	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg2NjIyNCwiaWF0IjoxNzY0ODY1OTI0LCJqdGkiOiIwNDcyNTI3NGViZWU0YjcyOTg4MTk3M2RmZTdjMDIwOSIsInVzZXJfaWQiOiIyNiJ9.4yjt0-B3fgsSyT7pyF15qHPrCletpeUXTQxerEZ71ew	2025-12-04 16:32:04.308758+00	2025-12-04 16:37:04+00	26	04725274ebee4b729881973dfe7c0209	\N
221	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDg2NzA3NiwiaWF0IjoxNzY0ODY2Nzc2LCJqdGkiOiI2ODFjN2Q4MGVhZWI0YTEzOGUxYWQ4NmRiODliNDI5OSIsInVzZXJfaWQiOiIzMSJ9.2slgrhRmZimD_0j9pH9H96-c_zWLDh1n8tiBiQohyp4	2025-12-04 16:46:16.306058+00	2025-12-04 16:51:16+00	31	681c7d80eaeb4a138e1ad86db89b4299	\N
222	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjQ5MzUwMzMsImlhdCI6MTc2NDkzMTQ5MywianRpIjoiZTg0OWEzMWU1NjkwNDMyNGI2Y2ZlNWNkNjAxOWUzMGYiLCJ1c2VyX2lkIjoiMTMifQ.VwupQN37GUCW0Wj4c0SdDDk2dLqUrgvTTV3nmGBa7yE	2025-12-05 10:44:53.889244+00	2025-12-05 11:43:53+00	13	e849a31e56904324b6cfe5cd6019e30f	\N
223	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjQ5Mzg2MjksImlhdCI6MTc2NDkzNTA4OSwianRpIjoiYWMyNTY5YTE4OGY2NDc0ODlmMmZiZDE2YWYwNWYxNjkiLCJ1c2VyX2lkIjoiMTMifQ.8LP9jmKJ2mF8Ln0uEupGQ9PCzK39YDDuS3bz4nzQRRA	2025-12-05 11:44:49.176631+00	2025-12-05 12:43:49+00	13	ac2569a188f647489f2fbd16af05f169	\N
224	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjQ5NDQ4MzAsImlhdCI6MTc2NDk0MTI5MCwianRpIjoiOTEwYzYwYzlhZmM0NGU2MmFjNzYyNDliOTk4MDcyODUiLCJ1c2VyX2lkIjoiMTMifQ.S6iAit80vhjqki7-JpD4bCwM3gbBOuHLYtS6QPEieR0	2025-12-05 13:28:10.32131+00	2025-12-05 14:27:10+00	13	910c60c9afc44e62ac76249b99807285	\N
225	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjQ5NDYyNDgsImlhdCI6MTc2NDk0MjcwOCwianRpIjoiYTYzZDE2YzA4M2MzNDA5Y2ExMjEzNDRjNjYyYzQ1NjUiLCJ1c2VyX2lkIjoiMTMifQ.oaEDxZLc9YE7ManKfnvzVJKZMyl-jmoJM9rOwQoEpn8	2025-12-05 13:51:48.299377+00	2025-12-05 14:50:48+00	13	a63d16c083c3409ca121344c662c4565	\N
226	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjQ5NDY2MDcsImlhdCI6MTc2NDk0MzA2NywianRpIjoiZDQyNDJiODFkMzFlNGNjMjhhOTMwYjNmYmFlY2IxYTQiLCJ1c2VyX2lkIjoiMTMifQ.y1WNeN3FUDbeDGUzpZrBpGrj69ckzlGp73HqVKXy0hk	2025-12-05 13:57:47.621022+00	2025-12-05 14:56:47+00	13	d4242b81d31e4cc28a930b3fbaecb1a4	\N
227	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjQ5NDcxMDgsImlhdCI6MTc2NDk0MzU2OCwianRpIjoiMzEwNDIxZWVjNDFjNGFhMzhmNjI0OWU5YTNjMWU0ZTYiLCJ1c2VyX2lkIjoiMTMifQ.Sy8H_e3xACyN_YTLJs5m0Qp55dD0SoEpWbDTYP5RWrQ	2025-12-05 14:06:08.874825+00	2025-12-05 15:05:08+00	13	310421eec41c4aa38f6249e9a3c1e4e6	\N
228	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjQ5NDcxNzgsImlhdCI6MTc2NDk0MzYzOCwianRpIjoiMzlkY2JjNDI3YTVkNGE1NWJjYjc4NTA4NTI0NDAwNmIiLCJ1c2VyX2lkIjoiMTMifQ._Zz8E5n5HzoV08x_-7OTuqy-OGE9g5T3HG1Vpqtgh3A	2025-12-05 14:07:18.366985+00	2025-12-05 15:06:18+00	13	39dcbc427a5d4a55bcb785085244006b	\N
229	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjQ5NDgyMTEsImlhdCI6MTc2NDk0NDY3MSwianRpIjoiNmQ3YTVlNDliNjRkNGJlOWEyN2JkNDE4NjkzOTI3NGYiLCJ1c2VyX2lkIjoiMTMifQ.X-DdxfPDE5uVDn-HK_cZows9k-JhuM01PgmeZJ9ujps	2025-12-05 14:24:31.887263+00	2025-12-05 15:23:31+00	13	6d7a5e49b64d4be9a27bd4186939274f	\N
230	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjQ5NDgzOTksImlhdCI6MTc2NDk0NDg1OSwianRpIjoiM2IzZDM2YzZlMDg1NDRlZDljYzNhZjdlYWMxMDYyMzAiLCJ1c2VyX2lkIjoiMTMifQ.KqyrNc7NseG264MvP38xzY9oMFGdfZHv4gu6ClkgY1c	2025-12-05 14:27:39.415022+00	2025-12-05 15:26:39+00	13	3b3d36c6e08544ed9cc3af7eac106230	\N
231	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjQ5NDk2ODAsImlhdCI6MTc2NDk0NjE0MCwianRpIjoiMmYwY2EyYmVmMzA1NDg5ZTkwMjE0ODYxYmVmMWM5ZmYiLCJ1c2VyX2lkIjoiMTMifQ.nDcnTyJym6MvYGZbPvz6MRBvqmMlbWUsAIRDFEdOJ6c	2025-12-05 14:49:00.716209+00	2025-12-05 15:48:00+00	13	2f0ca2bef305489e90214861bef1c9ff	\N
232	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDk0NjU1OSwiaWF0IjoxNzY0OTQ2MjU5LCJqdGkiOiJhOGNkMDFjY2FiMjQ0OTI5OWFhNGFjNGVkZjVhMjJhNCIsInVzZXJfaWQiOiIxMyJ9.TCDlZEQs9En3RmVArp3iA6dDASgk938ZUZbMULHYcv0	2025-12-05 14:50:59.238665+00	2025-12-05 14:55:59+00	13	a8cd01ccab2449299aa4ac4edf5a22a4	\N
233	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDk0NjgyNiwiaWF0IjoxNzY0OTQ2NTI2LCJqdGkiOiI4MjI1OGI5Yjg5MmM0MzljYTQwNWE4MDMyZDAxNTQ3YiIsInVzZXJfaWQiOiIxMyJ9.2VYxg2wwiuB8Bxtgih-IYppWXDdSLfitzlpERKci8pA	2025-12-05 14:55:26.540784+00	2025-12-05 15:00:26+00	13	82258b9b892c439ca405a8032d01547b	\N
234	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDk0ODg0NiwiaWF0IjoxNzY0OTQ4NTQ2LCJqdGkiOiIyNjNjNzkyOGY1ZmQ0ZWJiYWNmZTRiMTcwYmMzYWNiMyIsInVzZXJfaWQiOiIxMyJ9.6iMZQ-v7ffm6YSANc36ekYrEJ9TcSJRPGtijTYAOpd4	2025-12-05 15:29:06.240767+00	2025-12-05 15:34:06+00	13	263c7928f5fd4ebbacfe4b170bc3acb3	\N
235	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAyMTIxOCwiaWF0IjoxNzY1MDIwOTE4LCJqdGkiOiJkOWQ1NzEzMmJiODc0M2IyOWQ2YTkwNTQ2OGZjNDMyOSIsInVzZXJfaWQiOiIxMyJ9.0vkmoj0q0rvODzmWN_w_UKcgo_lgBP9HO_cF3fj_qcs	2025-12-06 11:35:18.052948+00	2025-12-06 11:40:18+00	13	d9d57132bb8743b29d6a905468fc4329	\N
236	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAyMzY5MywiaWF0IjoxNzY1MDIzMzkzLCJqdGkiOiI4MDNkNDFmNWVlODA0ZmY5ODIwY2UxNjE0NmQzM2UxZCIsInVzZXJfaWQiOiIxMyJ9.maGLUB_uQQw-7yfQoCjtXTVl3Iz8SHVfBmuNP9aRNFs	2025-12-06 12:16:33.640682+00	2025-12-06 12:21:33+00	13	803d41f5ee804ff9820ce16146d33e1d	\N
237	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzMTk1OCwiaWF0IjoxNzY1MDMxNjU4LCJqdGkiOiIwZDI1ZWZiY2E0OWE0ZjVkOTA0OWM4ZWQ2YzlkNjM2NyIsInVzZXJfaWQiOiIxMyJ9.DIX4vusawXvrC5AVtLoxZTb_euBziQ8nap8tBcoEfG0	2025-12-06 14:34:18.890673+00	2025-12-06 14:39:18+00	13	0d25efbca49a4f5d9049c8ed6c9d6367	\N
238	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNDY2NywiaWF0IjoxNzY1MDM0MzY3LCJqdGkiOiJiNGRkMDBlZTQ4MGM0MjU3OTljYmI1YzA2Mjc5MmU3NCIsInVzZXJfaWQiOiIxMyJ9.0ICEczNLLwR2quevZN40w3k4xbq7LQLjKL2yx3wd62I	2025-12-06 15:19:27.081781+00	2025-12-06 15:24:27+00	13	b4dd00ee480c425799cbb5c062792e74	\N
239	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzNjUyNiwiaWF0IjoxNzY1MDM2MjI2LCJqdGkiOiI4NWQwZWNjZjQwMDY0N2E2OWM1NjIxOTEwYTY5MTU3MSIsInVzZXJfaWQiOiIxMyJ9.oLY-7lJRSzAs3aj6mB6yG7-EEpM3APrFFVfz3lgMlVY	2025-12-06 15:50:26.584004+00	2025-12-06 15:55:26+00	13	85d0eccf400647a69c5621910a691571	\N
240	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzODIwNiwiaWF0IjoxNzY1MDM3OTA2LCJqdGkiOiIyMGEyMTE5M2QxNmE0OGY2OWY0ZmI1ZmMyMmU3YjJiMCIsInVzZXJfaWQiOiIxMyJ9.Rcomq6YTIm-D99dRJRny2ZVj7YqTxKrH-Y93mknLADM	2025-12-06 16:18:26.692413+00	2025-12-06 16:23:26+00	13	20a21193d16a48f69f4fb5fc22e7b2b0	\N
241	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTAzOTgzNCwiaWF0IjoxNzY1MDM5NTM0LCJqdGkiOiI4ODMyYjM5ZGRiNzE0ZGY0OGYzZTc0MDI5ODE5YTNmNCIsInVzZXJfaWQiOiIxMyJ9.Yhmk9ErZvA2qEjdHw9LvXMTiw8LgI6uFuVFuxKAtCxk	2025-12-06 16:45:34.397232+00	2025-12-06 16:50:34+00	13	8832b39ddb714df48f3e74029819a3f4	\N
242	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTA0MDcxMSwiaWF0IjoxNzY1MDQwNDExLCJqdGkiOiIwYTI4MjBjODg3ZjI0NmYxYmVkOTEzN2JhZjk3YjRlZSIsInVzZXJfaWQiOiIxMyJ9.naYmllMpZKDRVvdt3rDz8J1_Rfejzdi6tG5MW3-h4K8	2025-12-06 17:00:11.090479+00	2025-12-06 17:05:11+00	13	0a2820c887f246f1bed9137baf97b4ee	\N
243	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTA0MDg3MywiaWF0IjoxNzY1MDQwNTczLCJqdGkiOiJlYjU3NzM5ZjUyZGQ0NzZhOTBjYTc3MzgxNmYyZjg2ZiIsInVzZXJfaWQiOiIxMyJ9.zg0WUZAaTZs-MzGPblOypyzb-9SkKhxmhM7rg3CDcbM	2025-12-06 17:02:53.886885+00	2025-12-06 17:07:53+00	13	eb57739f52dd476a90ca773816f2f86f	\N
244	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTA0MTU3MiwiaWF0IjoxNzY1MDQxMjcyLCJqdGkiOiJmZWM4M2QwZDNkN2U0ZjIxODdiOTYxMjkyNTkyMDdhYiIsInVzZXJfaWQiOiIxMyJ9.nc66rme97FVVP1ck3Sce9Kwpni8JJ_xKM_WZlgit2a4	2025-12-06 17:14:32.993102+00	2025-12-06 17:19:32+00	13	fec83d0d3d7e4f2187b96129259207ab	\N
245	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTI2Nzk5NywiaWF0IjoxNzY1MjY3Njk3LCJqdGkiOiJmMWY0YzIyNThlOGE0YjU4ODI0NTY5ZTNkOTZlNWQ1ZiIsInVzZXJfaWQiOiIxMyJ9.WPNFKfzI4HWQ6dvxjti9tF9AzVuSY8v1Xg2ebNTlq9g	2025-12-09 08:08:17.751622+00	2025-12-09 08:13:17+00	13	f1f4c2258e8a4b58824569e3d96e5d5f	\N
246	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1MjczODg0LCJpYXQiOjE3NjUyNzAzNDQsImp0aSI6ImIxMDNjN2M4MTFmYjRiNTNiN2JiZDFiNTk0Mjc1MzU2IiwidXNlcl9pZCI6IjEzIn0.4XDqYm1qI01Dg8P1KhbuiiiJAFIEJc9rYIYpyA0zC30	2025-12-09 08:52:24.869516+00	2025-12-09 09:51:24+00	13	b103c7c811fb4b53b7bbd1b594275356	\N
247	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTI3Mzg4NCwiaWF0IjoxNzY1MjcwMzQ0LCJqdGkiOiI4NjNlMmNjOGQ5Yzk0MzdmOGExOWM1M2Q3YzNhOWQzZSIsInVzZXJfaWQiOiIxMyJ9.fe3tHvxPQuBLpXKlIvMHX6izNxH80V2LrankFGxz2aY	2025-12-09 08:52:24.969378+00	2025-12-09 09:51:24+00	13	863e2cc8d9c9437f8a19c53d7c3a9d3e	\N
248	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1MjczOTY4LCJpYXQiOjE3NjUyNzA0MjgsImp0aSI6ImM3YjllNDlkMmE2MzQyMjA5YTA3ZDU4MTVkYTE0ZWE0IiwidXNlcl9pZCI6IjEzIn0.esaNT1OPxna8z_g-ZcOaTPi8VsTU5SyqtS60vlPHZBI	2025-12-09 08:53:48.464384+00	2025-12-09 09:52:48+00	13	c7b9e49d2a6342209a07d5815da14ea4	\N
249	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTI3Mzk2OCwiaWF0IjoxNzY1MjcwNDI4LCJqdGkiOiIwNjlhYzI5OTlmNDY0Mzk0YTRmOGRjZGU2NTIyZWUxMSIsInVzZXJfaWQiOiIxMyJ9.TY-7wqMcvZCBQECCrZ0TQE9cmeyhRPh3xP8gyP1lCEs	2025-12-09 08:53:48.508314+00	2025-12-09 09:52:48+00	13	069ac2999f464394a4f8dcde6522ee11	\N
250	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTI5OTAxOCwiaWF0IjoxNzY1Mjk4NzE4LCJqdGkiOiJiMGIzMzA5ZTg0ZGU0NDhkYWUyYTkwZTYyOTQ5NjJhNiIsInVzZXJfaWQiOiIzNyJ9.0J_jvylYeHPHB3u1wOHvut24VNtZhs2wXifYdE1lw9k	2025-12-09 16:45:18.97229+00	2025-12-09 16:50:18+00	37	b0b3309e84de448dae2a90e6294962a6	\N
251	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTMwMTIyNywiaWF0IjoxNzY1MzAwOTI3LCJqdGkiOiI0ZGZmY2Q1MWI5M2Q0MTAwYTY1YmVmZTdjMDM3ZDExOCIsInVzZXJfaWQiOiIzNyJ9.VTB03bXlRxAaYCsKEmv14T94Fq3m8tw9zVup6SqL7fs	2025-12-09 17:22:07.666671+00	2025-12-09 17:27:07+00	37	4dffcd51b93d4100a65befe7c037d118	\N
252	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTMwMzA2MywiaWF0IjoxNzY1MzAyNzYzLCJqdGkiOiI3ZTI1NjdhMDY2MWM0OTZmODY5NmYxMzIzZTA5NmM3NCIsInVzZXJfaWQiOiIzNyJ9.y-79Y6CFlstVgQNQMppBdrdGeodsCOamv3VdNinhkdg	2025-12-09 17:52:43.961329+00	2025-12-09 17:57:43+00	37	7e2567a0661c496f8696f1323e096c74	\N
253	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTMwNjQzMCwiaWF0IjoxNzY1MzA2MTMwLCJqdGkiOiI4OWVmZDY5YjZlNWU0ZTQ1YmFjYWYxMjJhMWE3ZWNmNyIsInVzZXJfaWQiOiIxIn0.PXC16XBapk8ExyQiZnH_h_ds_WvCscNFm1Cu30aLJkQ	2025-12-09 18:48:50.571728+00	2025-12-09 18:53:50+00	1	89efd69b6e5e4e45bacaf122a1a7ecf7	\N
254	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM1OTE1OSwiaWF0IjoxNzY1MzU4ODU5LCJqdGkiOiJlYzIxMTlhZmE5OWY0NDAzYTE0ZDM1YjMwM2Q2MmQzMyIsInVzZXJfaWQiOiIzOCJ9.5u4D_4KlJ1GhrTJyRvc9nycWhBb3qDtbBxsN3-WgUmE	2025-12-10 09:27:39.374354+00	2025-12-10 09:32:39+00	38	ec2119afa99f4403a14d35b303d62d33	\N
255	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM2MDE5MiwiaWF0IjoxNzY1MzU5ODkyLCJqdGkiOiJkYzY0YjcwYzU0YWI0YTcyODhjNGM3YzBiODJiZWNjNSIsInVzZXJfaWQiOiIzOCJ9.W6uC3SWP44oY_sHIbzOx16o_iBGxlif-I9HX8Gw4J_o	2025-12-10 09:44:52.275877+00	2025-12-10 09:49:52+00	38	dc64b70c54ab4a7288c4c7c0b82becc5	\N
256	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM2MDc1MCwiaWF0IjoxNzY1MzYwNDUwLCJqdGkiOiJiNjhlMTFlODcxYzM0YWI0OTUzYmUxOGYxMTIwNjIzZSIsInVzZXJfaWQiOiIzOCJ9.c9k2gFNXN3uSg8hMEUjHKBm9NF7hVPi_XG07jbuFi50	2025-12-10 09:54:10.285339+00	2025-12-10 09:59:10+00	38	b68e11e871c34ab4953be18f1120623e	\N
257	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM2MTgyMCwiaWF0IjoxNzY1MzYxNTIwLCJqdGkiOiI2ODRkODJjMjExOTU0MmJmOWM2NzA5ODI2YzZjZWUwZCIsInVzZXJfaWQiOiIzOCJ9.3_MHUJBpRfaC9iuwFwx5q8NPSxIVgzVBOMZ46hFEsmc	2025-12-10 10:12:00.403487+00	2025-12-10 10:17:00+00	38	684d82c2119542bf9c6709826c6cee0d	\N
258	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM3ODYzNSwiaWF0IjoxNzY1Mzc4MzM1LCJqdGkiOiI2NDYyY2NmYzJmZDA0YzI5ODg4NDI5NzA5MGY1YTkxOSIsInVzZXJfaWQiOiIxMyJ9.Q8M4VC3EZuIwGGdoG1FY0ECN6uUOab4scU92OHiHzKw	2025-12-10 14:52:15.578444+00	2025-12-10 14:57:15+00	13	6462ccfc2fd04c298884297090f5a919	\N
259	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1Mzg3MTkyLCJpYXQiOjE3NjUzODM2NTIsImp0aSI6ImQyYjJjOThmMGFkNjQzNzQ4ZGFlZDA3YjcxODZkNjIwIiwidXNlcl9pZCI6IjEzIn0.24arX7LDWa2GnUbcNhIWjxorKIfJoE5Ub6CTVs_B0y4	2025-12-10 16:20:52.943538+00	2025-12-10 17:19:52+00	13	d2b2c98f0ad643748daed07b7186d620	\N
260	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM4NzE5MywiaWF0IjoxNzY1MzgzNjUzLCJqdGkiOiJkM2Y0MzRmNTFlMGQ0YjVlOWFhMjQ1NGY1ZWQwMzlmZCIsInVzZXJfaWQiOiIxMyJ9.3aXWx7HEHTrzsXDV9nEzoLi7KV0Kk2MEmKhPLjWXT9o	2025-12-10 16:20:53.018717+00	2025-12-10 17:19:53+00	13	d3f434f51e0d4b5e9aa2454f5ed039fd	\N
261	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM4NDcxOCwiaWF0IjoxNzY1Mzg0NDE4LCJqdGkiOiJkY2ZhNzc3ZjQxOTY0Nzg3YmVmNmI5OWEwZWRhMmU4NiIsInVzZXJfaWQiOiIxMyJ9.dQ-PQ4nkEE5L3Ityricrby7sB0h9oFbH4UiMAwsImm8	2025-12-10 16:33:38.118188+00	2025-12-10 16:38:38+00	13	dcfa777f41964787bef6b99a0eda2e86	\N
262	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1Mzg4Mzg0LCJpYXQiOjE3NjUzODQ4NDQsImp0aSI6IjQ1OWZkOGI1OWYwNjQ0OWY5NGQzMmRlNWU3Zjk4NDBmIiwidXNlcl9pZCI6IjEzIn0.WE-T_IpsYTr-RwuW5CtisGQF1MTq6NAe4CZ7i-oUShc	2025-12-10 16:40:44.220894+00	2025-12-10 17:39:44+00	13	459fd8b59f06449f94d32de5e7f9840f	\N
263	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM4ODM4NCwiaWF0IjoxNzY1Mzg0ODQ0LCJqdGkiOiIwYWM5N2U5MjMwYWQ0OTdmYWQ2Y2FjMTNiZDRjYjIzOCIsInVzZXJfaWQiOiIxMyJ9.Qh_3oJyHkcb6NILLzVz-QLQXKwuoYuD5fvGO8nRl9uk	2025-12-10 16:40:44.260254+00	2025-12-10 17:39:44+00	13	0ac97e9230ad497fad6cac13bd4cb238	\N
264	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1Mzg4NzExLCJpYXQiOjE3NjUzODUxNzEsImp0aSI6IjZjNTU3MDE0OTlkYjQ2YzFhZmJlMzA3YmI5MzhiYWEzIiwidXNlcl9pZCI6IjEzIn0.GqoQiuhoWaC2kAhZDPgDynkscmf21Y4zTvFKF5hePLY	2025-12-10 16:46:11.868627+00	2025-12-10 17:45:11+00	13	6c55701499db46c1afbe307bb938baa3	\N
265	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM4ODcxMSwiaWF0IjoxNzY1Mzg1MTcxLCJqdGkiOiI5MzEyNjE5ZDMxZDk0YmJkYWU3YmExOTViZmNlNDMyNyIsInVzZXJfaWQiOiIxMyJ9.D9ZTT9jbRG4dCw89tdLMLX6nGmquSmlOhGyN5FMLUTY	2025-12-10 16:46:11.899063+00	2025-12-10 17:45:11+00	13	9312619d31d94bbdae7ba195bfce4327	\N
266	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1Mzg5ODgzLCJpYXQiOjE3NjUzODYzNDMsImp0aSI6Ijg3ZWI3ZDY3Y2JlMTRmZGQ5MjAzOTQ5NGU1YjdhYjM3IiwidXNlcl9pZCI6IjEzIn0.G01z0RiM7UVBFIcEAYdP8dMgED-lP8aZJPs6WxVcKhI	2025-12-10 17:05:43.275398+00	2025-12-10 18:04:43+00	13	87eb7d67cbe14fdd92039494e5b7ab37	\N
267	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM4OTg4MywiaWF0IjoxNzY1Mzg2MzQzLCJqdGkiOiIwNjQyYTExY2IxNzg0MWVhODM2NzgxNDI1NjdiZTk1MCIsInVzZXJfaWQiOiIxMyJ9.l-oIUxSnIGRfYjNVgDI5gvz3HBy-YubHCuwK4pzT5_Y	2025-12-10 17:05:43.523846+00	2025-12-10 18:04:43+00	13	0642a11cb17841ea83678142567be950	\N
268	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1MzkwMTY0LCJpYXQiOjE3NjUzODY2MjQsImp0aSI6ImRiOTQ0YjU1ZGFiNDQ0MWE4NGU0NTY2MDlhNDEyOWY4IiwidXNlcl9pZCI6IjEzIn0.rV0YDAW_aSHE0W5NkiwKrmkQ2OrcAjIT2e9X6PGFcjA	2025-12-10 17:10:24.747124+00	2025-12-10 18:09:24+00	13	db944b55dab4441a84e456609a4129f8	\N
269	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM5MDE2NCwiaWF0IjoxNzY1Mzg2NjI0LCJqdGkiOiI3N2JiMzA5MTIyZjA0YmM3YWI2ZDJhNTNhZTZmNWExMSIsInVzZXJfaWQiOiIxMyJ9.EgH4IHAHcjgGFlWerbjhC6U-QAAYtIMp8r6g6eQoVaA	2025-12-10 17:10:24.777368+00	2025-12-10 18:09:24+00	13	77bb309122f04bc7ab6d2a53ae6f5a11	\N
270	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1MzkwNjkxLCJpYXQiOjE3NjUzODcxNTEsImp0aSI6ImM2ZTNhYmJiNDM5NTRhYzQ5MDU5YTIwNmVhMmVlNDI0IiwidXNlcl9pZCI6IjEzIn0.gupiWGAOATWMQanj3g-_2-LKwCycZMZgHRgn6FlaOE4	2025-12-10 17:19:11.257207+00	2025-12-10 18:18:11+00	13	c6e3abbb43954ac49059a206ea2ee424	\N
271	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM5MDY5MSwiaWF0IjoxNzY1Mzg3MTUxLCJqdGkiOiJmNjQ4ZmZiZmY0YjU0OTA0YWFiOWZmMTFmNTk4MGQ3NCIsInVzZXJfaWQiOiIxMyJ9.pVxnxe0TNQH7e6_4x4xop3OMPsp-WcOIXGbZtdRY708	2025-12-10 17:19:11.289645+00	2025-12-10 18:18:11+00	13	f648ffbff4b54904aab9ff11f5980d74	\N
272	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1MzkwODM5LCJpYXQiOjE3NjUzODcyOTksImp0aSI6ImRiYjRiMjEwOTEzZTQ2NjdiMzFjNmVhYzZjMTQzZDg2IiwidXNlcl9pZCI6IjEzIn0.2yMb_PvE8MSFvUxW_mMDJ0Qwi9i2FGKaULGq0ihNcUs	2025-12-10 17:21:39.693809+00	2025-12-10 18:20:39+00	13	dbb4b210913e4667b31c6eac6c143d86	\N
273	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM5MDgzOSwiaWF0IjoxNzY1Mzg3Mjk5LCJqdGkiOiI0YzdmYzczZmU2MGM0MDlkYWE4NjYxNGI2YzU0NzFkNyIsInVzZXJfaWQiOiIxMyJ9.ulP_IpupbKMYAKNvhnJPNpzP1i6mG3rzsyZDyUsGPOk	2025-12-10 17:21:39.722244+00	2025-12-10 18:20:39+00	13	4c7fc73fe60c409daa86614b6c5471d7	\N
274	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1MzkwOTY3LCJpYXQiOjE3NjUzODc0MjcsImp0aSI6ImUzMjc3ZDY0ZGNhZDRjZGE5OGVmOTE4OTE5YWNlZTEyIiwidXNlcl9pZCI6IjEzIn0.NU7PLikcOateTdCeQG29X0u6iEj9Y3RowiG9MA-S41A	2025-12-10 17:23:47.971058+00	2025-12-10 18:22:47+00	13	e3277d64dcad4cda98ef918919acee12	\N
275	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM5MDk2NywiaWF0IjoxNzY1Mzg3NDI3LCJqdGkiOiI4NjkwM2VkYmFkOGM0NzllYjJjNTFjNzA0MGY1Zjg5NCIsInVzZXJfaWQiOiIxMyJ9.YyfQgs_tyIBfMWv7WgF6fL_Ks4cRulH_NgJXa4fiiuI	2025-12-10 17:23:47.996568+00	2025-12-10 18:22:47+00	13	86903edbad8c479eb2c51c7040f5f894	\N
276	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1MzkxMjE3LCJpYXQiOjE3NjUzODc2NzcsImp0aSI6IjRlZDVmNmQyNzg2YjRkYjM5NGEwZGUzOTgwZGZmOWM2IiwidXNlcl9pZCI6IjEzIn0.7SRY160KJeg-FwGsF_IWhsXYBWYBL6VdZAIdtaHaz0M	2025-12-10 17:27:57.55119+00	2025-12-10 18:26:57+00	13	4ed5f6d2786b4db394a0de3980dff9c6	\N
277	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM5MTIxNywiaWF0IjoxNzY1Mzg3Njc3LCJqdGkiOiIzMzUzZDY0NDI0Y2I0MmU5OWEyYWQ5MDJhMGFjYmZiNCIsInVzZXJfaWQiOiIxMyJ9.l8XqqvB6Beiuqb-AOFbnnkO5669_RrW41hBAUKYxs1s	2025-12-10 17:27:57.593642+00	2025-12-10 18:26:57+00	13	3353d64424cb42e99a2ad902a0acbfb4	\N
278	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1MzkzMzQ2LCJpYXQiOjE3NjUzODk4MDYsImp0aSI6ImZhYzAyZDk1YWVmNDRlYTFhZjM0MTlmMDI0Y2E0OTNmIiwidXNlcl9pZCI6IjEzIn0.SR1y_5TrYRcE9MjaVLbtDErnpmcYeEYdUQ4wW7751hs	2025-12-10 18:03:26.664389+00	2025-12-10 19:02:26+00	13	fac02d95aef44ea1af3419f024ca493f	\N
279	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM5MzM0NiwiaWF0IjoxNzY1Mzg5ODA2LCJqdGkiOiJiMTlhOGY3ZTk1ZTc0ZGU3YjQ3ZWYyZDRlMTg2ZjNhMyIsInVzZXJfaWQiOiIxMyJ9.No3y_BeF-iqgsfxbKHghqltYgVlcZA8YvBCsBX8r3gs	2025-12-10 18:03:26.71139+00	2025-12-10 19:02:26+00	13	b19a8f7e95e74de7b47ef2d4e186f3a3	\N
280	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1Mzk0MjEwLCJpYXQiOjE3NjUzOTA2NzAsImp0aSI6ImIzYjI4YmZiODI0MjQxNGFhZTJmNTc5NGYwYTM0MWM3IiwidXNlcl9pZCI6IjEzIn0.70M74J42PdZet4qmtLVHPA5infX9DtGSfKbMFHlBX0s	2025-12-10 18:17:50.749381+00	2025-12-10 19:16:50+00	13	b3b28bfb8242414aae2f5794f0a341c7	\N
281	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTM5NDIxMCwiaWF0IjoxNzY1MzkwNjcwLCJqdGkiOiI1MGQ3OGVjOTQyYWQ0ZjdmOGEwNGE0M2ExNjllNTQyMyIsInVzZXJfaWQiOiIxMyJ9.iSLY3NjVWqloNjAUQC2ie9oJCFaW4-HuuniIDOmS5lA	2025-12-10 18:17:50.801334+00	2025-12-10 19:16:50+00	13	50d78ec942ad4f7f8a04a43a169e5423	\N
282	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1NDQyMDE1LCJpYXQiOjE3NjU0Mzg0NzUsImp0aSI6Ijc4MjYxMDdiZDcxNzQ4OGY5YTIxYmU2YTRkZTg2MjQ2IiwidXNlcl9pZCI6IjEzIn0.MLUn7fhsk0CYEAaYzJE4hJj4QrMiDavIeASW6oRE_Us	2025-12-11 07:34:35.23425+00	2025-12-11 08:33:35+00	13	7826107bd717488f9a21be6a4de86246	\N
283	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ0MjAxNSwiaWF0IjoxNzY1NDM4NDc1LCJqdGkiOiIxNmRjZTJjOWM5NDQ0YTdmOTI2NWUwZDI0Yzg3OWExYyIsInVzZXJfaWQiOiIxMyJ9.BcTcSV4T17z0353BlIy-IFxeJUWV8C2nmwHmUnPqd80	2025-12-11 07:34:35.325547+00	2025-12-11 08:33:35+00	13	16dce2c9c9444a7f9265e0d24c879a1c	\N
284	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ0NjkwOSwiaWF0IjoxNzY1NDQ2NjA5LCJqdGkiOiJmNGUyZGUzZjlkMzM0NTEyOGU4ZTg3ZDlhMjUxMmVjZiIsInVzZXJfaWQiOiIzOCJ9.5ujrsBoVYlm5ohIV8xzVOCBnQKhfEi-_N-swfEQX1lg	2025-12-11 09:50:09.716137+00	2025-12-11 09:55:09+00	38	f4e2de3f9d3345128e8e87d9a2512ecf	\N
285	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ1NDg5MiwiaWF0IjoxNzY1NDU0NTkyLCJqdGkiOiJlMGM5MjA3Zjc3ZTA0ZjVkYjY5Yzc1MDcyNDk4YjE4OSIsInVzZXJfaWQiOiIzOCJ9.-7-l4LpQKPkrqkX7fbycNif2z7zXFeFemkRUJDX58nw	2025-12-11 12:03:12.674683+00	2025-12-11 12:08:12+00	38	e0c9207f77e04f5db69c75072498b189	\N
286	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ1OTI1NiwiaWF0IjoxNzY1NDU4OTU2LCJqdGkiOiI2ZTliMjJkZDA5MmE0MWVkYjMxMDgyMjY1NmIwYzY1ZiIsInVzZXJfaWQiOiIxMyJ9.SRm4Osy_qy6tiXCbrCJ5LZbl33ZO8_v2w0IAJG9k2rY	2025-12-11 13:15:56.205173+00	2025-12-11 13:20:56+00	13	6e9b22dd092a41edb310822656b0c65f	\N
287	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ1OTkwMSwiaWF0IjoxNzY1NDU5NjAxLCJqdGkiOiIzNGVmZDliNTNhMTk0Y2FiYmUxYjBlMzQ5NmQ3M2VkNCIsInVzZXJfaWQiOiIxMyJ9.fuhYAZGpU4Fg3k6QFglx-Z5AkjaKv9bkn8GArRW-jdg	2025-12-11 13:26:41.110743+00	2025-12-11 13:31:41+00	13	34efd9b53a194cabbe1b0e3496d73ed4	\N
288	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ2MDI2MSwiaWF0IjoxNzY1NDU5OTYxLCJqdGkiOiI3ZjQ4ODFjN2RkZmI0N2RjOGZkNWQ5MDZkMTMzNDdhZiIsInVzZXJfaWQiOiIzOCJ9.DB3-3ZfV9lo1YTiSNeUjYjkBxJFUiyAVpo4IMm2W3X8	2025-12-11 13:32:41.714443+00	2025-12-11 13:37:41+00	38	7f4881c7ddfb47dc8fd5d906d13347af	\N
289	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ2MjE1NCwiaWF0IjoxNzY1NDYxODU0LCJqdGkiOiJhZDNlZWJmNGY3ZmE0ZGFlYjU5MmRhNzVlZDg4NjMwMSIsInVzZXJfaWQiOiIxMyJ9.3UUe3NYCs6dHjU_KA7vq4GFhN2jEE5zqHkCYIqq6NYY	2025-12-11 14:04:14.208493+00	2025-12-11 14:09:14+00	13	ad3eebf4f7fa4daeb592da75ed886301	\N
290	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ2NDU3MCwiaWF0IjoxNzY1NDY0MjcwLCJqdGkiOiI2YzFhNzk2OWM1NDI0ODkyYWYzYmJjOTE4MGVhOGIzNiIsInVzZXJfaWQiOiIxMyJ9.5W9tUrE1zsLZK7ubx83eau6n6jGXFTJqR-uUKT-STBs	2025-12-11 14:44:30.804767+00	2025-12-11 14:49:30+00	13	6c1a7969c5424892af3bbc9180ea8b36	\N
291	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ2Nzk4OCwiaWF0IjoxNzY1NDY3Njg4LCJqdGkiOiJhYjc4OGZkMTQ1ZTA0YWFlOTc4YjhjOWUxMjQ3NGZmNSIsInVzZXJfaWQiOiIxMyJ9.DUnh9xG0w7l6ESr0faDWSpOhnWLBFaU0tV0k2JDZI3s	2025-12-11 15:41:28.312745+00	2025-12-11 15:46:28+00	13	ab788fd145e04aae978b8c9e12474ff5	\N
292	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ3MTE0NSwiaWF0IjoxNzY1NDcwODQ1LCJqdGkiOiJjNjQ4ODM4YjBmN2Y0ZTlmOGNkYjliNWM5MDczNjVlNSIsInVzZXJfaWQiOiIxMyJ9.E1Ibo8e3poJjT1_LxTGntmpnItoz6oC_aI114-lP_c4	2025-12-11 16:34:05.129691+00	2025-12-11 16:39:05+00	13	c648838b0f7f4e9f8cdb9b5c907365e5	\N
293	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1NDg5MTc2LCJpYXQiOjE3NjU0ODU2MzYsImp0aSI6ImNlODVlZGViNWU2YzQyN2U4MTUzYjRmODJkMmFlNzQxIiwidXNlcl9pZCI6IjEzIn0.XzDto5heUi36OYk7vvZFBwkZ9TUgf-JpH_EfCkMyapo	2025-12-11 20:40:36.60482+00	2025-12-11 21:39:36+00	13	ce85edeb5e6c427e8153b4f82d2ae741	\N
294	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ4OTE3NiwiaWF0IjoxNzY1NDg1NjM2LCJqdGkiOiI3OWQxNDQ4MWVjYTA0YWEwYjFjMGY1ZTU2NGVmOTcxYyIsInVzZXJfaWQiOiIxMyJ9.QSwv0lNF3qBpeQMULK23bbOLcHIUBTPNMJTnjNhplqQ	2025-12-11 20:40:36.797286+00	2025-12-11 21:39:36+00	13	79d14481eca04aa0b1c0f5e564ef971c	\N
295	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1NDg5MjUwLCJpYXQiOjE3NjU0ODU3MTAsImp0aSI6IjJlYmZhZDcyZThlZDQwZDg5Y2NkY2U3YzVkY2UzNTUxIiwidXNlcl9pZCI6IjEzIn0.D4oY8LsjHsC1m_W7jIFAU3bPxeg-llyHEW0MRz5QiDQ	2025-12-11 20:41:50.378102+00	2025-12-11 21:40:50+00	13	2ebfad72e8ed40d89ccdce7c5dce3551	\N
296	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTQ4OTI1MCwiaWF0IjoxNzY1NDg1NzEwLCJqdGkiOiJhZDA2OWRkMjg5MGY0ZGVmYjUwYzQ0YTU1ZDU5ZDcyNiIsInVzZXJfaWQiOiIxMyJ9.x_4etcs2ON3nh5aLj5tUw1CgjrzaDYFTnD5rRJkxYaA	2025-12-11 20:41:50.409843+00	2025-12-11 21:40:50+00	13	ad069dd2890f4defb50c44a55d59d726	\N
297	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTU0MTU3MCwiaWF0IjoxNzY1NTQxMjcwLCJqdGkiOiIzYzkyYTBlZjJmOTY0OTAzOTNiMjhhYWUwNGI1MGEyZCIsInVzZXJfaWQiOiIzOCJ9.-0EHOQug1TTAExxlPvrnQk7jq5o0fQXkFSqejMwD2ww	2025-12-12 12:07:50.137855+00	2025-12-12 12:12:50+00	38	3c92a0ef2f96490393b28aae04b50a2d	\N
298	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTU0MTcyOSwiaWF0IjoxNzY1NTQxNDI5LCJqdGkiOiI0MzRkMjkzNWVmMzE0YzVhYWJjNWZjNWRiMzliZmE2NCIsInVzZXJfaWQiOiIzOCJ9.Wc87F5Wo67PGDFYwk7_RkM39Ja9rSeD3kmXPPpzWOpM	2025-12-12 12:10:29.741872+00	2025-12-12 12:15:29+00	38	434d2935ef314c5aabc5fc5db39bfa64	\N
299	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1NjE1NjI0LCJpYXQiOjE3NjU2MTIwODQsImp0aSI6Ijk3NTdjZGMyMzZhOTQzZTNhNWVmN2Y5ZWFiYzdjODIxIiwidXNlcl9pZCI6IjEzIn0.4DwAY7YonkGglEqv4QvUyYXrKzMrD5fI2_uPmznMtWc	2025-12-13 07:48:04.935314+00	2025-12-13 08:47:04+00	13	9757cdc236a943e3a5ef7f9eabc7c821	\N
300	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTYxNTYyNSwiaWF0IjoxNzY1NjEyMDg1LCJqdGkiOiIyZmIwMDllZWFjYzM0Mzg0OGMwNjA3OTgwY2RmYzAwYSIsInVzZXJfaWQiOiIxMyJ9.0m23Os0bgbey_KS0H_pot2pedcEcLMPw38FM9vYev7o	2025-12-13 07:48:05.015133+00	2025-12-13 08:47:05+00	13	2fb009eeacc343848c0607980cdfc00a	\N
301	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1ODIxNTgyLCJpYXQiOjE3NjU4MTgwNDIsImp0aSI6Ijc5M2U4MTJmOTcyNzRjOGRiNjU5NmQ1ZDBkYmEyYmQxIiwidXNlcl9pZCI6IjM0In0.9X5wXtdRKGH6B7XfY5U2Ad-gPL9173IN8rPUCb7FKi4	2025-12-15 17:00:42.436159+00	2025-12-15 17:59:42+00	34	793e812f97274c8db6596d5d0dba2bd1	\N
302	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTgyMTU4MiwiaWF0IjoxNzY1ODE4MDQyLCJqdGkiOiI3Mzc4MTYxNmZhYjE0OGFkYjA5OWIzMjQyZjk5NjhlZCIsInVzZXJfaWQiOiIzNCJ9.AXRNNVulL0HG1g4x9PiTxvPeya9AICVJjm0GnQudASM	2025-12-15 17:00:42.627574+00	2025-12-15 17:59:42+00	34	73781616fab148adb099b3242f9968ed	\N
303	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1ODIxNjA1LCJpYXQiOjE3NjU4MTgwNjUsImp0aSI6IjQzYzI4M2UzMzE1YzRkNDdhNTQ0ODhlZWQzYTI5YzBiIiwidXNlcl9pZCI6IjM0In0.GW8aqEeWFNs-ykwKNySWCoKzoTQWf3CU_R6-Mm0q98s	2025-12-15 17:01:05.530272+00	2025-12-15 18:00:05+00	34	43c283e3315c4d47a54488eed3a29c0b	\N
304	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTgyMTYwNSwiaWF0IjoxNzY1ODE4MDY1LCJqdGkiOiJkMGJlYWY5YTQyZjk0YzRhYmY2MjUzNTNiMDNkZDFiMyIsInVzZXJfaWQiOiIzNCJ9.RVNV5rJZg2-2xxBHEYSUKrDVx2Tq1tbEKZKzWG1BXuE	2025-12-15 17:01:05.55922+00	2025-12-15 18:00:05+00	34	d0beaf9a42f94c4abf625353b03dd1b3	\N
305	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY1ODIxNzAzLCJpYXQiOjE3NjU4MTgxNjMsImp0aSI6ImYwOTYwOGNjMGEwNTQ2NDY5ZDc3YjA2Y2E5MTcyMWMyIiwidXNlcl9pZCI6IjM0In0.a5fuc-DzTqWT2QSVfPn7foWMyMxNPwI6eeBMI6jXCi4	2025-12-15 17:02:43.743269+00	2025-12-15 18:01:43+00	34	f09608cc0a0546469d77b06ca91721c2	\N
306	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTgyMTcwMywiaWF0IjoxNzY1ODE4MTYzLCJqdGkiOiIyYWM5N2QxZjY2NmE0ZTM1YmNhMGQzYWJjNDEwYjRiNCIsInVzZXJfaWQiOiIzNCJ9.E4EEfFXrglCLc7oFzss8AfSHs9w8IvBSN07atQZce4I	2025-12-15 17:02:43.773597+00	2025-12-15 18:01:43+00	34	2ac97d1f666a4e35bca0d3abc410b4b4	\N
307	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTg4MTgzNSwiaWF0IjoxNzY1ODgxNTM1LCJqdGkiOiI5MDIyNWFmYjk3YWY0NmUzYTRmY2QwOTEyNDYzZWI2YyIsInVzZXJfaWQiOiIzOSJ9.gaQQ9CEvqab83no0OL5HxlpQVhhrRz6GWIN8J0Z-UqU	2025-12-16 10:38:55.964411+00	2025-12-16 10:43:55+00	39	90225afb97af46e3a4fcd0912463eb6c	\N
308	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTk2OTM2NSwiaWF0IjoxNzY1OTY5MDY1LCJqdGkiOiJmNjc1YTk2ZjQ4Njg0NmVjYmQ5NjQ0NTg5NDAwNzIzNyIsInVzZXJfaWQiOiI0MCJ9.H9qCImX4GWfdmaxjx1ifMK49BT1NJTlVq0VWrgjMegw	2025-12-17 10:57:45.824051+00	2025-12-17 11:02:45+00	40	f675a96f486846ecbd96445894007237	\N
309	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTk2OTQyMCwiaWF0IjoxNzY1OTY5MTIwLCJqdGkiOiIxMDlhYWVkY2NhNDE0NWIyOWM1YzFiNjNmYTQ3OTY2ZSIsInVzZXJfaWQiOiI0MCJ9.Wip-4FZxBQkPrnM9tvF5pwIzEtspYIfF5vRvkKirlRc	2025-12-17 10:58:40.215841+00	2025-12-17 11:03:40+00	40	109aaedcca4145b29c5c1b63fa47966e	\N
310	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NTk3MDg3NCwiaWF0IjoxNzY1OTcwNTc0LCJqdGkiOiJmZmM1MWY5OGZiODA0MmYzOTdkNTE0NWY5YWRjODUwYSIsInVzZXJfaWQiOiI0MCJ9.n7mN36DcdIcwsrd9Gr5EXP6pv4euXOLX_KyRmbA0mIE	2025-12-17 11:22:54.730951+00	2025-12-17 11:27:54+00	40	ffc51f98fb8042f397d5145f9adc850a	\N
311	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjA1NjM5OSwiaWF0IjoxNzY2MDU2MDk5LCJqdGkiOiJjMmE0N2IyODAyMmE0OTY5ODlmZWYxZjhjMDI1NGE1YiIsInVzZXJfaWQiOiIxMyJ9.dJLnLuYaryXSBeGjzDXYiZanJMIK6oI871XorpZWYqU	2025-12-18 11:08:19.894031+00	2025-12-18 11:13:19+00	13	c2a47b28022a496989fef1f8c0254a5b	\N
312	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjA3MDcyOCwiaWF0IjoxNzY2MDcwNDI4LCJqdGkiOiIyM2ZiNTVjMDZhMWY0OGU2OGI0MjJlMjRkZWVlYTM2MyIsInVzZXJfaWQiOiIxMyJ9.QJD-mdQ8h6kB0O87x7yQTvGiywqWwcEbH4Kvw2eQY2I	2025-12-18 15:07:08.93663+00	2025-12-18 15:12:08+00	13	23fb55c06a1f48e68b422e24deeea363	\N
313	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjA3MTEyMywiaWF0IjoxNzY2MDcwODIzLCJqdGkiOiI5ZDI1YWFmMjc3M2M0YTY4YTk2NTU1NjYwMjdlMjlmMCIsInVzZXJfaWQiOiIxMyJ9.LNb6-OIFzSRiWlnEmavSdtrdvQ15Ymv58E5JXLEWSrQ	2025-12-18 15:13:43.238711+00	2025-12-18 15:18:43+00	13	9d25aaf2773c4a68a9655566027e29f0	\N
314	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjA3MTQzMiwiaWF0IjoxNzY2MDcxMTMyLCJqdGkiOiI3MmVlZmZjMWFiYWU0MjE1OGNhNTk1Yzc2NjkyNmFlZiIsInVzZXJfaWQiOiIxMyJ9.1hubCwcbF20ogrp3xvYJLPVnXkN2R2JqbsAF0cU3F9g	2025-12-18 15:18:52.233915+00	2025-12-18 15:23:52+00	13	72eeffc1abae42158ca595c766926aef	\N
315	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjA3MzQ3NCwiaWF0IjoxNzY2MDczMTc0LCJqdGkiOiJhZjYzNTk2MGMxNzQ0ZWUyODZjNjkyZjRkNWIzNDA1NiIsInVzZXJfaWQiOiIxMyJ9.MmODY14eMBNVpcYcSO01WmlRZaYxnOWNhUeAfTA5ja8	2025-12-18 15:52:54.732541+00	2025-12-18 15:57:54+00	13	af635960c1744ee286c692f4d5b34056	\N
316	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjA3NjY1NywiaWF0IjoxNzY2MDc2MzU3LCJqdGkiOiIzOWQ2MGY3ZWVmMWY0MWM2OWUzZGQxOGZlZmEzYjNlNiIsInVzZXJfaWQiOiIxMyJ9.vA-u0clR1gYroRdiacQ6SBLwhE-nkNXSkjzX3CY2_0Y	2025-12-18 16:45:57.959963+00	2025-12-18 16:50:57+00	13	39d60f7eef1f41c69e3dd18fefa3b3e6	\N
317	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjA3OTA2OCwiaWF0IjoxNzY2MDc4NzY4LCJqdGkiOiJiYmVhZWU3YmU0MWI0NGU0ODU4ODkwZGQ0MDkwYTJjNiIsInVzZXJfaWQiOiIxMyJ9.tQ1LvY_9-uByE1pbe4OHncR5Cjhloif9T-8wH3T5iDQ	2025-12-18 17:26:08.155884+00	2025-12-18 17:31:08+00	13	bbeaee7be41b44e4858890dd4090a2c6	\N
318	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjA4MjU5MCwiaWF0IjoxNzY2MDgyMjkwLCJqdGkiOiI4ODg1NmJlYzNhZDk0YzFkYjE2MDIwMjczZTI3ZTM3OSIsInVzZXJfaWQiOiIxMyJ9.delJS_ef0It2HXhGlG_WLK0BGWLe8rx_Rahy83kgsa0	2025-12-18 18:24:50.464375+00	2025-12-18 18:29:50+00	13	88856bec3ad94c1db16020273e27e379	\N
319	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjA4NTIxMSwiaWF0IjoxNzY2MDg0OTExLCJqdGkiOiIwNTM1MDgzMmIxNjE0NDg2YmZhMGViZjc0MjhmYWJhZiIsInVzZXJfaWQiOiIxMyJ9.eFExjYqym6FxFQEGB53usr07HTZwhLyEYszumLRKLLc	2025-12-18 19:08:31.004844+00	2025-12-18 19:13:31+00	13	05350832b1614486bfa0ebf7428fabaf	\N
320	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjA5NDY4NywiaWF0IjoxNzY2MDk0Mzg3LCJqdGkiOiIwYTg4ZTlkM2IxYmU0MTBlOTA3YjBjMDYyMjU1ODBhNSIsInVzZXJfaWQiOiI0MSJ9.QojvJzINdiDrQmT_766jg9iYXsrMXzuQrmePH0DSV0E	2025-12-18 21:46:27.788919+00	2025-12-18 21:51:27+00	41	0a88e9d3b1be410e907b0c06225580a5	\N
321	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjEzODc5MywiaWF0IjoxNzY2MTM4NDkzLCJqdGkiOiJlM2Q1NTc1MWZhZWQ0NTM2YTdhMWY0YTE4NDNiYWZhMyIsInVzZXJfaWQiOiIxMyJ9.88nAeDvWkek9AioZ_UIURICfUjKBpXyoTl2xPFXAukE	2025-12-19 10:01:33.805369+00	2025-12-19 10:06:33+00	13	e3d55751faed4536a7a1f4a1843bafa3	\N
322	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjEzODg1MSwiaWF0IjoxNzY2MTM4NTUxLCJqdGkiOiJlZmRmZDQ0MTI3NmU0M2Y0OGRkNGY5Y2RhMjFkNGUzMiIsInVzZXJfaWQiOiI0MSJ9.5WPQENsTfqLJaCxt__SHn6-XjU-Xi9GukNaImicNCOU	2025-12-19 10:02:31.501263+00	2025-12-19 10:07:31+00	41	efdfd441276e43f48dd4f9cda21d4e32	\N
323	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjE0MTQ2NSwiaWF0IjoxNzY2MTQxMTY1LCJqdGkiOiI2OTQxY2ZmNzc2MzQ0ZGJjYTk5NjNiY2Y5NDI0NTNmYyIsInVzZXJfaWQiOiIxMyJ9.YkeC08SnVbs99fTYqPUDz8M3_spDIJRuarUvOWoI5CM	2025-12-19 10:46:05.323366+00	2025-12-19 10:51:05+00	13	6941cff776344dbca9963bcf942453fc	\N
324	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjE0MTU3OCwiaWF0IjoxNzY2MTQxMjc4LCJqdGkiOiJhNzAxZDA3NTc2YWM0YmI5ODU3NWFmMDJiNzQ5NTNkMyIsInVzZXJfaWQiOiI0MSJ9.JXlnAxD4ItnctWK_G_Qz-j3SkV4eTXv-r-x08hOHb6M	2025-12-19 10:47:58.520173+00	2025-12-19 10:52:58+00	41	a701d07576ac4bb98575af02b74953d3	\N
325	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjE0NTI5MywiaWF0IjoxNzY2MTQ0OTkzLCJqdGkiOiI1N2UxNjAwMjBhMGY0ZWJjOGYxMWNlYmI0NGMxOTcyZCIsInVzZXJfaWQiOiI0MSJ9.sXcblE_yUPbY9NF78KytYKho1M8QL5NXful4q4324dM	2025-12-19 11:49:53.328731+00	2025-12-19 11:54:53+00	41	57e160020a0f4ebc8f11cebb44c1972d	\N
326	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjE0NzUyOSwiaWF0IjoxNzY2MTQ3MjI5LCJqdGkiOiJlNGUxZjg3N2IwOWU0NTljOGZmMjM1NThiMjc0ZDVlYyIsInVzZXJfaWQiOiI0MSJ9.DR1Nk9Io5eLtGnOULz4yxFFNJdl0pmssTtAfnf9cpbg	2025-12-19 12:27:09.846695+00	2025-12-19 12:32:09+00	41	e4e1f877b09e459c8ff23558b274d5ec	\N
327	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjE1MDMxOCwiaWF0IjoxNzY2MTUwMDE4LCJqdGkiOiI5YzA1NTFkZTJhMjM0ZTU0YWIxNDJhYzkyY2JmMmY1OSIsInVzZXJfaWQiOiIxMyJ9.2CVa-2-BxrlEQ2xLnC1gp7YZ72pyquc5xs3RUuESrH4	2025-12-19 13:13:38.550603+00	2025-12-19 13:18:38+00	13	9c0551de2a234e54ab142ac92cbf2f59	\N
328	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2MTU2ODc2LCJpYXQiOjE3NjYxNTMzMzYsImp0aSI6IjEzZTllZmM2NjU4ZTQ1NmM4ZDJkZTgzMTkyYmNiZTFiIiwidXNlcl9pZCI6IjEzIn0.hQm59p6YuOdo8eYS8CvHf2X0eQGhjm4VjDl3LrgbU0E	2025-12-19 14:08:56.715596+00	2025-12-19 15:07:56+00	13	13e9efc6658e456c8d2de83192bcbe1b	\N
329	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjE1Njg3NiwiaWF0IjoxNzY2MTUzMzM2LCJqdGkiOiJlZTU3OTM4MGYwN2U0YmE4YjM4Y2MyMDAwNWQxYmI4MSIsInVzZXJfaWQiOiIxMyJ9.uDp7q5hAF_ih0vSl_ka4URTTvMscTpKA-KJ4tjF6JQM	2025-12-19 14:08:56.779408+00	2025-12-19 15:07:56+00	13	ee579380f07e4ba8b38cc20005d1bb81	\N
330	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjE1Mzg2OSwiaWF0IjoxNzY2MTUzNTY5LCJqdGkiOiI4YjM2OGRmNTAzZjI0M2ZiYjNhZjMyMDQ5ZWMwYmFhMSIsInVzZXJfaWQiOiI0MSJ9.Jve1gr1OtTRX5__tV2zFNydngFtUXlrh44UO5__wGcc	2025-12-19 14:12:49.444207+00	2025-12-19 14:17:49+00	41	8b368df503f243fbb3af32049ec0baa1	\N
331	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjU5MjMwOCwiaWF0IjoxNzY2NTkyMDA4LCJqdGkiOiJlYmM5MTA2YzEyNmQ0ZjFiYTY1MWZjZmRiYTdhNjhhNiIsInVzZXJfaWQiOiIxMyJ9.E8UoLRfALU34S1M6a17TFjvCEsmq0sK2J8RMT_f-GFY	2025-12-24 16:00:08.212975+00	2025-12-24 16:05:08+00	13	ebc9106c126d4f1ba651fcfdba7a68a6	\N
332	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2NzQwOTM0LCJpYXQiOjE3NjY3MzczOTQsImp0aSI6IjI3ZGMyOGEwYWQ1NTRmYzRiMGIzMjZjYTU5MDYxOWI2IiwidXNlcl9pZCI6IjEzIn0.yrElLQpVtWUfgsh_lF8AxxYoutcKnjRHvYxHqhtk70g	2025-12-26 08:23:14.597289+00	2025-12-26 09:22:14+00	13	27dc28a0ad554fc4b0b326ca590619b6	\N
333	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc0MDkzNCwiaWF0IjoxNzY2NzM3Mzk0LCJqdGkiOiIwNTYwMDBhZjRhYTI0YTlkYWVjODAwZjcwNGUyMjBiMyIsInVzZXJfaWQiOiIxMyJ9.yf-jWQt2HzQQBMx_VMaYh2zWm9kDD1MoeWwAWIN5rr8	2025-12-26 08:23:14.872231+00	2025-12-26 09:22:14+00	13	056000af4aa24a9daec800f704e220b3	\N
334	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjczNzgyMSwiaWF0IjoxNzY2NzM3NTIxLCJqdGkiOiI4ZTlhYTVjMTZiZDE0MWVlYmI1ZDRlODZkZjZlODg1YSIsInVzZXJfaWQiOiIxMyJ9.Zvu3RpdZcIaXSpR6iae4RxYv7TcZp0_vbEuVQgkmA0E	2025-12-26 08:25:21.402725+00	2025-12-26 08:30:21+00	13	8e9aa5c16bd141eebb5d4e86df6e885a	\N
335	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc0MTA0NCwiaWF0IjoxNzY2NzQwNzQ0LCJqdGkiOiJkZDQ3N2IxYzViMWM0MTMyODMxMTEzZTg3YTZmMDhiNCIsInVzZXJfaWQiOiIxMyJ9.bDT3C1WMWnGSHfFFdWmnLAjz3mdfkx9ygSBjfd4_z5w	2025-12-26 09:19:04.702649+00	2025-12-26 09:24:04+00	13	dd477b1c5b1c4132831113e87a6f08b4	\N
336	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc0NDA3MCwiaWF0IjoxNzY2NzQzNzcwLCJqdGkiOiI3ZmI4ZDhmMDA5YTI0NDc1YTQ3NmRhZmVhYjM4ZjY5YSIsInVzZXJfaWQiOiIxMyJ9.j86L9eYbDcp4ROq45WYcdUfoVhXM9UPf8bMisMaSWTk	2025-12-26 10:09:30.997365+00	2025-12-26 10:14:30+00	13	7fb8d8f009a24475a476dafeab38f69a	\N
337	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2NzQ4NTk5LCJpYXQiOjE3NjY3NDUwNTksImp0aSI6IjYwMmUzNTJhMWRlYTQ4YzY5NGE2MzkxNDhmYWQ1ZjhkIiwidXNlcl9pZCI6IjEzIn0.EEd9Lctos2kOvEbc5F_ELvpzKrEgGPYsExHMXmGBICk	2025-12-26 10:30:59.664408+00	2025-12-26 11:29:59+00	13	602e352a1dea48c694a639148fad5f8d	\N
338	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc0ODU5OSwiaWF0IjoxNzY2NzQ1MDU5LCJqdGkiOiJlZTIwNTY2NGM0ZTI0NTYwYTYzMjVhMWIzNWY0ODYzNiIsInVzZXJfaWQiOiIxMyJ9.8SuoGEizh-wRYm4XF_tEWuWxuZAprTSij92fJngIXRI	2025-12-26 10:30:59.723864+00	2025-12-26 11:29:59+00	13	ee205664c4e24560a6325a1b35f48636	\N
339	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc0NTk4OSwiaWF0IjoxNzY2NzQ1Njg5LCJqdGkiOiI0YzI5ZjM4ZWZiMzM0MjBjOTMzNTJkNjdkYTIyYzUyNiIsInVzZXJfaWQiOiIxMyJ9.u0P2sS_UMcSMwj4UBPDl3DOoV0mo-NmJfjokpylJkoQ	2025-12-26 10:41:29.995625+00	2025-12-26 10:46:29+00	13	4c29f38efb33420c93352d67da22c526	\N
340	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc0Njk4NywiaWF0IjoxNzY2NzQ2Njg3LCJqdGkiOiIzZDZlZjJjM2NlZTQ0ZGUzOTEyYmRjMzg0ZjczMTFiYiIsInVzZXJfaWQiOiIxMyJ9.p-l8VNyYaOQpdBumuV4dIhrG5XHM7GWiLSRI_lDRg8s	2025-12-26 10:58:07.297656+00	2025-12-26 11:03:07+00	13	3d6ef2c3cee44de3912bdc384f7311bb	\N
341	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc2Mjk1NywiaWF0IjoxNzY2NzYyNjU3LCJqdGkiOiIwMzY2ZjE3ZTU5Y2M0MmRmYjMyOTJlZjE5ZTY5N2MzOSIsInVzZXJfaWQiOiIxMyJ9.GOZcNpa-YeWTATdUk3auSHIAOVQ5uUvneLh0gTP46B4	2025-12-26 15:24:17.78876+00	2025-12-26 15:29:17+00	13	0366f17e59cc42dfb3292ef19e697c39	\N
342	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc2MzY5NywiaWF0IjoxNzY2NzYzMzk3LCJqdGkiOiIyMzhlYzM2ZTEzNmM0YjhlOTY5NTE3MjU1N2QxMmI1OCIsInVzZXJfaWQiOiIxMyJ9.mxD_952-5PaOl3jW8Ku17c5X3DBrt1r_TNLDBD3Y3y4	2025-12-26 15:36:37.689002+00	2025-12-26 15:41:37+00	13	238ec36e136c4b8e9695172557d12b58	\N
343	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc2Mzg1NiwiaWF0IjoxNzY2NzYzNTU2LCJqdGkiOiI3ZjZmMjRmOGI3Njc0OTc1ODVlMDZiYTY5MGMxNDRiOCIsInVzZXJfaWQiOiIxMyJ9.xyrAXkwyKDP9mBCLolCf03eVTpjmP2gJhsF7rSfP5tE	2025-12-26 15:39:16.483664+00	2025-12-26 15:44:16+00	13	7f6f24f8b767497585e06ba690c144b8	\N
344	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc2NjE0OSwiaWF0IjoxNzY2NzY1ODQ5LCJqdGkiOiI0MTY0NDExYWU5MDg0ZWZlOWY4ZGMyMmYyYjExNzU3MCIsInVzZXJfaWQiOiIxMyJ9.Nfy5LPpkU71sJLGtJkTQVRM7MXaDONQZuexJeHYW7-I	2025-12-26 16:17:29.780957+00	2025-12-26 16:22:29+00	13	4164411ae9084efe9f8dc22f2b117570	\N
345	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc3MDkxMCwiaWF0IjoxNzY2NzcwNjEwLCJqdGkiOiI5MTIwNDcxOGNhNGM0Yzk2ODViNjQ4ZTUyZjdjZDVkOCIsInVzZXJfaWQiOiIxMyJ9.PSNh8psjawcB-QsvA3EBOkXD-8lydfNYV_eNc8MDnhg	2025-12-26 17:36:50.578067+00	2025-12-26 17:41:50+00	13	91204718ca4c4c9685b648e52f7cd5d8	\N
346	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc3NTgxMCwiaWF0IjoxNzY2Nzc1NTEwLCJqdGkiOiIwYWFmYTVhY2ZmZGQ0Nzk2ODIwMjZiMGViYzQ5ODcwZCIsInVzZXJfaWQiOiIxMyJ9.E93lSP8RxchiSLH5KIL0PZl4zAnGqHkD199fG-kafjI	2025-12-26 18:58:30.377141+00	2025-12-26 19:03:30+00	13	0aafa5acffdd479682026b0ebc49870d	\N
347	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2Nzg2Mzc4LCJpYXQiOjE3NjY3ODI4MzgsImp0aSI6ImI4NmZkNTA1OGRjNjRiMjliMzQ2NWY5NjI1MTI2NWQ0IiwidXNlcl9pZCI6IjEzIn0.jHsNVyFL3ail23Rd1xhSBrtaXMm65rdkHxeeQLakdiI	2025-12-26 21:00:38.96792+00	2025-12-26 21:59:38+00	13	b86fd5058dc64b29b3465f96251265d4	\N
348	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc4NjM3OSwiaWF0IjoxNzY2NzgyODM5LCJqdGkiOiIxMzUwN2EyN2MwYzI0M2ZlYTIzNzIzOTliNDQzMWI2NCIsInVzZXJfaWQiOiIxMyJ9.zPazYnpHDGyegqYNFF1iJdoDY63ZbAB8n41wmTLYSlk	2025-12-26 21:00:39.035174+00	2025-12-26 21:59:39+00	13	13507a27c0c243fea2372399b4431b64	\N
349	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc4MzU0NywiaWF0IjoxNzY2NzgzMjQ3LCJqdGkiOiJhYTkzMTBmNDg3N2I0NjFlODcwMzdiMDdiZDcyNGUxYyIsInVzZXJfaWQiOiI0MiJ9.JF2P-eyvrMWsjnkSSME-bqMBkNCQktDitBDuZWkrVlg	2025-12-26 21:07:27.378133+00	2025-12-26 21:12:27+00	42	aa9310f4877b461e87037b07bd724e1c	\N
350	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2Nzg2ODA4LCJpYXQiOjE3NjY3ODMyNjgsImp0aSI6ImY1YWVjMTQ0M2VkZjRmMTJhZDA3MGY1MDJjZGQzMDE4IiwidXNlcl9pZCI6IjQyIn0.sSSXnaY_S6OVVGFM-70qWJMXpQyk1OQmDyKoPFW8DJU	2025-12-26 21:07:48.170086+00	2025-12-26 22:06:48+00	42	f5aec1443edf4f12ad070f502cdd3018	\N
351	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc4NjgwOCwiaWF0IjoxNzY2NzgzMjY4LCJqdGkiOiI5MTI3MjcwNTA2NTY0OGYwYmZkZjgxM2FiNGFhM2JkMiIsInVzZXJfaWQiOiI0MiJ9._GFKnUc5L2Bk10MEO83OcXL4znFMsWIt-bYie-qpaY4	2025-12-26 21:07:48.200643+00	2025-12-26 22:06:48+00	42	91272705065648f0bfdf813ab4aa3bd2	\N
352	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2Nzg2ODQ5LCJpYXQiOjE3NjY3ODMzMDksImp0aSI6IjgzYWRhOWEzNTk0MTRkYTliMDViZjIzZmQ2YWVkNjc3IiwidXNlcl9pZCI6IjQyIn0.yAT2HXPqR3WlQbK_s96jCCKFltzVxUXFCtAahyaAm_c	2025-12-26 21:08:29.041385+00	2025-12-26 22:07:29+00	42	83ada9a359414da9b05bf23fd6aed677	\N
353	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc4Njg0OSwiaWF0IjoxNzY2NzgzMzA5LCJqdGkiOiI3NzAyYTdjMzU5Zjk0MWJjYWVmZjhhYTJiYjJmMTllNCIsInVzZXJfaWQiOiI0MiJ9.rLbrB3bBI17HcbjQIUbsOR08zQF7bDReh-k0RUOHN3A	2025-12-26 21:08:29.067493+00	2025-12-26 22:07:29+00	42	7702a7c359f941bcaeff8aa2bb2f19e4	\N
354	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2Nzg3MDc5LCJpYXQiOjE3NjY3ODM1MzksImp0aSI6IjdiNGJjNGFlMDNmYTQzNzk5YTNlZGM3Njg1NDI0MjQ3IiwidXNlcl9pZCI6IjQyIn0.ErTWpEZmrV8jv379GhBkBoLVVt-NlHjd33bMvSEAf4s	2025-12-26 21:12:19.426812+00	2025-12-26 22:11:19+00	42	7b4bc4ae03fa43799a3edc7685424247	\N
355	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc4NzA3OSwiaWF0IjoxNzY2NzgzNTM5LCJqdGkiOiJmOGEwZTcxZGYwMTk0YzdkOTcwN2JmOGQ0OTUxNzQyNCIsInVzZXJfaWQiOiI0MiJ9.XdjAXUpd_nZyJlLJhc2roGMb_buO0KH5UpmUn8lw7zc	2025-12-26 21:12:19.455481+00	2025-12-26 22:11:19+00	42	f8a0e71df0194c7d9707bf8d49517424	\N
356	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc4NTE1NCwiaWF0IjoxNzY2Nzg0ODU0LCJqdGkiOiJmYTY2YzcwNDBkOGU0OTk4ODE5YTQwNzdhMjQ3NWEyYiIsInVzZXJfaWQiOiIxMyJ9.jW30b1MyjiIxtszSDanHGZ_0pe7NUQBHZcdYjPSpHto	2025-12-26 21:34:14.477858+00	2025-12-26 21:39:14+00	13	fa66c7040d8e4998819a4077a2475a2b	\N
357	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2Nzg5MzEwLCJpYXQiOjE3NjY3ODU3NzAsImp0aSI6ImUxNDY3ZWY3M2JjNjQ5ZTNiNmRlN2MxYmRiZWQ3NGRlIiwidXNlcl9pZCI6IjEzIn0.nI9RXhw_C2tIPg6rbAo3AOvI61vMmOjfOki5Gz6pQsE	2025-12-26 21:49:30.677843+00	2025-12-26 22:48:30+00	13	e1467ef73bc649e3b6de7c1bdbed74de	\N
358	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc4OTMxMCwiaWF0IjoxNzY2Nzg1NzcwLCJqdGkiOiI5YjllOWJhOTZkZjU0ZTliYjRmMTdmMjNlMzgwZTZjMiIsInVzZXJfaWQiOiIxMyJ9.cKchP1Nan3iD1qAr7isvjmdtlKePawdLkQNcbAk9esE	2025-12-26 21:49:30.721639+00	2025-12-26 22:48:30+00	13	9b9e9ba96df54e9bb4f17f23e380e6c2	\N
359	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc4NjMyOCwiaWF0IjoxNzY2Nzg2MDI4LCJqdGkiOiJjMWVlMTY4MjMwNmU0Zjg2YjkwODExODA0MzVhMDljOSIsInVzZXJfaWQiOiIxMyJ9.5QJWVMoDrGnE4yHgQyA_k8zMxkmfCa5FTTeXmRJCuj8	2025-12-26 21:53:48.671442+00	2025-12-26 21:58:48+00	13	c1ee1682306e4f86b9081180435a09c9	\N
360	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc4OTQxMywiaWF0IjoxNzY2Nzg5MTEzLCJqdGkiOiIzMTI1NDZiMzQ1YjY0ZjhjYTE3OTViMzIxNzAzZDM4YiIsInVzZXJfaWQiOiI0MyJ9.kQLSIg3eSEB8Lggkynkhg0fNJjv_H-Lj40bAWug9TI8	2025-12-26 22:45:13.839534+00	2025-12-26 22:50:13+00	43	312546b345b64f8ca1795b321703d38b	\N
361	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2NzkyOTE1LCJpYXQiOjE3NjY3ODkzNzUsImp0aSI6IjhkYmNhNDlmOWVhYTQ0MzI4MzQxMWQ5YzY1OWU2MzViIiwidXNlcl9pZCI6IjEzIn0.LEl8-Q6Xsxg1LmCLNU79IatO0cDSbGAE4pjcot4fe-o	2025-12-26 22:49:35.19166+00	2025-12-26 23:48:35+00	13	8dbca49f9eaa443283411d9c659e635b	\N
362	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc5MjkxNSwiaWF0IjoxNzY2Nzg5Mzc1LCJqdGkiOiI2Yzk5M2VlOTUyMjE0NmQyOWM0OWEzZjQ2N2E2ZjE2OCIsInVzZXJfaWQiOiIxMyJ9.vnvtZJFI812dmd2Th5nXcAA5wj4mgdYPO5BgS0kKRp4	2025-12-26 22:49:35.220956+00	2025-12-26 23:48:35+00	13	6c993ee9522146d29c49a3f467a6f168	\N
363	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2NzkyOTY4LCJpYXQiOjE3NjY3ODk0MjgsImp0aSI6IjgxNzVlMDVjNTRmZTRkODM5MmJiOTNhZDU0ZjBiZjEwIiwidXNlcl9pZCI6IjEzIn0.AqsW2Iy-UvlIACy615FVQlXk401rseC0LyObLDv2MK4	2025-12-26 22:50:28.801039+00	2025-12-26 23:49:28+00	13	8175e05c54fe4d8392bb93ad54f0bf10	\N
364	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc5Mjk2OCwiaWF0IjoxNzY2Nzg5NDI4LCJqdGkiOiI3NzdhYzg4YzJiYjM0Y2UzYjNhNzg2Nzk4NTA0Y2UzOCIsInVzZXJfaWQiOiIxMyJ9.YvTBKhSx2jzC4k7RFvCXsiQ0nsDTMzwpKaRJNYy50tA	2025-12-26 22:50:28.82555+00	2025-12-26 23:49:28+00	13	777ac88c2bb34ce3b3a786798504ce38	\N
365	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc4OTc3NCwiaWF0IjoxNzY2Nzg5NDc0LCJqdGkiOiIwODI3OTkwNWE5NjA0ZjY2OTVhNDYwYjE2MDk5OTdhYyIsInVzZXJfaWQiOiIxMyJ9.BnLno1Hd19G3UyVK_nSRpFusXuBekFcE27WUJ1MSGuE	2025-12-26 22:51:14.935194+00	2025-12-26 22:56:14+00	13	08279905a9604f6695a460b1609997ac	\N
366	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2NzkzNTkyLCJpYXQiOjE3NjY3OTAwNTIsImp0aSI6ImJjOGNkNWE5ZWFkMzQwYmQ5ZTdjNzAzMzE3ZjlhM2RjIiwidXNlcl9pZCI6IjEzIn0.Eikf2ITCNdHDyAkikjrMGRdOM2oD9FZkVXz8WKFnsL0	2025-12-26 23:00:52.287924+00	2025-12-26 23:59:52+00	13	bc8cd5a9ead340bd9e7c703317f9a3dc	\N
367	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njc5MzU5MiwiaWF0IjoxNzY2NzkwMDUyLCJqdGkiOiIyMTc3MzE4OWMwNjA0ZTk2OTBjYTQyODk5ZjQyMjA4MCIsInVzZXJfaWQiOiIxMyJ9.dp5vxwoB_c5TNU1X6iQVkghaWTMxlIDdfh8SJV9vT-w	2025-12-26 23:00:52.327306+00	2025-12-26 23:59:52+00	13	21773189c0604e9690ca42899f422080	\N
368	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2ODI1MzMyLCJpYXQiOjE3NjY4MjE3OTIsImp0aSI6IjUxNWY0ZGI5NTgyNTQwZjA5NTU1Y2I5ODA4MzFkMGFiIiwidXNlcl9pZCI6IjEzIn0.SU1ZEIk5z1zgpxVdsa8uLjZMoLHMz-pSXdXCkuaNvUU	2025-12-27 07:49:52.603925+00	2025-12-27 08:48:52+00	13	515f4db9582540f09555cb980831d0ab	\N
369	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjgyNTMzMiwiaWF0IjoxNzY2ODIxNzkyLCJqdGkiOiIxZWVmYTVkZjY0MTA0M2Y3OTk0MTU5ZDNhYmM0MjI3ZSIsInVzZXJfaWQiOiIxMyJ9.6dXP4ARaOxme7ApuVQbryJE995whhicKpJo4OIe8Kdc	2025-12-27 07:49:52.675219+00	2025-12-27 08:48:52+00	13	1eefa5df641043f7994159d3abc4227e	\N
370	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2ODUwODIzLCJpYXQiOjE3NjY4NDcyODMsImp0aSI6IjY3YWZmYTk5YWYzNTRiZWI5YTVhYzZmZmMxNWJjOTYzIiwidXNlcl9pZCI6IjEzIn0.BYE1t-HsUZKVG7A7XAF6hThuPST0m33tqjzkxmyDEpY	2025-12-27 14:54:43.825717+00	2025-12-27 15:53:43+00	13	67affa99af354beb9a5ac6ffc15bc963	\N
371	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njg1MDgyNCwiaWF0IjoxNzY2ODQ3Mjg0LCJqdGkiOiI5NmMzNWM0Njk3YTM0N2UyYTQ3NzA5ODQyNGYxNjMyZSIsInVzZXJfaWQiOiIxMyJ9.sSBtHrCW6yD6xm2xRm_6wQbzaCG3ynUEbSJ7CWDxoSY	2025-12-27 14:54:44.454695+00	2025-12-27 15:53:44+00	13	96c35c4697a347e2a477098424f1632e	\N
372	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njg1MjE3OCwiaWF0IjoxNzY2ODUxODc4LCJqdGkiOiI3NGQ0ZTQyYWE4ZTI0MTcwOGJjY2Y1YjFiNmJiMTI0YiIsInVzZXJfaWQiOiIxMyJ9.WuVqagPeZOTBv4QOvRIuBFmlcovabsLMJLhebxSWJIE	2025-12-27 16:11:18.766497+00	2025-12-27 16:16:18+00	13	74d4e42aa8e241708bccf5b1b6bb124b	\N
373	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkyMDE4NCwiaWF0IjoxNzY2OTE5ODg0LCJqdGkiOiJlOGNmZTgwZjhiZTI0MzQ4OTBjNTMzMjhiMWY2ZDgyNyIsInVzZXJfaWQiOiI0MSJ9.56ZHPeTdqRGmeBeZTdEZdDQq-h4aLKVOW4skd8mmqpA	2025-12-28 11:04:44.386886+00	2025-12-28 11:09:44+00	41	e8cfe80f8be2434890c53328b1f6d827	\N
374	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkyNDY2OCwiaWF0IjoxNzY2OTI0MzY4LCJqdGkiOiI2NTMyMmMxZDNiYmI0ODJjYmZmNzhmM2U0MDZmYjdmNCIsInVzZXJfaWQiOiI0MSJ9.Q8bQgbU9_2tO1qI1fSqCV4ALJGnjXknqTPpxG2CmxDI	2025-12-28 12:19:28.458409+00	2025-12-28 12:24:28+00	41	65322c1d3bbb482cbff78f3e406fb7f4	\N
375	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkyNzkxOSwiaWF0IjoxNzY2OTI3NjE5LCJqdGkiOiI4OGUzZmY3YTRkMDc0MDkzYTZmMDgwMmJjOGY1NWI5OSIsInVzZXJfaWQiOiI0MSJ9.CpqjtB4YZm8BpvwGfnqnp5BKm9yzqCKok8LoOklEWwg	2025-12-28 13:13:39.963174+00	2025-12-28 13:18:39+00	41	88e3ff7a4d074093a6f0802bc8f55b99	\N
376	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkyODAzMSwiaWF0IjoxNzY2OTI3NzMxLCJqdGkiOiI5YmU0YzZkMTcyMWM0YTcxYjg1MzhlNDE4MGJjZWNjMyIsInVzZXJfaWQiOiI0MSJ9.Iz0nUVCtFm4cBT-toFGyrnasrR0hv1M9fJ-PVbxWGAg	2025-12-28 13:15:31.35003+00	2025-12-28 13:20:31+00	41	9be4c6d1721c4a71b8538e4180bcecc3	\N
377	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkzMDA5MCwiaWF0IjoxNzY2OTI5NzkwLCJqdGkiOiJmMzFhODA5ODJhYjY0YmZkYmYzMTNiZmVhNzJkYzlhYSIsInVzZXJfaWQiOiI0MSJ9.0-61ZTFZ44nSk2m2TctRtZ8_OoEBGF8Yed-ww3KjsIg	2025-12-28 13:49:50.861987+00	2025-12-28 13:54:50+00	41	f31a80982ab64bfdbf313bfea72dc9aa	\N
378	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkzMjg0OCwiaWF0IjoxNzY2OTMyNTQ4LCJqdGkiOiI3ZTRiODMyY2JmYWY0MWE5YjRlOTViY2ZjMjhlNzFmMiIsInVzZXJfaWQiOiI0MSJ9.9lUDg-0U6lV6Zzlle0fVkr5Kw3EWlZxGWh7r9Apt5Wc	2025-12-28 14:35:48.649943+00	2025-12-28 14:40:48+00	41	7e4b832cbfaf41a9b4e95bcfc28e71f2	\N
379	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkzNDMyNCwiaWF0IjoxNzY2OTM0MDI0LCJqdGkiOiJjMzQ3MGYzZGI1YjY0ZTk5YjY4OGFjZDg2ZGRiNThhYyIsInVzZXJfaWQiOiI0MSJ9.T3b0h7DUGCuKmAac8RS1lfjsLwXsErLZ3cyT7MU_kWQ	2025-12-28 15:00:24.351993+00	2025-12-28 15:05:24+00	41	c3470f3db5b64e99b688acd86ddb58ac	\N
380	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkzNDg0NSwiaWF0IjoxNzY2OTM0NTQ1LCJqdGkiOiI4NjUxZWYxYzA0Yjk0NjRiYjQ4MTYzZmYyNWFlZDYwZSIsInVzZXJfaWQiOiI0MSJ9.tGr1hupuw6BZlKBll3dOlnluLMbgEJhu7pS5ph4AABU	2025-12-28 15:09:05.950544+00	2025-12-28 15:14:05+00	41	8651ef1c04b9464bb48163ff25aed60e	\N
381	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkzNTE0MywiaWF0IjoxNzY2OTM0ODQzLCJqdGkiOiJjNTAyNGE1ZjFiZjg0YWZlYjI3ZTRmZWNlMzBhYzIwOCIsInVzZXJfaWQiOiI0MSJ9.DXVFj3ZkyOqeM64BtNTHXOzo921PgAOW_Lj5ymfEw0s	2025-12-28 15:14:03.061364+00	2025-12-28 15:19:03+00	41	c5024a5f1bf84afeb27e4fece30ac208	\N
382	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkzNTQ4NSwiaWF0IjoxNzY2OTM1MTg1LCJqdGkiOiJhNjA2MDM2NTY0Zjc0MjUyOWE1NmQ5ZGUzMzViNDNhYSIsInVzZXJfaWQiOiI0MSJ9.CfWcte-X5WhJJFg96VzB57EfxcRzWtUhn5Fv7_NA9Wo	2025-12-28 15:19:45.461086+00	2025-12-28 15:24:45+00	41	a606036564f742529a56d9de335b43aa	\N
383	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkzNTY1MSwiaWF0IjoxNzY2OTM1MzUxLCJqdGkiOiIyZjU3ZTRlNWY0ZjQ0ZGMzODEwZWIyYTEwODMzOTQ0ZiIsInVzZXJfaWQiOiI0MSJ9.IRRVlE5_GzYJx1SisQk7SCGT0LAEImkjvOUg7Fy08xQ	2025-12-28 15:22:31.063187+00	2025-12-28 15:27:31+00	41	2f57e4e5f4f44dc3810eb2a10833944f	\N
384	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NjkzNTgwNSwiaWF0IjoxNzY2OTM1NTA1LCJqdGkiOiI0NTlhOTVkYjFhY2U0ODgzYTA0N2RmODQxYWZlNDBlMSIsInVzZXJfaWQiOiI0MSJ9.boSs5gwz3kbGXPr_bwBqy2_3-a_xFmYdjFXzrBAVMts	2025-12-28 15:25:05.958002+00	2025-12-28 15:30:05+00	41	459a95db1ace4883a047df841afe40e1	\N
385	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2OTQ2NzE5LCJpYXQiOjE3NjY5NDMxNzksImp0aSI6ImQ0MGQ1YWM1NjBkNDQ2ODNiZGU5ZjVhZTM1NTUwOWQyIiwidXNlcl9pZCI6IjEzIn0.iJmk1ubm-0iOmFAsQxuGefZAwSa0I92tcb0-ONMlUwE	2025-12-28 17:32:59.812722+00	2025-12-28 18:31:59+00	13	d40d5ac560d44683bde9f5ae355509d2	\N
386	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njk0NjcxOSwiaWF0IjoxNzY2OTQzMTc5LCJqdGkiOiI5NTY0MzlkYWE5MTU0ZTM0YTQ2MmJkYzE3ZGU5YzUzOCIsInVzZXJfaWQiOiIxMyJ9.hs_V60G4yzAYjuwH8bQcZYZRLLp1IFHl1pROPvDSWjA	2025-12-28 17:32:59.891308+00	2025-12-28 18:31:59+00	13	956439daa9154e34a462bdc17de9c538	\N
387	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY2OTYxMjQxLCJpYXQiOjE3NjY5NTc3MDEsImp0aSI6ImY1MmU2NTZiNmUyZjRkMzliNDIzMDM2MjM5YjRhYzM0IiwidXNlcl9pZCI6IjEzIn0.Pyc-9m5BdbTTYZ2gLHIKpLigTkmfuHa1hk2GRBQf4FI	2025-12-28 21:35:01.607627+00	2025-12-28 22:34:01+00	13	f52e656b6e2f4d39b423036239b4ac34	\N
388	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njk2MTI0MSwiaWF0IjoxNzY2OTU3NzAxLCJqdGkiOiI1YzY4OWFhNDQ2NmI0YTVhYjljZWE5YzQ4NGNmZjE5YiIsInVzZXJfaWQiOiIxMyJ9.oC9PtqCsIiZN-IIsNwMunAv6jib9oQxSeI6-aEEqOAU	2025-12-28 21:35:01.676366+00	2025-12-28 22:34:01+00	13	5c689aa4466b4a5ab9cea9c484cff19b	\N
389	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njk5Njk0MCwiaWF0IjoxNzY2OTk2NjQwLCJqdGkiOiJhOGM1MDQzNDBlNzk0NTEwYmUwNmQwYjdiOTk5NDRhNCIsInVzZXJfaWQiOiI0MCJ9.X4uhnccw_eJSiIaejlQQNDNwCiCdMe77IVB2am-DtFE	2025-12-29 08:24:00.735373+00	2025-12-29 08:29:00+00	40	a8c504340e794510be06d0b7b99944a4	\N
390	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Njk5ODIxOSwiaWF0IjoxNzY2OTk3OTE5LCJqdGkiOiI4ZjlhMTQ5M2FmZDA0YWMyODEzNjY5ZGM3MDc4OWJhNCIsInVzZXJfaWQiOiI0MCJ9.BsXk8OgpBAEODOdceXiHzoaWrROiNOC8gH2yZixQqUc	2025-12-29 08:45:19.143714+00	2025-12-29 08:50:19+00	40	8f9a1493afd04ac2813669dc70789ba4	\N
391	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3MDE2NDg2LCJpYXQiOjE3NjcwMTI5NDYsImp0aSI6IjI2OTM2OThmNTIzYzQzY2Q4NzMyZjNmNzQyNzhjMTk5IiwidXNlcl9pZCI6IjEzIn0.23jZq2-9C1UnQMgpVLqvcyb84uuCBpmtmRGHj8f1qPg	2025-12-29 12:55:46.22458+00	2025-12-29 13:54:46+00	13	2693698f523c43cd8732f3f74278c199	\N
392	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxNjQ4NiwiaWF0IjoxNzY3MDEyOTQ2LCJqdGkiOiIwYWI0MWM3MGUzOGQ0YTBiOWY2MDA0MTIwNzAwZjhhNyIsInVzZXJfaWQiOiIxMyJ9._-097CQvtNWVOB2iKwzgoBNdvvNvOpPaK81bs9uxSJ8	2025-12-29 12:55:46.410584+00	2025-12-29 13:54:46+00	13	0ab41c70e38d4a0b9f6004120700f8a7	\N
393	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzM3MiwiaWF0IjoxNzY3MDEzMDcyLCJqdGkiOiIyMjAxODcxY2QxNTc0ZmQ2YTEzZGM3Y2FmYjVlMGQ4NSIsInVzZXJfaWQiOiIxMyJ9.HYI1Ph1DVwsn7bb829mOwabx7zNinpN6AQeuVFXjJIM	2025-12-29 12:57:52.238354+00	2025-12-29 13:02:52+00	13	2201871cd1574fd6a13dc7cafb5e0d85	\N
394	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzQwNSwiaWF0IjoxNzY3MDEzMTA1LCJqdGkiOiJlMjEzODk2NTQxZGM0MmQxOTY3MjVjM2IxY2M5NDNkMSIsInVzZXJfaWQiOiIxMyJ9.S4OMYdWChUlvUK0h18rwpA4E36TZ8cssF4fyP2dz5fo	2025-12-29 12:58:25.841679+00	2025-12-29 13:03:25+00	13	e213896541dc42d196725c3b1cc943d1	\N
395	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzQxMCwiaWF0IjoxNzY3MDEzMTEwLCJqdGkiOiJjMTJlM2M1MjlmOTc0NjdkYjlkODMyYTFiYzA5YThmOCIsInVzZXJfaWQiOiIxMyJ9.cVYkpl8Uakdw_sp7MzGo3IZTaRtS2-rZS7MvJM05NRU	2025-12-29 12:58:30.034923+00	2025-12-29 13:03:30+00	13	c12e3c529f97467db9d832a1bc09a8f8	\N
396	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzQzNiwiaWF0IjoxNzY3MDEzMTM2LCJqdGkiOiJkNTljNDRmYzQyM2M0MTk1YTYyNmRlNGFlZDhhMTA5OSIsInVzZXJfaWQiOiIxMyJ9.6Y_cSHd4K5iw7tuYmvB_w4xE4YjG6L1Zv9C4Z7kU7Vk	2025-12-29 12:58:56.044249+00	2025-12-29 13:03:56+00	13	d59c44fc423c4195a626de4aed8a1099	\N
397	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzQ2MiwiaWF0IjoxNzY3MDEzMTYyLCJqdGkiOiIxOWI2YWVjYjNlZDU0MzUwODYyZWUxOTBiMjI1OTI5NSIsInVzZXJfaWQiOiIxMyJ9.96s0FbnDAnd1C7U6CenKZs1ODtN_fS4ebJ57EGOZAr4	2025-12-29 12:59:22.33234+00	2025-12-29 13:04:22+00	13	19b6aecb3ed54350862ee190b2259295	\N
398	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3MDE2NzEzLCJpYXQiOjE3NjcwMTMxNzMsImp0aSI6IjA5Zjk0ZjE4YTllODRmNGE4YTdlYTY1YmJlMTk5OTVkIiwidXNlcl9pZCI6IjEzIn0.HrT9Xq4w6rqxwFUHJsoYas6SFxviDe1j61wvDXwk8zk	2025-12-29 12:59:33.110039+00	2025-12-29 13:58:33+00	13	09f94f18a9e84f4a8a7ea65bbe19995d	\N
399	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxNjcxMywiaWF0IjoxNzY3MDEzMTczLCJqdGkiOiIxZmQ5NWM3ZjgwNDg0N2JkOGM4Yzk3MTYwMjA0YmZhNiIsInVzZXJfaWQiOiIxMyJ9.UrDcUnQDzIo1hPFuAGVz03_k9ZzsftQZAuy0cKJ-T8w	2025-12-29 12:59:33.135987+00	2025-12-29 13:58:33+00	13	1fd95c7f804847bd8c8c97160204bfa6	\N
400	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzYxOCwiaWF0IjoxNzY3MDEzMzE4LCJqdGkiOiI0OGM1ODUzZjg0NTA0ZTIzOTM1ZjAzMDc1Yzg2ZjJkNyIsInVzZXJfaWQiOiI0MSJ9.oy5RQwWBcU0rHX262JQIgnkhf06oEdilm-KCqNatFTQ	2025-12-29 13:01:58.642195+00	2025-12-29 13:06:58+00	41	48c5853f84504e23935f03075c86f2d7	\N
401	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzYyNSwiaWF0IjoxNzY3MDEzMzI1LCJqdGkiOiI3NGQyM2Q4OGQzYjU0ZGU1YmIyOWQ5M2Q5MTdkNWM1NCIsInVzZXJfaWQiOiI0MSJ9.gPQ6keLCNKtqvBvP5P-EWAt8UVO_vfySC39sN_XZeqs	2025-12-29 13:02:05.33782+00	2025-12-29 13:07:05+00	41	74d23d88d3b54de5bb29d93d917d5c54	\N
402	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzY0NywiaWF0IjoxNzY3MDEzMzQ3LCJqdGkiOiIwYzdlZjkyODEwMzA0MTc2ODZkYzc2ZmJkYTc0YTc3MiIsInVzZXJfaWQiOiI0MSJ9.iGvXxzE1m6t6nQ9iXVcTSd4M6n0JeVB6egLiBJ-Cf5g	2025-12-29 13:02:27.140244+00	2025-12-29 13:07:27+00	41	0c7ef9281030417686dc76fbda74a772	\N
403	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzY4MywiaWF0IjoxNzY3MDEzMzgzLCJqdGkiOiIzZWY4NjA1MzllY2M0NDZkOGI0NjA4Mzg3ZDUzZTcxYiIsInVzZXJfaWQiOiI0MSJ9.PfzCIJF77qJ4ibV0HoBChsKQ1UL742XXPltsniyfY04	2025-12-29 13:03:03.74065+00	2025-12-29 13:08:03+00	41	3ef860539ecc446d8b4608387d53e71b	\N
404	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzcyMiwiaWF0IjoxNzY3MDEzNDIyLCJqdGkiOiI4YTM5YzdjNjJmNmQ0YWM1OTNjY2NkZjM4ZDBjOThiMyIsInVzZXJfaWQiOiI0MSJ9.r5k5hy0saTxl9dagjiioHZdSMhzFVi89ZtDoDlrpJjY	2025-12-29 13:03:42.435922+00	2025-12-29 13:08:42+00	41	8a39c7c62f6d4ac593cccdf38d0c98b3	\N
405	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzkzMywiaWF0IjoxNzY3MDEzNjMzLCJqdGkiOiIyMGUzYmRiNGZjZjc0YjVkOGU0ODhmY2RlZjdmMDg3MSIsInVzZXJfaWQiOiI0MSJ9.c-SE1i9kHGOHg4gvh-O56Btzcmc8MyzLtdYFHorxkXw	2025-12-29 13:07:13.937235+00	2025-12-29 13:12:13+00	41	20e3bdb4fcf74b5d8e488fcdef7f0871	\N
406	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxMzk1NiwiaWF0IjoxNzY3MDEzNjU2LCJqdGkiOiIzYWMxZDk4MWU4ZGI0YmY1ODZkNjM5YjAzZjNlODkxMCIsInVzZXJfaWQiOiI0MSJ9.MqsSsGa3PIrwGPCAqBJ5mmHcFUWoPkXhGdxhC0aQIeE	2025-12-29 13:07:36.743073+00	2025-12-29 13:12:36+00	41	3ac1d981e8db4bf586d639b03f3e8910	\N
407	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxNDAwMSwiaWF0IjoxNzY3MDEzNzAxLCJqdGkiOiJlZDg0Y2M0ZWMyODU0NDA4OWRjYzdjNzE3MDQxZjIwYyIsInVzZXJfaWQiOiI0MSJ9.R4ic9KG0724-4HI_iME-ozyAnBeO48axQIME7AbEkrc	2025-12-29 13:08:21.734306+00	2025-12-29 13:13:21+00	41	ed84cc4ec28544089dcc7c717041f20c	\N
408	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxNDAzNiwiaWF0IjoxNzY3MDEzNzM2LCJqdGkiOiJhYWExNjczZDEzYzY0YTBkODY0ODY4YjJhYmMzYjU5ZSIsInVzZXJfaWQiOiI0MSJ9.dbeqL7u-gfziStmQ9xrIlImyLqk0MAOKJV8isbotJMw	2025-12-29 13:08:56.838388+00	2025-12-29 13:13:56+00	41	aaa1673d13c64a0d864868b2abc3b59e	\N
409	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxNDA2MSwiaWF0IjoxNzY3MDEzNzYxLCJqdGkiOiI3MzljNmE4NDUwNWU0OTM5OGRkZjc5MjY4NmUyZTA1OCIsInVzZXJfaWQiOiI0MSJ9.tmPbhavhQ7VwhKjws5_638TGDH8-k40ZB1aKi3dGAAc	2025-12-29 13:09:21.33137+00	2025-12-29 13:14:21+00	41	739c6a84505e49398ddf792686e2e058	\N
410	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxNDU3MiwiaWF0IjoxNzY3MDE0MjcyLCJqdGkiOiJhM2RmZmFkNmI1NzQ0NjE1OGUxYTJlNzI0NDNlMzVkOCIsInVzZXJfaWQiOiI0MSJ9.Z7ptQZx5_P_yf-TwI2AC4cqJrH3AFEPWpBV4MtcRu5E	2025-12-29 13:17:52.934672+00	2025-12-29 13:22:52+00	41	a3dffad6b57446158e1a2e72443e35d8	\N
411	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxNDY5NSwiaWF0IjoxNzY3MDE0Mzk1LCJqdGkiOiI4YzBjZDBmZmMwNTQ0NmFjOGM3OGZiMWY3YjJlM2ZmNiIsInVzZXJfaWQiOiIxMyJ9.87POALmRaU99zeyqxqPa1DdsSrbaWBhsjpyzb548kC0	2025-12-29 13:19:55.031622+00	2025-12-29 13:24:55+00	13	8c0cd0ffc05446ac8c78fb1f7b2e3ff6	\N
412	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxNDczMSwiaWF0IjoxNzY3MDE0NDMxLCJqdGkiOiI2ZjFiODE0N2QzYWI0ZDk3ODBlN2QyMGY3M2Q2MDNmYSIsInVzZXJfaWQiOiIxMyJ9.Bps0cmXa-tt6w3BrxCWWhrdd1NqWsB92oqTnl2zH_EA	2025-12-29 13:20:31.034814+00	2025-12-29 13:25:31+00	13	6f1b8147d3ab4d9780e7d20f73d603fa	\N
413	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3MDE3OTg5LCJpYXQiOjE3NjcwMTQ0NDksImp0aSI6IjRkOGJhMjgzYjQzMjQ0MDNiNjc1YTI4ODFhNzQ3MzZmIiwidXNlcl9pZCI6IjEzIn0.w31K-4SFfDewUHuPbkMee4S1wkX377bUvthj0ekowUg	2025-12-29 13:20:49.60378+00	2025-12-29 14:19:49+00	13	4d8ba283b4324403b675a2881a74736f	\N
414	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxNzk4OSwiaWF0IjoxNzY3MDE0NDQ5LCJqdGkiOiIxNzVlNDEyODQyMzA0N2M3OGFmMDMwZTQ5MWZkMTg5NiIsInVzZXJfaWQiOiIxMyJ9.fccqFER1MEvy8rHr4v_ls3UtlSkHOY0S00BjnhPIEvU	2025-12-29 13:20:49.639336+00	2025-12-29 14:19:49+00	13	175e4128423047c78af030e491fd1896	\N
415	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxNTA5NywiaWF0IjoxNzY3MDE0Nzk3LCJqdGkiOiIyMDE5ZmVmNzk4ZWI0NDdiYWY0MmYwZWIwOGE1ZjE5ZSIsInVzZXJfaWQiOiIxMyJ9.m2a5fRDPfvv_4lWLTTrqlcREMI8-KtNhzGAIfGDBMOA	2025-12-29 13:26:37.743174+00	2025-12-29 13:31:37+00	13	2019fef798eb447baf42f0eb08a5f19e	\N
416	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAxNTk2OSwiaWF0IjoxNzY3MDE1NjY5LCJqdGkiOiIzYmI1MDY5N2Y0ZTk0YWZjYWUzMzEyNWY5MTY1NWQwZCIsInVzZXJfaWQiOiIxMyJ9.ZpJ2JxvfDgQHhYeyUgESwgSkBdTL8eHQM8OGgDogn-Q	2025-12-29 13:41:09.739134+00	2025-12-29 13:46:09+00	13	3bb50697f4e94afcae33125f91655d0d	\N
417	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAyNDU5OSwiaWF0IjoxNzY3MDI0Mjk5LCJqdGkiOiI2NmVlYTJmNDY4MDU0M2E3YTllYjhhY2RkNTljZTM4MiIsInVzZXJfaWQiOiIxMyJ9.D2j85nQwJp7nhbaJLaP7H1fNU9YfKIX58weIPqK46Yw	2025-12-29 16:04:59.299045+00	2025-12-29 16:09:59+00	13	66eea2f4680543a7a9eb8acdd59ce382	\N
418	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAyNDY1NSwiaWF0IjoxNzY3MDI0MzU1LCJqdGkiOiIzNmMwNTAxZjEzY2M0MjZlOWJjODhiYzhmM2VlYjI2MSIsInVzZXJfaWQiOiIxMyJ9.NN1XwJPHMYN244O6y8KKyDgI9TkNOUhhFzHq9axXMiQ	2025-12-29 16:05:55.109124+00	2025-12-29 16:10:55+00	13	36c0501f13cc426e9bc88bc8f3eeb261	\N
419	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAyNDk2NSwiaWF0IjoxNzY3MDI0NjY1LCJqdGkiOiIwZWRhOTZlZTNiM2M0ZjRjYTc1MmJiNmRlZjBjYTc2OSIsInVzZXJfaWQiOiIxMyJ9.brarZC1SVAkdCj5SFffrG0BpyfDOQs7cCzPKwWuXFJM	2025-12-29 16:11:05.904883+00	2025-12-29 16:16:05+00	13	0eda96ee3b3c4f4ca752bb6def0ca769	\N
420	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAyOTEwMSwiaWF0IjoxNzY3MDI4ODAxLCJqdGkiOiI1NmFkMTdlYjEyYWU0NTNmOTRkNDI3MjBhOTY4ZjJjYiIsInVzZXJfaWQiOiIxMyJ9.9o99QywGqTPaJSILyYK28Im62dBQ5LPD-KBHM7dwg98	2025-12-29 17:20:01.836582+00	2025-12-29 17:25:01+00	13	56ad17eb12ae453f94d42720a968f2cb	\N
421	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAzMTM2NCwiaWF0IjoxNzY3MDMxMDY0LCJqdGkiOiI0NDQyN2Q5NTU1YWY0YzIwYjEwOWFjNWM4YWI5MDk1YiIsInVzZXJfaWQiOiIxMyJ9.EWPCqDAjuN91sZ1-N10oxfT123_rp1YrqOV7a6M4tAA	2025-12-29 17:57:44.320845+00	2025-12-29 18:02:44+00	13	44427d9555af4c20b109ac5c8ab9095b	\N
422	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3MDM0NjUxLCJpYXQiOjE3NjcwMzExMTEsImp0aSI6IjJhMTZkNTY2NmM2YjRkZmM5NGM1MmYwZGI5NGQ5MWVlIiwidXNlcl9pZCI6IjEzIn0.wXcUAvv2yZkyYFRlayDl1pmP2vkoJHYvjRs9DwrQ1ps	2025-12-29 17:58:31.972539+00	2025-12-29 18:57:31+00	13	2a16d5666c6b4dfc94c52f0db94d91ee	\N
423	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAzNDY1MiwiaWF0IjoxNzY3MDMxMTEyLCJqdGkiOiI5ODM0ZjI2Yjc3ZWU0MmYyODAwMzk5NTc0ZjJmNTE0YSIsInVzZXJfaWQiOiIxMyJ9.UlOx_J-r9IsuPfWt1Mk_WT-8gkwEA6Exj1atzxlUXEs	2025-12-29 17:58:32.001433+00	2025-12-29 18:57:32+00	13	9834f26b77ee42f2800399574f2f514a	\N
424	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAzMTQ1NiwiaWF0IjoxNzY3MDMxMTU2LCJqdGkiOiJjZDc5MDc5ZmU1YTg0MmU3OWQyNmJmZWY5OGFkZjUzMiIsInVzZXJfaWQiOiIxMyJ9.AP83Ho1vXU0h0iPfmg12H6Lqwa3U76NGm8a7SzJH2CA	2025-12-29 17:59:16.517244+00	2025-12-29 18:04:16+00	13	cd79079fe5a842e79d26bfef98adf532	\N
425	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAzMzc3NywiaWF0IjoxNzY3MDMzNDc3LCJqdGkiOiIyOGI3MjA0ZTNkMWU0NzM3OGI5MDJlNGZkYjllMGM5NiIsInVzZXJfaWQiOiIxMyJ9.GEAlyq0nPXq1Q8q4nWakEl8Vzs3aRf7ye3nXYm9XiRs	2025-12-29 18:37:57.471102+00	2025-12-29 18:42:57+00	13	28b7204e3d1e47378b902e4fdb9e0c96	\N
426	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAzNDk2NSwiaWF0IjoxNzY3MDM0NjY1LCJqdGkiOiI4ZTg3ZTYzYTIwNjU0YTg0YjJmZjc0OTBiM2VkZDI0NyIsInVzZXJfaWQiOiI0NCJ9.XfjfJxP5JSL936D7O--Er0l4WdAuTa1kMO7GaQNQ-zI	2025-12-29 18:57:45.972957+00	2025-12-29 19:02:45+00	44	8e87e63a20654a84b2ff7490b3edd247	\N
427	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAzNjkwMCwiaWF0IjoxNzY3MDM2NjAwLCJqdGkiOiIzN2E4OGQ2ZGZjOGU0MDk5OGRlMmQxN2ZmMmIzOTM4ZSIsInVzZXJfaWQiOiIxMyJ9.WbArdlCWBykyFnYKBk7UHu7rEVgXCHvd2nvKO4MmC5s	2025-12-29 19:30:00.580055+00	2025-12-29 19:35:00+00	13	37a88d6dfc8e40998de2d17ff2b3938e	\N
428	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAzNzA0NCwiaWF0IjoxNzY3MDM2NzQ0LCJqdGkiOiJhNzc0NDRjYjlkNTM0OTQ0OWViOTIyZDUxNTYxYjg1YSIsInVzZXJfaWQiOiIxMyJ9.kQRFEkMtWKgQbbhdlRccBNdF0XY3yrQ8wu5tzyfUQZw	2025-12-29 19:32:24.57452+00	2025-12-29 19:37:24+00	13	a77444cb9d5349449eb922d51561b85a	\N
429	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAzNzMwNCwiaWF0IjoxNzY3MDM3MDA0LCJqdGkiOiI5NTNkMmI4N2E3MzY0YWQ1OTRmZWU3YjUxNTk1MzQ4NSIsInVzZXJfaWQiOiIxMyJ9.Zc6eFP0TKUA1SvwUKCJLbdXCTQEQIfgelXWyNBMrnuk	2025-12-29 19:36:44.378553+00	2025-12-29 19:41:44+00	13	953d2b87a7364ad594fee7b515953485	\N
430	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjcwNDExNzEsImlhdCI6MTc2NzAzNzYzMSwianRpIjoiMGRlOTQ0ZGRkNTE4NGJhNmEyMTY4NTc5MzUzMDYxOTYiLCJ1c2VyX2lkIjoiMTMifQ.u8gkg0HqX-YLZht5fFyYHMH6g-dSYZuuFnbSTE3DMzE	2025-12-29 19:47:11.86354+00	2025-12-29 20:46:11+00	13	0de944ddd5184ba6a216857935306196	\N
431	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAzODAyNSwiaWF0IjoxNzY3MDM3NzI1LCJqdGkiOiI0MDdkOGRhNWZiZGQ0YmFmYjZmNGVhZGZjNzJjYmVjZSIsInVzZXJfaWQiOiIxMyJ9.P9L7W_HwuC0gTrUXNTrsoCiraAOqXH1rn4nBfQpqZps	2025-12-29 19:48:45.675405+00	2025-12-29 19:53:45+00	13	407d8da5fbdd4bafb6f4eadfc72cbece	\N
432	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjcwNDIxMDksImlhdCI6MTc2NzAzODU2OSwianRpIjoiODFmYzM4NGUzMTk5NDYzMjlmZjRkMjYwNTAwMmYwZGYiLCJ1c2VyX2lkIjoiMTMifQ.IImwcsYeUpdGadA052gjeIqt2Ehal-7Q8kXHnhQpqzs	2025-12-29 20:02:49.657102+00	2025-12-29 21:01:49+00	13	81fc384e319946329ff4d2605002f0df	\N
433	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjcwNDI0NDQsImlhdCI6MTc2NzAzODkwNCwianRpIjoiNGRiZTRlODY3MDFkNDNiYzkyYzBmYTBjZTBmYzFmYmYiLCJ1c2VyX2lkIjoiMTMifQ.lxAsY4GwH2agdjmKQl-O41QIEVJXZsFBR-iV1K52SdA	2025-12-29 20:08:24.303381+00	2025-12-29 21:07:24+00	13	4dbe4e86701d43bc92c0fa0ce0fc1fbf	\N
434	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzAzOTI3NCwiaWF0IjoxNzY3MDM4OTc0LCJqdGkiOiJhMDc4N2E0ZGNmOWQ0N2IyOWE3NzllMGIwYWRlYmM0YSIsInVzZXJfaWQiOiIxMyJ9.MqZvkz3C9jUraOOJjf86BB8FBtiGYO4TurYX--NGCx8	2025-12-29 20:09:34.876633+00	2025-12-29 20:14:34+00	13	a0787a4dcf9d47b29a779e0b0adebc4a	\N
435	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjcwNDM1MzQsImlhdCI6MTc2NzAzOTk5NCwianRpIjoiZDhmNzBiN2M4ZmYwNDM4NDg1YzgzZWY5YzVjNDBmZDciLCJ1c2VyX2lkIjoiMTMifQ.0ZHSdFHFENNVJ1rSvspyoxuaEOuyZJJ1eYKfjT8GItc	2025-12-29 20:26:34.965643+00	2025-12-29 21:25:34+00	13	d8f70b7c8ff0438485c83ef9c5c40fd7	\N
436	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzA0MDM0NywiaWF0IjoxNzY3MDQwMDQ3LCJqdGkiOiIzMDBkOWUwM2UzYjc0OWEyOTQ3Yjk2ZWJkOTlmNjg3NCIsInVzZXJfaWQiOiIxMyJ9.01_JSkL6qjzhI6mIwHc4vZaM2SEI678YNGoK18jtK0s	2025-12-29 20:27:27.46707+00	2025-12-29 20:32:27+00	13	300d9e03e3b749a2947b96ebd99f6874	\N
437	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzA0MTE4OCwiaWF0IjoxNzY3MDQwODg4LCJqdGkiOiI3NzczZTcwZjg3MjI0NDAxOTIxNWRkYWYwNWQ4ZmY3ZiIsInVzZXJfaWQiOiIxMyJ9.didI4Dqo85VTijC6hkvV9jdvmxX08g3Z0YWxgztw5h0	2025-12-29 20:41:28.361929+00	2025-12-29 20:46:28+00	13	7773e70f872244019215ddaf05d8ff7f	\N
438	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzA0MjE4NywiaWF0IjoxNzY3MDQxODg3LCJqdGkiOiI5YjQzZGQ0MmIzODA0NmE2YjQ2ZThkMTQxZjA0YzQyZiIsInVzZXJfaWQiOiIxMyJ9.N3IOl2jYvZ_Tv4Cdc_fjZkq1iRiwEX-vceA3nQOROKg	2025-12-29 20:58:07.659112+00	2025-12-29 21:03:07+00	13	9b43dd42b38046a6b46e8d141f04c42f	\N
439	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjcwNDU0NjAsImlhdCI6MTc2NzA0MTkyMCwianRpIjoiNTZiZDljYjY4ZGVkNDk0YzlhNmEwYzBlYTc0NzI1YTkiLCJ1c2VyX2lkIjoiMTMifQ.3UPgZPYLEFHmi24fER-9KPuVytg5KrJdNI1Jwb4ftuk	2025-12-29 20:58:40.50571+00	2025-12-29 21:57:40+00	13	56bd9cb68ded494c9a6a0c0ea74725a9	\N
440	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjcwNDYxNTksImlhdCI6MTc2NzA0MjYxOSwianRpIjoiZmQ1MTQwNjE2OWRhNDEzMDgwM2YxYTJlNDY4MjNiMWUiLCJ1c2VyX2lkIjoiMTMifQ.jKhfv44E6QrTISfmfqclN1mgmTzi52sR5tkxAmskwwQ	2025-12-29 21:10:19.641898+00	2025-12-29 22:09:19+00	13	fd51406169da4130803f1a2e46823b1e	\N
441	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzA0MzAwMSwiaWF0IjoxNzY3MDQyNzAxLCJqdGkiOiJlMTdhOWQxYTA0ZDc0NzQ2OTg0N2Q1NzAxZjE5MTRkYyIsInVzZXJfaWQiOiIxMyJ9.q7eRfE4MM7_zw1qfK08j2sst_xMZucsR9Xytu6-59kI	2025-12-29 21:11:41.054769+00	2025-12-29 21:16:41+00	13	e17a9d1a04d747469847d5701f1914dc	\N
442	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVjb3ZlcnkiLCJleHAiOjE3NjcwNDgxNzEsImlhdCI6MTc2NzA0NDYzMSwianRpIjoiN2EwM2E5YTAxN2Y4NGM5ZDlkYjE2NGMzNDNmNTM5N2YiLCJ1c2VyX2lkIjoiMTMifQ.ji3Nr6CHl9LMhM8ZDlSwF9NHGhRcoDuhLvdpI_CnwZc	2025-12-29 21:43:51.208427+00	2025-12-29 22:42:51+00	13	7a03a9a017f84c9d9db164c343f5397f	\N
443	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzA0NTAxNiwiaWF0IjoxNzY3MDQ0NzE2LCJqdGkiOiJhYmI5NTNhYjJmZGI0MDk4ODdiMjA1NzM1ZjkzMWQ1NiIsInVzZXJfaWQiOiIxMyJ9.MPFi-ohTZDIrewskYF0l6Ii8yZw_DRt3TJU1_ZQopTI	2025-12-29 21:45:16.061431+00	2025-12-29 21:50:16+00	13	abb953ab2fdb409887b205735f931d56	\N
444	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzA0NTQ0MSwiaWF0IjoxNzY3MDQ1MTQxLCJqdGkiOiI4NGUyNTI4ZWJkNzk0MWIwYTkxYWQ2OTBhNmVmNWVkNiIsInVzZXJfaWQiOiI0NCJ9.8Q16VfKrMZIytOrzkMx0lsWV8tAYcjKEqaQONo9HVsk	2025-12-29 21:52:21.662172+00	2025-12-29 21:57:21+00	44	84e2528ebd7941b0a91ad690a6ef5ed6	\N
445	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzA4MzMzNSwiaWF0IjoxNzY3MDgzMDM1LCJqdGkiOiJmNjBmOTlkMDgwNzI0MTY3OTg0NmZkMzBiZjM3YWE2NSIsInVzZXJfaWQiOiIxMyJ9.ihYpv3eTQ-LqlsIrPnZqQz9TsAQOx6I-R2G_RSNHw0U	2025-12-30 08:23:55.09074+00	2025-12-30 08:28:55+00	13	f60f99d0807241679846fd30bf37aa65	\N
446	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzA4Mzc3NiwiaWF0IjoxNzY3MDgzNDc2LCJqdGkiOiJiZDk1YTllOWMwMjg0MWJiOGQ0MTgyZjllNDk0NmY4YyIsInVzZXJfaWQiOiI0NCJ9.Oj_icO4UnrtOc9UX3MCYl0xokCQe4UVtRrtKTjKJC1o	2025-12-30 08:31:16.497535+00	2025-12-30 08:36:16+00	44	bd95a9e9c02841bb8d4182f9e4946f8c	\N
447	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzA4NDkxOCwiaWF0IjoxNzY3MDg0NjE4LCJqdGkiOiI3MjUyZGY0NjJiNDU0OWExYjAyZWEwNDM3OWJmNjI3NCIsInVzZXJfaWQiOiI0MSJ9.sMWrkWiMpTDvHDVXKFs88KY-0-FBglP5VuHdRnPnSXQ	2025-12-30 08:50:18.093063+00	2025-12-30 08:55:18+00	41	7252df462b4549a1b02ea04379bf6274	\N
448	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzA5MjQzMCwiaWF0IjoxNzY3MDkyMTMwLCJqdGkiOiJlNWEyNmQwOWZjMWI0YzU0ODc4MTI4MWYyYjQ2ZTIxNSIsInVzZXJfaWQiOiI0NSJ9.UNMKzzcGnz-mxnER4QZtz7EJ9jollo8S1DhPWy5qsmc	2025-12-30 10:55:30.532026+00	2025-12-30 11:00:30+00	45	e5a26d09fc1b4c548781281f2b46e215	\N
449	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzE3Nzk0OCwiaWF0IjoxNzY3MTc3NjQ4LCJqdGkiOiJlYmM5NWMyOTE0NDg0ZjRkYThmZjg0Y2U3MDY4YTYxNSIsInVzZXJfaWQiOiI0NSJ9.8tYa1dKbeCVgpNl_7w6I71ekancXXXixvMZus1GnQJ8	2025-12-31 10:40:48.585064+00	2025-12-31 10:45:48+00	45	ebc95c2914484f4da8ff84ce7068a615	\N
450	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzE4NjE4MiwiaWF0IjoxNzY3MTg1ODgyLCJqdGkiOiI1OTAwNTVjMjQ2ZmM0YjUyODI1NmViMDU1NzI3ZTAzMCIsInVzZXJfaWQiOiI0NSJ9.tmw9QG1Qi8pjkQAAjnWolXDb5ulH1-eM0yz8PJZzTkg	2025-12-31 12:58:02.425655+00	2025-12-31 13:03:02+00	45	590055c246fc4b528256eb055727e030	\N
451	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzE4ODk4NywiaWF0IjoxNzY3MTg4Njg3LCJqdGkiOiJmYzNmMDU1OTE1N2Q0MDA3YWY2MDI5Mjk0MmFjNWRmMSIsInVzZXJfaWQiOiI0NiJ9.LDNuYUhd9LwqVuKgemNVEK1N4ASAATRjK-xgJOyCjqE	2025-12-31 13:44:47.576186+00	2025-12-31 13:49:47+00	46	fc3f0559157d4007af60292942ac5df1	\N
452	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzIyMzE1NywiaWF0IjoxNzY3MjIyODU3LCJqdGkiOiIyODUyYTI5MTQyMjg0NWQzYThkNDQ2MDFiZDQ1MzAwMSIsInVzZXJfaWQiOiI0NiJ9.a6TKRRQF1J0gi-E-PNbwpXFI9MgYwjTxB_C44qDpXow	2025-12-31 23:14:17.806169+00	2025-12-31 23:19:17+00	46	2852a291422845d3a8d44601bd453001	\N
453	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzI1NzA5MywiaWF0IjoxNzY3MjU2NzkzLCJqdGkiOiIzNDlhZTE1NmQ3Yjk0YWZlYjRlZTg0M2UyOWJmOGVmZCIsInVzZXJfaWQiOiI0MiJ9.PFRChBebqAB70FPqyBmT-WwPYQD3laHiqfAMTUAqLW8	2026-01-01 08:39:53.282236+00	2026-01-01 08:44:53+00	42	349ae156d7b94afeb4ee843e29bf8efd	\N
454	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzI1NzUyNywiaWF0IjoxNzY3MjU3MjI3LCJqdGkiOiI3NjU2M2EyNWU4MjI0ZDVkOTg4MGE3NGUzZWE4ZTBkYiIsInVzZXJfaWQiOiI0NiJ9.4LtxC61-ExgOM4MP-uFS_C3_Y6alMMvJM1JcP7-BxSg	2026-01-01 08:47:07.323731+00	2026-01-01 08:52:07+00	46	76563a25e8224d5d9880a74e3ea8e0db	\N
455	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzI1NzY4OCwiaWF0IjoxNzY3MjU3Mzg4LCJqdGkiOiI1MzE5YjNiY2Q0YzY0NGMwYWJmY2I5MzhhYjRmYTI4OSIsInVzZXJfaWQiOiI0NSJ9._YL07xjmsuVEoMWjJwW_hxuwMYKHrr-u2poqSoAjYLM	2026-01-01 08:49:48.203973+00	2026-01-01 08:54:48+00	45	5319b3bcd4c644c0abfcb938ab4fa289	\N
456	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzI1ODYyMiwiaWF0IjoxNzY3MjU4MzIyLCJqdGkiOiJhYjU1MWI0ZTEzNGQ0YWRmYjFlOGM2ZWRiZmU5MThmMiIsInVzZXJfaWQiOiI0NSJ9._HV30zNwzBJXppVzgOmRXoacLGvys87OK9weg6hr6k0	2026-01-01 09:05:22.496583+00	2026-01-01 09:10:22+00	45	ab551b4e134d4adfb1e8c6edbfe918f2	\N
457	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzI1ODY1MCwiaWF0IjoxNzY3MjU4MzUwLCJqdGkiOiI3MGRiNmY0MzIwMGQ0ZTIxYTRmMmIwNDRhODU0ZDBmMCIsInVzZXJfaWQiOiI0NSJ9.j9dU1--48gfZ6jYNnbu8jFk4B1B8d3F4IKnDcxvWFdE	2026-01-01 09:05:50.890235+00	2026-01-01 09:10:50+00	45	70db6f43200d4e21a4f2b044a854d0f0	\N
458	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzI1ODk1NCwiaWF0IjoxNzY3MjU4NjU0LCJqdGkiOiIzMmZiNTY4NjhiODU0NDRhOGIzZmM0NmVlZmYxMDgyNyIsInVzZXJfaWQiOiI0NSJ9.czBz3cIKkS7LgZYoq4zdWXl1tC_rgAh-0H_vsqyHUyo	2026-01-01 09:10:54.286903+00	2026-01-01 09:15:54+00	45	32fb56868b85444a8b3fc46eeff10827	\N
459	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzI5ODYwNSwiaWF0IjoxNzY3Mjk4MzA1LCJqdGkiOiI1MTM3NWJkMGM1MTg0NTVlOGI2MTNlNWRhYjhiZjEyMyIsInVzZXJfaWQiOiI0MiJ9.qMcKnsxITwpTDAYHkEhPokkvYJ_f86Kvie-3QpE3pDE	2026-01-01 20:11:45.685689+00	2026-01-01 20:16:45+00	42	51375bd0c518455e8b613e5dab8bf123	\N
460	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3MzA1NTk3LCJpYXQiOjE3NjczMDIwNTcsImp0aSI6IjY5ODFhN2Y4OTdlODQxY2FhNTdiZjIwNTBhM2FkYjliIiwidXNlcl9pZCI6IjQyIn0.AkE2d0-nz4kIQPxnpx0BZqykE7toJAqKUF3g3LlS_oQ	2026-01-01 21:14:17.844395+00	2026-01-01 22:13:17+00	42	6981a7f897e841caa57bf2050a3adb9b	\N
461	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzMwNTU5NywiaWF0IjoxNzY3MzAyMDU3LCJqdGkiOiJiY2VlNDlhMDMxMTM0MTI3YTBhYWQwZWMwZTM1ZDg4YyIsInVzZXJfaWQiOiI0MiJ9.cdsF2iPqgrlevEVt7mRzfHXOtOW6bg-Edy5HOUomUhg	2026-01-01 21:14:17.886568+00	2026-01-01 22:13:17+00	42	bcee49a031134127a0aad0ec0e35d88c	\N
462	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM1MTg5MCwiaWF0IjoxNzY3MzUxNTkwLCJqdGkiOiIwNTViNzNmMWVhYWQ0ODYyYTM0NmZjZGUyOTg2MWFiMCIsInVzZXJfaWQiOiI0MSJ9.h_s0hN66WHLVUz7kIa_adVq1T2T0n9SSU27pkVLhC8A	2026-01-02 10:59:50.421511+00	2026-01-02 11:04:50+00	41	055b73f1eaad4862a346fcde29861ab0	\N
463	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM1MTk0NSwiaWF0IjoxNzY3MzUxNjQ1LCJqdGkiOiJjMTM3ODhkNjQ2Mzc0YjdmYTM5ZDc3NmE3ZjhkOGUxNiIsInVzZXJfaWQiOiI0MSJ9.RtI032H5In2wtvGj4tEYo5a_n2MN1-MF4niwJ7V-01c	2026-01-02 11:00:45.632632+00	2026-01-02 11:05:45+00	41	c13788d646374b7fa39d776a7f8d8e16	\N
464	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM1MzY0NCwiaWF0IjoxNzY3MzUzMzQ0LCJqdGkiOiJmZGFjYTAxZmY0ODY0ZDM5ODhjNWI4ZjZlNDg5YjI4ZiIsInVzZXJfaWQiOiIxMyJ9.TxtrnhVFMdNSNFQXJid7E8e-lf7qWNd8WqWiACh230g	2026-01-02 11:29:04.624399+00	2026-01-02 11:34:04+00	13	fdaca01ff4864d3988c5b8f6e489b28f	\N
465	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM1NTc5MSwiaWF0IjoxNzY3MzU1NDkxLCJqdGkiOiIwODA2NDViMDhhMmE0YjJkOGU5Njk0YTE0NWM0YTIwYiIsInVzZXJfaWQiOiIxMyJ9.nw5v-XwuCUYCUx4isrpr_V7OGQpUdFhndiPPOAF8MiE	2026-01-02 12:04:51.430839+00	2026-01-02 12:09:51+00	13	080645b08a2a4b2d8e9694a145c4a20b	\N
466	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM1NzIxMSwiaWF0IjoxNzY3MzU2OTExLCJqdGkiOiJiYTEzZDI2MzYyYTQ0MTE3ODFiMWZhOWEzNTg0NWJjNyIsInVzZXJfaWQiOiIxMyJ9.utsg8CKOrj1P1cLCWGzGpY09LucR_c9c6hejmCEe26I	2026-01-02 12:28:31.329322+00	2026-01-02 12:33:31+00	13	ba13d26362a4411781b1fa9a35845bc7	\N
467	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM1NzMyOSwiaWF0IjoxNzY3MzU3MDI5LCJqdGkiOiIzZmNiZjFlY2Y3OWU0NDBhOThmYmYzNWNhZGUwN2ZlZSIsInVzZXJfaWQiOiIxMyJ9.3ZQR7Qz7k5lCsbvFfwPS_GdJ8t6tZNJhk3UmrZxkciI	2026-01-02 12:30:29.82104+00	2026-01-02 12:35:29+00	13	3fcbf1ecf79e440a98fbf35cade07fee	\N
468	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM1OTMyNiwiaWF0IjoxNzY3MzU5MDI2LCJqdGkiOiI2MTg5N2FhZDgwYjA0MjhmYTI2Y2Y2MDlkMTk4YzQ0YSIsInVzZXJfaWQiOiIxMyJ9.ykMphGDyHepySfDLtBEe1M0zk1wBuNDoY-J1I9Mui4s	2026-01-02 13:03:46.753607+00	2026-01-02 13:08:46+00	13	61897aad80b0428fa26cf609d198c44a	\N
469	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM2MDAzMiwiaWF0IjoxNzY3MzU5NzMyLCJqdGkiOiJhN2E1NzZiZGEyYzk0OTA5OTM0MTA4MmFkYzU2NWQ1MSIsInVzZXJfaWQiOiIxMyJ9.GwdRNjGasmPFo4GDwMf4nJEko-SQ9CiGRkGGz3idbIE	2026-01-02 13:15:32.96442+00	2026-01-02 13:20:32+00	13	a7a576bda2c949099341082adc565d51	\N
470	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM2MTAyOCwiaWF0IjoxNzY3MzYwNzI4LCJqdGkiOiIxYTg3YTY4YjhjZWY0YjExYjg4ZmI3MTQ1NDBlNjA0YyIsInVzZXJfaWQiOiIxMyJ9.9jR0LHMFZWvlwgqTNQSsOvaHWceh-05RTHAcm_y3QHI	2026-01-02 13:32:08.063448+00	2026-01-02 13:37:08+00	13	1a87a68b8cef4b11b88fb714540e604c	\N
471	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM2NTQ0MCwiaWF0IjoxNzY3MzY1MTQwLCJqdGkiOiJlMTkwN2VlOTc4ZmI0MWMwOTJiOTNkYTMyOTJiMjI4NSIsInVzZXJfaWQiOiIxMyJ9.AXBoNAM0kBGcPc3lIPZpvkdtk2muZ0zQYkAerh_6Xf0	2026-01-02 14:45:40.290464+00	2026-01-02 14:50:40+00	13	e1907ee978fb41c092b93da3292b2285	\N
472	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM2NjUzMywiaWF0IjoxNzY3MzY2MjMzLCJqdGkiOiJiM2JiOTQyMmMxNDY0MGI3OTcwZjZlYzIzMzljMTQ0NyIsInVzZXJfaWQiOiIxMyJ9.nvtQbDLz1CI34qKA-7NyBwn-f6QpDNhbkmKDrCW-o5A	2026-01-02 15:03:53.289219+00	2026-01-02 15:08:53+00	13	b3bb9422c14640b7970f6ec2339c1447	\N
473	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM2ODc5OSwiaWF0IjoxNzY3MzY4NDk5LCJqdGkiOiI5ZjdmNGRjN2UyYjA0MGQ5ODI1NTAxMmU4Y2U5NDBhNyIsInVzZXJfaWQiOiI0NCJ9.CDjvym5ZUYuzIN6RGWI2Ynream9IRTCCQd4ZfSzej7s	2026-01-02 15:41:39.185444+00	2026-01-02 15:46:39+00	44	9f7f4dc7e2b040d98255012e8ce940a7	\N
474	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM3MzE2MywiaWF0IjoxNzY3MzcyODYzLCJqdGkiOiIyNjgxZjNlOTNjZDg0ZjZjOGQ4NDQwNDM0ZDRhYjI1YiIsInVzZXJfaWQiOiIxMyJ9.XHpIHdrfwHTPk-cqnJ66VvXMD5gV9rqBfNNtBZmLAtM	2026-01-02 16:54:23.749453+00	2026-01-02 16:59:23+00	13	2681f3e93cd84f6c8d8440434d4ab25b	\N
475	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM3MzQxNCwiaWF0IjoxNzY3MzczMTE0LCJqdGkiOiJhODU0YWE0ZmQ1N2I0NDBhODUyMmE2ZjQxM2RjNjA1OSIsInVzZXJfaWQiOiI0MSJ9.HYLMQvFuZShAJg8FbMQjBojFlzFrlRYdeKHkI7sSeoY	2026-01-02 16:58:34.362445+00	2026-01-02 17:03:34+00	41	a854aa4fd57b440a8522a6f413dc6059	\N
476	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM3NTUyNiwiaWF0IjoxNzY3Mzc1MjI2LCJqdGkiOiI0YmI0ZTY4NzM4MmU0NGEzYTZlZWMxODNjMTc5YjQ2MSIsInVzZXJfaWQiOiI0MSJ9.XrJWfw_yS42UTSJkgi8BM6W41irI4O9dokkQLtRJLCo	2026-01-02 17:33:46.854638+00	2026-01-02 17:38:46+00	41	4bb4e687382e44a3a6eec183c179b461	\N
477	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM4ODQ5MSwiaWF0IjoxNzY3Mzg4MTkxLCJqdGkiOiJlYmIxOTJhMjExNWQ0YzY3OTg2ZTRjNWM4NjJlMDg5MSIsInVzZXJfaWQiOiI0NSJ9.1oNgrqgIGHp_yWhvhV2ikjT_u-cKOFAe_NvwlYcb4yE	2026-01-02 21:09:51.724802+00	2026-01-02 21:14:51+00	45	ebb192a2115d4c67986e4c5c862e0891	\N
478	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzM4ODUwOCwiaWF0IjoxNzY3Mzg4MjA4LCJqdGkiOiJjZjVmNjEzMGY0NGQ0MTE2YWYwYTI2ZmE4Yzc0YmVjOCIsInVzZXJfaWQiOiI0NSJ9.7gZ3X4vVQbldFWxVhLdM9QUPUfsE56huJpcZHCJptdw	2026-01-02 21:10:08.415239+00	2026-01-02 21:15:08+00	45	cf5f6130f44d4116af0a26fa8c74bec8	\N
479	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQzMzk3OSwiaWF0IjoxNzY3NDMzNjc5LCJqdGkiOiI4YzU4NTYxNGQyZTk0ZmRiOWM5NWVmNTgxYmNlYmI2NSIsInVzZXJfaWQiOiI0MSJ9.GcZCCq30AeUL2JwqAkOBnAGWU1DgyP8sE2s5WhxH3FU	2026-01-03 09:47:59.843293+00	2026-01-03 09:52:59+00	41	8c585614d2e94fdb9c95ef581bcebb65	\N
480	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQzNDY1NiwiaWF0IjoxNzY3NDM0MzU2LCJqdGkiOiI4YjkyYWJmMmNhMjU0OTlkODY3OTRmYmIyNTNiMGJiMSIsInVzZXJfaWQiOiI0MSJ9.Aa8qT6v6LM0mTOh2SvJfcp0XurFRYWwLNPcd5MjSQlE	2026-01-03 09:59:16.040225+00	2026-01-03 10:04:16+00	41	8b92abf2ca25499d86794fbb253b0bb1	\N
481	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQzNzkxOCwiaWF0IjoxNzY3NDM3NjE4LCJqdGkiOiIxOTU0MDM5ZGMzZjQ0OTU2OTRmZDQxZTcxN2M1MWM4NyIsInVzZXJfaWQiOiI0MSJ9.wLAZCEdKTYma6j27zmmeDhedgftyKUlKmg8qxy0yv5A	2026-01-03 10:53:38.688029+00	2026-01-03 10:58:38+00	41	1954039dc3f4495694fd41e717c51c87	\N
482	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQzOTExOCwiaWF0IjoxNzY3NDM4ODE4LCJqdGkiOiJkYTVlOTg3YTg0Yjk0ZDQwYmY1ZGRmZjhlYzVmZDA0NSIsInVzZXJfaWQiOiI0MSJ9.qb_bRmlDCj5KpUBLu0LMbjlIPi8NavzxZwo6_lMdEVs	2026-01-03 11:13:38.154758+00	2026-01-03 11:18:38+00	41	da5e987a84b94d40bf5ddff8ec5fd045	\N
483	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ0MDk4MSwiaWF0IjoxNzY3NDQwNjgxLCJqdGkiOiJjYmM1YWQ3ZjkyODY0ZmU2ODg2Y2JmMGI4ZTNlNjdiMyIsInVzZXJfaWQiOiI0MSJ9.P2AV4SVb76VqEGq8SITllp4Tf26SgyMAYOve4lYvDiE	2026-01-03 11:44:41.143312+00	2026-01-03 11:49:41+00	41	cbc5ad7f92864fe6886cbf0b8e3e67b3	\N
484	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ0Mjg0NCwiaWF0IjoxNzY3NDQyNTQ0LCJqdGkiOiJhZTQ1MTU1ODM3NDk0NzJkYWM2NDY3NzQ5YmQwZWNmOCIsInVzZXJfaWQiOiI0MSJ9.ls6WuZrowWBGIdZPQj5CCAKsq6_YLSaE7OtuDSuUhsU	2026-01-03 12:15:44.940653+00	2026-01-03 12:20:44+00	41	ae4515583749472dac6467749bd0ecf8	\N
485	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ0NDg2OSwiaWF0IjoxNzY3NDQ0NTY5LCJqdGkiOiI4NmM5ZmJlNDUxNTg0N2M5YTQ4ZmFhMTU2NGIyNTA2MyIsInVzZXJfaWQiOiI0MSJ9.waVGrsnIWJs2G_aJ4xphKyhja-QYglOkMpOznBASK14	2026-01-03 12:49:29.647023+00	2026-01-03 12:54:29+00	41	86c9fbe4515847c9a48faa1564b25063	\N
486	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ0NjczNywiaWF0IjoxNzY3NDQ2NDM3LCJqdGkiOiI3N2NiMmVkN2UyZjk0MjliYWQzZWZiOWRjMmExOTg5MCIsInVzZXJfaWQiOiI0MSJ9.N8U0hyEi0OaLg4fevq8-jDQOJppXxpUeshABXDQOiS0	2026-01-03 13:20:37.048857+00	2026-01-03 13:25:37+00	41	77cb2ed7e2f9429bad3efb9dc2a19890	\N
487	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ0ODYzOSwiaWF0IjoxNzY3NDQ4MzM5LCJqdGkiOiJkYzhiMGQxYjYzM2E0YTI4YjcxMDcxNWFlYjVkMWE5YSIsInVzZXJfaWQiOiI0MSJ9.Tcwo7Un435xyWbFh1-TwY5ksJmC48BhUNUC6mw2FRr8	2026-01-03 13:52:19.652067+00	2026-01-03 13:57:19+00	41	dc8b0d1b633a4a28b710715aeb5d1a9a	\N
488	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ1MDcyNywiaWF0IjoxNzY3NDUwNDI3LCJqdGkiOiIzNzQ4NDZlNWQyNzA0OTUzYTAxYzI4YmE4M2RhZGJlZiIsInVzZXJfaWQiOiI0MSJ9.gw5RXAGC-axx8guHz9cGvpMeZJa2jpKU7MNTnUpgvn0	2026-01-03 14:27:07.447301+00	2026-01-03 14:32:07+00	41	374846e5d2704953a01c28ba83dadbef	\N
489	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ1MjY1NywiaWF0IjoxNzY3NDUyMzU3LCJqdGkiOiJhY2FiOTU5NWM1MmE0MDM2ODJjN2M2YTI2YjI1NzRkZCIsInVzZXJfaWQiOiI0MSJ9.7cjDNkDH7amkSMo6fqRBC7-ErClkSyB0AUMIRxoovpI	2026-01-03 14:59:17.653573+00	2026-01-03 15:04:17+00	41	acab9595c52a403682c7c6a26b2574dd	\N
490	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ1NDk0MSwiaWF0IjoxNzY3NDU0NjQxLCJqdGkiOiIwNDMzNTI2NmI4OGQ0Y2FmYTZkYjQ5YzdlNDQ1YzM0ZCIsInVzZXJfaWQiOiI0MSJ9.vxD_vNGfI-LgpudtX3oIauNcKp0f1WAj0LEMkt40qb8	2026-01-03 15:37:21.449346+00	2026-01-03 15:42:21+00	41	04335266b88d4cafa6db49c7e445c34d	\N
491	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ1Njk0MiwiaWF0IjoxNzY3NDU2NjQyLCJqdGkiOiI5MGNhMzZmNTY0ZjQ0NDk1OTY1NDI5YTJkNTU5NjM5MyIsInVzZXJfaWQiOiI0MSJ9.RhConQo4W8HEHyA9laGFQYj2DzxO9wpa2jTdayW4CII	2026-01-03 16:10:42.448592+00	2026-01-03 16:15:42+00	41	90ca36f564f44495965429a2d5596393	\N
492	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ1ODkzMSwiaWF0IjoxNzY3NDU4NjMxLCJqdGkiOiI4ODdjNDllZmQ1YmI0N2I1OTc5ZjJmYTliZDU5ZjFlZiIsInVzZXJfaWQiOiI0MSJ9.X5HyaHHEGJMMBOsaTC8wicl3dBFHoSgrbKGAEnNTbkk	2026-01-03 16:43:51.446405+00	2026-01-03 16:48:51+00	41	887c49efd5bb47b5979f2fa9bd59f1ef	\N
493	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ2MDg0MSwiaWF0IjoxNzY3NDYwNTQxLCJqdGkiOiI3OWNiN2U2MjMwYWY0YzFkOTc0ZjA3NjExOTY1N2VkYiIsInVzZXJfaWQiOiI0MSJ9.J1uEMvIhCBCZ-9eTVfsn3PLiFnHpFFQgXJaMUu3RNUE	2026-01-03 17:15:41.541999+00	2026-01-03 17:20:41+00	41	79cb7e6230af4c1d974f076119657edb	\N
494	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ2MjczNywiaWF0IjoxNzY3NDYyNDM3LCJqdGkiOiJjY2EyN2E4M2ViYzM0M2NlOWVlNzNmNDA1OGVmNDMzNCIsInVzZXJfaWQiOiIxMyJ9.hD5ad6OCmkBzSdYKKMMC7YXGGzlVV8bGClhXWTC92II	2026-01-03 17:47:17.546574+00	2026-01-03 17:52:17+00	13	cca27a83ebc343ce9ee73f4058ef4334	\N
495	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ2Mjc2MSwiaWF0IjoxNzY3NDYyNDYxLCJqdGkiOiI0ZWZjNTY2NmVlNjY0ZDJkYWMxZDVmNDg2NmQ2ZDk5NCIsInVzZXJfaWQiOiIxMyJ9.LCohO9U1CrmINWGeBHri4d5d-wKlIULn3Osjwzbg84E	2026-01-03 17:47:41.946862+00	2026-01-03 17:52:41+00	13	4efc5666ee664d2dac1d5f4866d6d994	\N
496	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ2MjgyNiwiaWF0IjoxNzY3NDYyNTI2LCJqdGkiOiI3ZDEzOWI4NzgyNWE0ZTYwYTMxNGEzMGY2ZGVhMWZmZCIsInVzZXJfaWQiOiI0MSJ9.1_nCKU9fI3HBxJJwp_lgyaJRQSrEeo0ZPPoLX5mIQf4	2026-01-03 17:48:46.949673+00	2026-01-03 17:53:46+00	41	7d139b87825a4e60a314a30f6dea1ffd	\N
497	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ2MjkwNCwiaWF0IjoxNzY3NDYyNjA0LCJqdGkiOiJlNzk4ZjM4Njg5YWY0MTJjYjI5ZjMyNjlmYjg4MWQ5YyIsInVzZXJfaWQiOiIxMyJ9.U5VcqyR07JoeWaSCopr2LBZVPOuUK2sinL73mRw4r8g	2026-01-03 17:50:04.847255+00	2026-01-03 17:55:04+00	13	e798f38689af412cb29f3269fb881d9c	\N
498	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ2NDU0MywiaWF0IjoxNzY3NDY0MjQzLCJqdGkiOiJhYjM5ZDM3MDM1OTg0NzFkYWVhMmRhYTk1MmFkZDljZSIsInVzZXJfaWQiOiI0MSJ9.ljvc3J3S1dSs5Yt75PS3WlLFzvUN9LAGsotL41LF2ho	2026-01-03 18:17:23.652498+00	2026-01-03 18:22:23+00	41	ab39d3703598471daea2daa952add9ce	\N
499	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ3MDg1NSwiaWF0IjoxNzY3NDcwNTU1LCJqdGkiOiJjNzM2ZTM2YmM0M2E0Mjg5OTkxMDdlMjZmOGVhZDdmYSIsInVzZXJfaWQiOiI0NSJ9.hyrKgDugcCe3Urkgrjpq09Ln9d1EniV2jBJ3JPOVOQ8	2026-01-03 20:02:35.679646+00	2026-01-03 20:07:35+00	45	c736e36bc43a428999107e26f8ead7fa	\N
500	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzQ3MDg3NiwiaWF0IjoxNzY3NDcwNTc2LCJqdGkiOiIwZGI2OGY4NDc1NjY0NTYyYTFmNTYwNzU4NzRhN2NmZiIsInVzZXJfaWQiOiI0NSJ9.uv52ClYLyIYQqseR7uwLB29FAJSnJ-RHQwpoS27LBcY	2026-01-03 20:02:56.705778+00	2026-01-03 20:07:56+00	45	0db68f8475664562a1f56075874a7cff	\N
501	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzUyMTA4NiwiaWF0IjoxNzY3NTIwNzg2LCJqdGkiOiIyZmJmODNlNTc4NTg0Yjk3YWMyOTAyZjQzNjFkNWJmNSIsInVzZXJfaWQiOiIxMyJ9.-ji7N_S8x-duZa-eoqipFjAOAH3ArXDWgM8P_2z6oHk	2026-01-04 09:59:46.769555+00	2026-01-04 10:04:46+00	13	2fbf83e578584b97ac2902f4361d5bf5	\N
502	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzUyMTM1MiwiaWF0IjoxNzY3NTIxMDUyLCJqdGkiOiI2NGVlMjVjOGIzYzM0MDVlODcwMGUyYTViNTNhMGZlMyIsInVzZXJfaWQiOiI0MSJ9.no7jWGQwzsEN19pF9kQaF9-Oxn-5uL-BW5fraA58kdQ	2026-01-04 10:04:12.680782+00	2026-01-04 10:09:12+00	41	64ee25c8b3c3405e8700e2a5b53a0fe3	\N
503	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzUyNDAxMCwiaWF0IjoxNzY3NTIzNzEwLCJqdGkiOiI3MWU3ODY3YzM4NDc0ZTk1YmM1NmE2ZDM5Yzg5MWQ3MCIsInVzZXJfaWQiOiI0NSJ9.8TxcdPMMLcx1uxn9UZhfeNDOtSsIFhiKmALB7mhgNe8	2026-01-04 10:48:30.335283+00	2026-01-04 10:53:30+00	45	71e7867c38474e95bc56a6d39c891d70	\N
504	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzUyNDgxNywiaWF0IjoxNzY3NTI0NTE3LCJqdGkiOiI5NmEzNGZmN2RmM2Q0ZDJmYjRlYmExOGJjNzg2OTcxOCIsInVzZXJfaWQiOiI0MSJ9.JvR_jSCBdC1StkMtyeE10zjG9-m29gCbZ65h33rMdNk	2026-01-04 11:01:57.535463+00	2026-01-04 11:06:57+00	41	96a34ff7df3d4d2fb4eba18bc7869718	\N
505	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzUyNTI3NywiaWF0IjoxNzY3NTI0OTc3LCJqdGkiOiJjYTdhYTg5YzFkZTg0M2JjOWQ5M2ExYTk1OTdkNDU0NiIsInVzZXJfaWQiOiI0NSJ9.Yt-mvAn0dlYGcmvmC9PYYB2PoBZ1fT5XIMcsaaYUyTE	2026-01-04 11:09:37.752787+00	2026-01-04 11:14:37+00	45	ca7aa89c1de843bc9d93a1a9597d4546	\N
506	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzUyNzg1NSwiaWF0IjoxNzY3NTI3NTU1LCJqdGkiOiJkMTc1ZGVlNTU5NzE0NmQ0OGQwNmQ4MjI4ODQyODAxNCIsInVzZXJfaWQiOiI0NSJ9.wdojEkp1ix8yfRZXRbIF764bvHhHuzWo8SXJDXPLlXw	2026-01-04 11:52:35.167362+00	2026-01-04 11:57:35+00	45	d175dee5597146d48d06d82288428014	\N
507	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzUyNzkyMiwiaWF0IjoxNzY3NTI3NjIyLCJqdGkiOiJjNGViMWEwZjI1ZDU0MzE5YmVjNGY5M2ZkMDJlYTFmMSIsInVzZXJfaWQiOiI0MSJ9.C-nIPcixLZ75wkHS3t2UsWOU8CSoYjdzlR-ki0W1KqM	2026-01-04 11:53:42.363507+00	2026-01-04 11:58:42+00	41	c4eb1a0f25d54319bec4f93fd02ea1f1	\N
508	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzUzMDM0NCwiaWF0IjoxNzY3NTMwMDQ0LCJqdGkiOiI2ZDg1MDM0MDk5ZGM0ZGYzYjQ4OWVmY2NlZDBmZTU0NiIsInVzZXJfaWQiOiI0MSJ9.Ncn76_pZY63u2S7pv49T5g77GmiLL77ifarimNSNozA	2026-01-04 12:34:04.343802+00	2026-01-04 12:39:04+00	41	6d85034099dc4df3b489efcced0fe546	\N
509	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzUzMjM0NywiaWF0IjoxNzY3NTMyMDQ3LCJqdGkiOiIwN2I4ZWE0ZWE2OWU0OTFlODY5ZjQwNTg4OWYwMjI3YiIsInVzZXJfaWQiOiI0MSJ9.NzBWvb9PWbXC-JETx5CYOGjCIXvixX7ewrLyeSgfhIg	2026-01-04 13:07:27.541737+00	2026-01-04 13:12:27+00	41	07b8ea4ea69e491e869f405889f0227b	\N
510	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzUzNTY1NiwiaWF0IjoxNzY3NTM1MzU2LCJqdGkiOiI5NTg2MzdjMjZlZWY0MGM2YTA1YzhmZDljYmIyYzVlZCIsInVzZXJfaWQiOiI0MSJ9.ig3uJbYuJk1Co_bpn7EkkjXKkYTdUOjdPKEiJ6D5RCY	2026-01-04 14:02:36.741352+00	2026-01-04 14:07:36+00	41	958637c26eef40c6a05c8fd9cbb2c5ed	\N
511	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU1MzkxNiwiaWF0IjoxNzY3NTUzNjE2LCJqdGkiOiJiOGIyZTZkN2I5ZmY0ZTUyOWRmYjQ5NDgxMDE2ODg3MCIsInVzZXJfaWQiOiI0OSJ9._HcYI0MAj-YdrT2tsMdf9BHSW1U1kKGnE17OdQpMY8k	2026-01-04 19:06:56.856482+00	2026-01-04 19:11:56+00	49	b8b2e6d7b9ff4e529dfb494810168870	\N
512	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3NTU3OTEzLCJpYXQiOjE3Njc1NTQzNzMsImp0aSI6IjE1Yjk2MTllMmI4MDQ5OGFiMWNlMTgwNWU0YzZhNTMyIiwidXNlcl9pZCI6IjQyIn0.BXd3fM84s7XXQRnlnNdTydn0GTMDG4XaRgAYVcDFnPY	2026-01-04 19:19:33.228663+00	2026-01-04 20:18:33+00	42	15b9619e2b80498ab1ce1805e4c6a532	\N
513	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU1NzkxMywiaWF0IjoxNzY3NTU0MzczLCJqdGkiOiJiODJjNzI2YmEwOWE0NjZlOTZhNDY2YTkwZjU5MzM4OCIsInVzZXJfaWQiOiI0MiJ9.qyPia8gxe_jxKe4bLceR7el67oTd35-BT4nn1pCt5Gw	2026-01-04 19:19:33.44967+00	2026-01-04 20:18:33+00	42	b82c726ba09a466e96a466a90f593388	\N
514	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3NTU4MDYyLCJpYXQiOjE3Njc1NTQ1MjIsImp0aSI6IjYyZTUwMzdjMmZlMDRhNjhiMjNjNDUwYjgyYjE2YjZkIiwidXNlcl9pZCI6IjQyIn0.OwsR0-m-5WnKngEJYo-ubxB2B1c9LT5KmqO28yd2JC8	2026-01-04 19:22:02.4475+00	2026-01-04 20:21:02+00	42	62e5037c2fe04a68b23c450b82b16b6d	\N
515	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU1ODA2MiwiaWF0IjoxNzY3NTU0NTIyLCJqdGkiOiJhMzUzYzMyYjA5ZmQ0MjE5YTQ1ZjM5NTc3OTRlZDE0NSIsInVzZXJfaWQiOiI0MiJ9.u29cdaTW3L_fEg2sBFS8Afh3MH8hB6f_WZOvlbV2hJM	2026-01-04 19:22:02.484647+00	2026-01-04 20:21:02+00	42	a353c32b09fd4219a45f3957794ed145	\N
516	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3NTU4ODIxLCJpYXQiOjE3Njc1NTUyODEsImp0aSI6IjkwMGI2YTBkMmQ5NzRkOTA4YjYyMDU2N2M3YWE3ZTY0IiwidXNlcl9pZCI6IjQyIn0.Pzna-vMbc_wuYKmG8ffQsBANQssIQ4FHHCcYxpME12Y	2026-01-04 19:34:41.536105+00	2026-01-04 20:33:41+00	42	900b6a0d2d974d908b620567c7aa7e64	\N
517	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU1ODgyMSwiaWF0IjoxNzY3NTU1MjgxLCJqdGkiOiIxM2VlZWI5NWM2OTI0YTQwYjkwMzczMDA0NzM4YmExNSIsInVzZXJfaWQiOiI0MiJ9.ry1rMVUfXeqWX0xWCogSWWpXkW-4w-0Fm6f26S7hq5I	2026-01-04 19:34:41.580131+00	2026-01-04 20:33:41+00	42	13eeeb95c6924a40b90373004738ba15	\N
518	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU1Njg4NywiaWF0IjoxNzY3NTU2NTg3LCJqdGkiOiIyMDhiYjQ1YzY5ODY0NGVhYmM3NjMxODhiMDlhMzIyOSIsInVzZXJfaWQiOiIxMyJ9.qZ34ZwrxcsLkpuayU0bC7oE7uti44Uf2FwgLqozpUWA	2026-01-04 19:56:27.96922+00	2026-01-04 20:01:27+00	13	208bb45c698644eabc763188b09a3229	\N
519	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3NTYxOTk5LCJpYXQiOjE3Njc1NTg0NTksImp0aSI6IjFiYjU3MjFkZjI2YjQ5MjM4ZTJmNGVhNjlkZTYwZmNlIiwidXNlcl9pZCI6IjEzIn0.qY9qipjK7UX8ZJTcL1j1ObLBQ1Nh4VgJtEQuUOuJcxc	2026-01-04 20:27:39.943879+00	2026-01-04 21:26:39+00	13	1bb5721df26b49238e2f4ea69de60fce	\N
520	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU2MTk5OSwiaWF0IjoxNzY3NTU4NDU5LCJqdGkiOiJmYTU2N2Q5NTczNjQ0ZmFmYmFiYWRiOTdjMjJkZTZkOSIsInVzZXJfaWQiOiIxMyJ9.37KNZmoRzWAAh2ovC-_tn0uNGOSjguXm2M3SjAU6npA	2026-01-04 20:27:39.99034+00	2026-01-04 21:26:39+00	13	fa567d9573644fafbabadb97c22de6d9	\N
521	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU1ODk4MiwiaWF0IjoxNzY3NTU4NjgyLCJqdGkiOiI5MmU4ZWE2YmViZjg0NWEyODQzNGJmMDIxMmI1OWUyZSIsInVzZXJfaWQiOiIxMyJ9.xr49Aim4kI_yIk7KQ_F3AxPOxJyg7cgKAv6olju5G38	2026-01-04 20:31:22.183463+00	2026-01-04 20:36:22+00	13	92e8ea6bebf845a28434bf0212b59e2e	\N
522	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU1OTAwMywiaWF0IjoxNzY3NTU4NzAzLCJqdGkiOiI5ZjBiZjdjNThlZTE0ODAxOTEzYzY4ZmRkZDJhNjViYyIsInVzZXJfaWQiOiI0OSJ9.NcASk_zjSdCzJZFYwgehQ3pW9bYKWcHHSrqQJZZszA4	2026-01-04 20:31:43.188709+00	2026-01-04 20:36:43+00	49	9f0bf7c58ee14801913c68fddd2a65bc	\N
523	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU1OTA3NiwiaWF0IjoxNzY3NTU4Nzc2LCJqdGkiOiIzY2JkM2E1Yjg3ODk0ODg4Yjc2ZGZkYmFmNzk4ZThhYSIsInVzZXJfaWQiOiIxMyJ9.T6Fnr1btjVglZLPC2AmM2mhmwn4fmfiX8TKMvddLZV0	2026-01-04 20:32:56.587934+00	2026-01-04 20:37:56+00	13	3cbd3a5b87894888b76dfdbaf798e8aa	\N
524	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU1OTExNSwiaWF0IjoxNzY3NTU4ODE1LCJqdGkiOiI2Y2ZjOGFhMjg2MDY0ODNhODMwYjUzNGRiYTFjNzg2NSIsInVzZXJfaWQiOiIxMyJ9.mmFi7IoWl563VegVsMNo5fmVtFidISz7eqxUf4pQMbI	2026-01-04 20:33:35.680289+00	2026-01-04 20:38:35+00	13	6cfc8aa28606483a830b534dba1c7865	\N
525	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3NTYyNDY5LCJpYXQiOjE3Njc1NTg5MjksImp0aSI6ImE4YmUxOTJmODI4ZDRmNTU5OGM5OGE0NjI0NWU5MWQwIiwidXNlcl9pZCI6IjEzIn0.qYHh6vSXl6olOVzDkA8ArFDv0JhxKCg-5NAb4zYtwnk	2026-01-04 20:35:29.570721+00	2026-01-04 21:34:29+00	13	a8be192f828d4f5598c98a46245e91d0	\N
526	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU2MjQ2OSwiaWF0IjoxNzY3NTU4OTI5LCJqdGkiOiI0MzY3ODA5NmRlNDY0ZTZjODkyM2MzNjQxN2E3YTExMCIsInVzZXJfaWQiOiIxMyJ9.kxYjZlLI91QPprhk8Is6LyzbV_MaAr_p0K1gLoSdGo8	2026-01-04 20:35:29.601282+00	2026-01-04 21:34:29+00	13	43678096de464e6c8923c36417a7a110	\N
527	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3NTYyNjc3LCJpYXQiOjE3Njc1NTkxMzcsImp0aSI6ImViYzhmMThhM2Y4ZDQ4YjY5MWI0ZjQ1ODkxNGRjMDM4IiwidXNlcl9pZCI6IjEzIn0.JsiWt6tGxe29hN7QvH0gET4K2qlu8f8cTlSy6KgFk00	2026-01-04 20:38:57.274148+00	2026-01-04 21:37:57+00	13	ebc8f18a3f8d48b691b4f458914dc038	\N
528	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU2MjY3NywiaWF0IjoxNzY3NTU5MTM3LCJqdGkiOiI5NjRhYjBjNWQxMjg0ODJiYTg4OTU3ODBiYzdlMzE0YyIsInVzZXJfaWQiOiIxMyJ9.gLgjT8KE0fwR8zH2AbJ-fEL94qq3tjgpA7IF70HCrMk	2026-01-04 20:38:57.302592+00	2026-01-04 21:37:57+00	13	964ab0c5d128482ba8895780bc7e314c	\N
529	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3NTYzNzMzLCJpYXQiOjE3Njc1NjAxOTMsImp0aSI6ImMxMmUxZTI0MThiOTRjZjNhYmUyMTExZDVmZjNkMTI5IiwidXNlcl9pZCI6IjEzIn0.UGOacwBEHeInk62ZG2lMMQHBG4piIyd0eaAe6Ox8PjM	2026-01-04 20:56:33.145692+00	2026-01-04 21:55:33+00	13	c12e1e2418b94cf3abe2111d5ff3d129	\N
530	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU2MzczMywiaWF0IjoxNzY3NTYwMTkzLCJqdGkiOiJlMzk0ZjQ3NWQwOTU0YjY1YTE0MjU3MDI0YjM0M2M1YyIsInVzZXJfaWQiOiIxMyJ9.i4h88qnxOa643pzXYLdmFrD-oJiKC1OBAq19i7HhkaI	2026-01-04 20:56:33.198649+00	2026-01-04 21:55:33+00	13	e394f475d0954b65a14257024b343c5c	\N
531	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU2MDU1NiwiaWF0IjoxNzY3NTYwMjU2LCJqdGkiOiIzZjVjNTA5YTZhNzU0MGNjODE4MDZhZjAyOTZkMWJmOCIsInVzZXJfaWQiOiIxMyJ9.3maGn5QkkgKCGSf7TNrBlIZOud6_cH2-5mtTUJiMBQ4	2026-01-04 20:57:36.888168+00	2026-01-04 21:02:36+00	13	3f5c509a6a7540cc81806af0296d1bf8	\N
532	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3NTYzODM1LCJpYXQiOjE3Njc1NjAyOTUsImp0aSI6IjYwYmY5MmIyN2IzYjQ2NTZhMzI4NWU0NWQwYmM0NmI1IiwidXNlcl9pZCI6IjEzIn0.pNvIUbUfSxRqUoiF2hjjQB--PCGSnhRCioUJbEY2038	2026-01-04 20:58:15.932383+00	2026-01-04 21:57:15+00	13	60bf92b27b3b4656a3285e45d0bc46b5	\N
533	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU2MzgzNSwiaWF0IjoxNzY3NTYwMjk1LCJqdGkiOiJlYWEzNjE1MmFlYmM0NDUwYjJhZDgyN2EzMjU3ZGMwZSIsInVzZXJfaWQiOiIxMyJ9.OAA49FzKib4-DMDifBmwZ6NT-YCC-y2PSkGfTvwdVwo	2026-01-04 20:58:15.957303+00	2026-01-04 21:57:15+00	13	eaa36152aebc4450b2ad827a3257dc0e	\N
534	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzU2NDEwOCwiaWF0IjoxNzY3NTYzODA4LCJqdGkiOiJjZmM1NGYwNjA5ZDg0NTk1OTU2NjBkMmY5MmFkNzljYSIsInVzZXJfaWQiOiI0MSJ9.sKgOXgVeThUEIyjd3CJ8PY7eOLSSMLt5sVo3yvRk7D8	2026-01-04 21:56:48.301504+00	2026-01-04 22:01:48+00	41	cfc54f0609d8459595660d2f92ad79ca	\N
535	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzYwOTExMywiaWF0IjoxNzY3NjA4ODEzLCJqdGkiOiJhZWIzZGFmMmRjYjg0ZDQzYjBkNjQ1YjQ0YTdlMjU1YyIsInVzZXJfaWQiOiIxMyJ9.MtDvGoLeG1i-fMsOrwqJl_PhMpb2klpNM29gjX9HAmU	2026-01-05 10:26:53.418313+00	2026-01-05 10:31:53+00	13	aeb3daf2dcb84d43b0d645b44a7e255c	\N
536	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzYwOTI5NywiaWF0IjoxNzY3NjA4OTk3LCJqdGkiOiJhNmNhYWNjYWQwZTM0YTdlODQ1ZDM4ZjVlNjU0ZDkyNSIsInVzZXJfaWQiOiI0MSJ9.QHQ3D3-5iLYaf-_w_lILGV_WNH6A-Vw7bL1edhUKO8c	2026-01-05 10:29:57.21547+00	2026-01-05 10:34:57+00	41	a6caaccad0e34a7e845d38f5e654d925	\N
537	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3NjEyNjcyLCJpYXQiOjE3Njc2MDkxMzIsImp0aSI6Ijg3MDYyYzRhMmEzNjQ2ZTQ5NzhiZDBkNzBmZjgyNjBlIiwidXNlcl9pZCI6IjEzIn0.oqlY9CBDbUzPSLcGYcxNocMx6HEjYUTP9u9eDK6se3c	2026-01-05 10:32:12.882373+00	2026-01-05 11:31:12+00	13	87062c4a2a3646e4978bd0d70ff8260e	\N
538	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzYxMjY3MiwiaWF0IjoxNzY3NjA5MTMyLCJqdGkiOiIzNzlmNzJjMzJmZGM0Yjc5OGJiNDhkNmM3YmM3NzFkNCIsInVzZXJfaWQiOiIxMyJ9.Ks-MHJ9RN4vIk1p90Hb682Cchm9tIIkNZuE7vY5A6XE	2026-01-05 10:32:12.908098+00	2026-01-05 11:31:12+00	13	379f72c32fdc4b798bb48d6c7bc771d4	\N
539	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzYwOTg4NywiaWF0IjoxNzY3NjA5NTg3LCJqdGkiOiI4YTU2ZTJlNzNlYjY0ZDBjODg1ODM1NmI2ZTJmYmQyYSIsInVzZXJfaWQiOiI0MSJ9.FoUDAjYAbjqHMfaEnbnj5PYNFxsKi7kW1C-t6Rid0JY	2026-01-05 10:39:47.024592+00	2026-01-05 10:44:47+00	41	8a56e2e73eb64d0c8858356b6e2fbd2a	\N
540	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzYzOTk3NywiaWF0IjoxNzY3NjM5Njc3LCJqdGkiOiIzNTE1Yjk4OTFmODg0OWViODgwYTNmYmU0NmY3YjVmMSIsInVzZXJfaWQiOiIxMyJ9.F1oWxPwoR-OIpgQfuzcGj2ptCdB8duAG5qbwggEY0QM	2026-01-05 19:01:17.907263+00	2026-01-05 19:06:17+00	13	3515b9891f8849eb880a3fbe46f7b5f1	\N
541	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY0MDA1OCwiaWF0IjoxNzY3NjM5NzU4LCJqdGkiOiI4MDM3MzdmZmE3ZmQ0MTBkYWIwNjE2ZTljMjE4ODVlNCIsInVzZXJfaWQiOiIxMyJ9.HSgDP-t8wCps_kqZfvw7YaRnFiot2gxzWtqcvIE0mE8	2026-01-05 19:02:38.608949+00	2026-01-05 19:07:38+00	13	803737ffa7fd410dab0616e9c21885e4	\N
542	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY0MjU4MywiaWF0IjoxNzY3NjQyMjgzLCJqdGkiOiJiZWQ0ZjNmMDA1MDM0ZDQ0YTM4N2IwMDhjZmM2ZDFmYSIsInVzZXJfaWQiOiIxMyJ9.rnhKpahBRZDCYbWn4EEgzaIwQxgOfiopG47oWqYy_-k	2026-01-05 19:44:43.997019+00	2026-01-05 19:49:43+00	13	bed4f3f005034d44a387b008cfc6d1fa	\N
543	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY0MzcwNywiaWF0IjoxNzY3NjQzNDA3LCJqdGkiOiI0NWVhNGZlMDUxMTk0YjJiYjZmNjFkMGExZjIwODVjMyIsInVzZXJfaWQiOiIxMyJ9.YrC3YYeC2wTgjqWLCo4V-q1ev23ZoiQ-jQSPjFx_KSA	2026-01-05 20:03:27.008742+00	2026-01-05 20:08:27+00	13	45ea4fe051194b2bb6f61d0a1f2085c3	\N
544	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY0NDA1NywiaWF0IjoxNzY3NjQzNzU3LCJqdGkiOiJlYjhjMjUyMjcyOTA0YjhkODMwMGE3YzkxZTk2ZTM1YiIsInVzZXJfaWQiOiIxMyJ9.YMJv2pPOA_InRNzqchE8mdgGQtOxKEykMHsZ09Zg-_0	2026-01-05 20:09:17.999621+00	2026-01-05 20:14:17+00	13	eb8c252272904b8d8300a7c91e96e35b	\N
545	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY0NDU4NSwiaWF0IjoxNzY3NjQ0Mjg1LCJqdGkiOiI3ZmQ4Mzg4MWYxMTc0OWUyODg4OGU1MTljOWNmNjU5MyIsInVzZXJfaWQiOiI0MSJ9.oWbIIcNs8T2LBrn6NQWOhBD93YA2hlVXdw6JzUM1LCU	2026-01-05 20:18:05.196737+00	2026-01-05 20:23:05+00	41	7fd83881f11749e28888e519c9cf6593	\N
546	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY0NzI4MSwiaWF0IjoxNzY3NjQ2OTgxLCJqdGkiOiI1YzljMGZlZDcyYTU0MzI5OTUxMTQyYmFiODlkOWU4YSIsInVzZXJfaWQiOiI0MSJ9.oEkekXe2nMo04TRlYGDwSGdJVXjxb1GvJYOIVYXEYVc	2026-01-05 21:03:01.799568+00	2026-01-05 21:08:01+00	41	5c9c0fed72a54329951142bab89d9e8a	\N
547	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY0ODQ2OSwiaWF0IjoxNzY3NjQ4MTY5LCJqdGkiOiI4ZTkyZTBiYTA0MDU0YmY2YjgxNWIwYzViMDY1ZDVjYiIsInVzZXJfaWQiOiI0MSJ9.xCyjnVqUUB1XtJuBiFj1KnoOtesBmDfbfkCEqsgnf5w	2026-01-05 21:22:49.39529+00	2026-01-05 21:27:49+00	41	8e92e0ba04054bf6b815b0c5b065d5cb	\N
548	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY0OTcyOCwiaWF0IjoxNzY3NjQ5NDI4LCJqdGkiOiIxM2VlZDU5ODQ4NGM0ZWU4OWI1ODE2YTM1MWUwZmEzYyIsInVzZXJfaWQiOiI0MSJ9.WUDFa4OuIChW-XwojiTRLaT8_F_5ezntFmoWOTz81fY	2026-01-05 21:43:48.697832+00	2026-01-05 21:48:48+00	41	13eed598484c4ee89b5816a351e0fa3c	\N
549	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY1MDI1MCwiaWF0IjoxNzY3NjQ5OTUwLCJqdGkiOiIwNzBmZTFiNGMzOWU0ZmU0YTUwNTZlODNjODg0ZDkyZiIsInVzZXJfaWQiOiI0MSJ9.1LHquVQPhKIo7IBZ2JETL9THDoet37u3PeTOc2iCbH4	2026-01-05 21:52:30.697278+00	2026-01-05 21:57:30+00	41	070fe1b4c39e4fe4a5056e83c884d92f	\N
550	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY1MDYxMywiaWF0IjoxNzY3NjUwMzEzLCJqdGkiOiJiNWU3NWI0MGZjNTM0MWQ5YTkyMzEyNTAwMjk3MDk0MyIsInVzZXJfaWQiOiI0MSJ9.YJOPdiwiTJyAemEb5NihP3TxFmbwSQTqMQRXY5hxdf4	2026-01-05 21:58:33.806005+00	2026-01-05 22:03:33+00	41	b5e75b40fc5341d9a923125002970943	\N
551	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY1MTQzNiwiaWF0IjoxNzY3NjUxMTM2LCJqdGkiOiJmZGQ3YTVjYTdkNGM0YWFiYWQ3NDdlYTlmOTk1ZjBiMyIsInVzZXJfaWQiOiI0MSJ9.0KAcVcv-WlvUW7OTrC5JKIX2d4RiyAnDkH1slyULUjc	2026-01-05 22:12:16.700054+00	2026-01-05 22:17:16+00	41	fdd7a5ca7d4c4aabad747ea9f995f0b3	\N
552	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY4ODQxNSwiaWF0IjoxNzY3Njg4MTE1LCJqdGkiOiIxODcxMDUzY2E4ZjI0Y2RhYjhiMzY2ZjIwMDE5MmQ4YSIsInVzZXJfaWQiOiIxMyJ9.0cRlRi19O6UWrQJbW-bucpYDiEwqLxFDrTdj-VMP480	2026-01-06 08:28:35.038598+00	2026-01-06 08:33:35+00	13	1871053ca8f24cdab8b366f200192d8a	\N
553	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY5MTUxMywiaWF0IjoxNzY3NjkxMjEzLCJqdGkiOiIwNWY4Zjg3OTYzMjY0MGU2ODkzN2MzY2UyNzRiMDk4OSIsInVzZXJfaWQiOiIxMyJ9._aVXysjdCakzvcq82FsJAbM0h8NvegPnmdZuh2E0pP0	2026-01-06 09:20:13.070127+00	2026-01-06 09:25:13+00	13	05f8f879632640e68937c3ce274b0989	\N
554	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY5Mzc1NSwiaWF0IjoxNzY3NjkzNDU1LCJqdGkiOiIzMWNiMWFjNjU0MDU0NTZiODljNWIwM2E5ZWExMTUyMSIsInVzZXJfaWQiOiIxMyJ9.tLBpP9uJA0EnIYtn3sMrAwf1fpMJ7wZhHS9fJtNs7_E	2026-01-06 09:57:35.368672+00	2026-01-06 10:02:35+00	13	31cb1ac65405456b89c5b03a9ea11521	\N
555	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY5NDc5NCwiaWF0IjoxNzY3Njk0NDk0LCJqdGkiOiI1ZGJjNjRiOGQzZWM0M2Q2OTY5OTBjOTQzMGE0ODA3OCIsInVzZXJfaWQiOiIxMyJ9.flFmg7kUaYNNmAnzt0_mYHvNqILr3vQnyRwqn9T90s8	2026-01-06 10:14:54.377787+00	2026-01-06 10:19:54+00	13	5dbc64b8d3ec43d696990c9430a48078	\N
556	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY5NzI4MiwiaWF0IjoxNzY3Njk2OTgyLCJqdGkiOiJjNzFiNzA0NDg3NGI0YjRjOWM5ODU2NWFhNTU0NjQxNiIsInVzZXJfaWQiOiIxMyJ9.uHR8-IbVYTiAlEgJSvTjC98z2ArxGvmAueL1YbXatJ4	2026-01-06 10:56:22.472093+00	2026-01-06 11:01:22+00	13	c71b7044874b4b4c9c98565aa5546416	\N
557	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzY5OTgxMiwiaWF0IjoxNzY3Njk5NTEyLCJqdGkiOiJjNDM1Y2ZlYWE0NjY0NjFiODIyZmUwMDAzZmRiMzNlYyIsInVzZXJfaWQiOiIxMyJ9.AYbyqTbUj1TkjzJt9lIW6shcH-orOM7C3byJeUkIO-s	2026-01-06 11:38:32.275787+00	2026-01-06 11:43:32+00	13	c435cfeaa466461b822fe0003fdb33ec	\N
558	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzcwMDQzNSwiaWF0IjoxNzY3NzAwMTM1LCJqdGkiOiJlNTQ1NmIyMjI4ZjI0OTFhYjgxODY4MGRkMmFhNzdlOCIsInVzZXJfaWQiOiI0MSJ9.mJBf_8sWLbJjFyOBStIwfeMdlJGOTzFJVafOfPUyMOI	2026-01-06 11:48:55.077738+00	2026-01-06 11:53:55+00	41	e5456b2228f2491ab818680dd2aa77e8	\N
559	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NzcwMDcxNiwiaWF0IjoxNzY3NzAwNDE2LCJqdGkiOiIwOWNlYzE1NTdlZTY0ZDQwODY1NTU3ZjM2ZDJiNWVlMCIsInVzZXJfaWQiOiIxMyJ9.drxSBI2WTMNwinlZY5M_Mf79bgpVH20jg5W8PSfzcuo	2026-01-06 11:53:36.477335+00	2026-01-06 11:58:36+00	13	09cec1557ee64d40865557f36d2b5ee0	\N
560	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIwNjg0MSwiaWF0IjoxNzY3Nzc0ODQxLCJqdGkiOiJhOWQzZmViY2YxOGI0NjEwYTQ1YzExZDI1YjlhYTY4NCIsInVzZXJfaWQiOiIxMyJ9.BV6DISoVNqBmxip5j5s9Rni4dQ5FhLNyX5wyl7Rac8c	2026-01-07 08:34:01.634342+00	2026-01-12 08:34:01+00	13	a9d3febcf18b4610a45c11d25b9aa684	\N
561	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIxNDIyOSwiaWF0IjoxNzY3NzgyMjI5LCJqdGkiOiI5NTVmM2E0OTY1Y2I0M2FhYTc3MjA3NzNkMDFiM2FmMSIsInVzZXJfaWQiOiIxMyJ9.th9uImd_6HqulSnOlAL33uTGrurrR2FZlgQbIWu9Nao	2026-01-07 10:37:09.921917+00	2026-01-12 10:37:09+00	13	955f3a4965cb43aaa7720773d01b3af1	\N
562	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIxNDM4MSwiaWF0IjoxNzY3NzgyMzgxLCJqdGkiOiIxZGY1YTkwMWE2MGI0MjI3OTM1NmZjZTkxMDc3MTUzYSIsInVzZXJfaWQiOiI0MSJ9.pNOe1OOxUmD1PpinpaaDYg3g6IZPNVmup84X3kS67Ko	2026-01-07 10:39:41.889864+00	2026-01-12 10:39:41+00	41	1df5a901a60b42279356fce91077153a	\N
563	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIxNzQwMiwiaWF0IjoxNzY3Nzg1NDAyLCJqdGkiOiI5MDdkNjNjOGY5ZTA0MjMwYjY5MjIzMjNiMzMxMjZiNyIsInVzZXJfaWQiOiI0MSJ9.J4mKHx3O38ZinBur-R_8aB_G337cs1wg-uUm6PsSjVg	2026-01-07 11:30:02.891426+00	2026-01-12 11:30:02+00	41	907d63c8f9e04230b6922323b33126b7	\N
564	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY3Nzg5MDEzLCJpYXQiOjE3Njc3ODU0NzMsImp0aSI6IjJiNjc1NWUxZjUyODQzOThiOTRmMGI4MjlmZDgyZmQ2IiwidXNlcl9pZCI6IjEzIn0.nCXzOyz15EXN3RKI5IrYcuAWB81LI-if-d35qHoH_rw	2026-01-07 11:31:13.761257+00	2026-01-07 12:30:13+00	13	2b6755e1f5284398b94f0b829fd82fd6	\N
565	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2Nzc4OTAxMywiaWF0IjoxNzY3Nzg1NDczLCJqdGkiOiJmNjU4MTI4N2Q0ZjY0NzI2ODhhNmZjMWY2OGQyODM5NyIsInVzZXJfaWQiOiIxMyJ9.wdhWHHGQylZ5mNkOGUfG7FSXAttCmsXgIgQ42F0FNQQ	2026-01-07 11:31:13.792338+00	2026-01-07 12:30:13+00	13	f6581287d4f6472688a6fc1f68d28397	\N
566	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIyMDk0NywiaWF0IjoxNzY3Nzg4OTQ3LCJqdGkiOiJiZGEyZDAxN2YxY2U0OWZlYjAxNDVhZDcxNGMyYWQ4MSIsInVzZXJfaWQiOiIxMyJ9.hxa-L6ZmYaJx7k-z8trRJXjXI2BRLWO6UxZqGCyV0U8	2026-01-07 12:29:07.132653+00	2026-01-12 12:29:07+00	13	bda2d017f1ce49feb0145ad714c2ad81	\N
567	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIyNDUwNCwiaWF0IjoxNzY3NzkyNTA0LCJqdGkiOiJkOTc1MTcyYTY0Y2E0ZTI1OGY2OTEyZDU3YTI3OTE0MSIsInVzZXJfaWQiOiIxMyJ9.g150dr9uxZY6x2YdH1BubIX_Z9famQ_7AoEAAHITik4	2026-01-07 13:28:24.374881+00	2026-01-12 13:28:24+00	13	d975172a64ca4e258f6912d57a279141	\N
568	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIyNDcyOCwiaWF0IjoxNzY3NzkyNzI4LCJqdGkiOiIzZmFjOTNmYTg4ODQ0MzI1YjIxNzYxZTk3ODY1NDQwMyIsInVzZXJfaWQiOiIxMyJ9.x0gJ0rdkca1DjLvCUE87LHIpe-5nwvCGxSsFFkoqnBw	2026-01-07 13:32:08.279743+00	2026-01-12 13:32:08+00	13	3fac93fa88844325b21761e978654403	\N
569	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIyNDk0MywiaWF0IjoxNzY3NzkyOTQzLCJqdGkiOiI0ZTI5NDVkNDYzNzg0MThhOTE2ZTdhZjEyZmEwODQ2NyIsInVzZXJfaWQiOiIxMyJ9.iRnYuQfrE4FLNgIIPffa49OgTtMwjjNOFQKEnCAgk8Q	2026-01-07 13:35:43.478942+00	2026-01-12 13:35:43+00	13	4e2945d46378418a916e7af12fa08467	\N
570	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIyNTU2NywiaWF0IjoxNzY3NzkzNTY3LCJqdGkiOiJmMzY5MmMwNjk1NDA0ZjQyYjBlMzE2YjdhYTRhNzU0OSIsInVzZXJfaWQiOiIxMyJ9.tPXVm15ZhOlcZiLiAj05OQVrLvXZiGFeTLsVHB1mVGc	2026-01-07 13:46:07.782304+00	2026-01-12 13:46:07+00	13	f3692c0695404f42b0e316b7aa4a7549	\N
571	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIyNzQwMSwiaWF0IjoxNzY3Nzk1NDAxLCJqdGkiOiIyYWUyODk4MGMxOWY0MGQ1OTg1ZWYyYTlmMDkyM2VlOCIsInVzZXJfaWQiOiIxMyJ9.rtKMaC5iBSH0mI5VpMrW6KaTvoFlmFULB5-emMbtdus	2026-01-07 14:16:41.430036+00	2026-01-12 14:16:41+00	13	2ae28980c19f40d5985ef2a9f0923ee8	\N
572	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIyOTIxNSwiaWF0IjoxNzY3Nzk3MjE1LCJqdGkiOiIwOTkxMGU1NDg2Yjk0MWNmOGJkMmZiNDU0YWU0NzY5YSIsInVzZXJfaWQiOiIxMyJ9.dxffpYkWjdG0FhYLxsrPrmblO5lp6KQeqEDk_5Qg5GA	2026-01-07 14:46:55.971683+00	2026-01-12 14:46:55+00	13	09910e5486b941cf8bd2fb454ae4769a	\N
573	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIzMTAyNSwiaWF0IjoxNzY3Nzk5MDI1LCJqdGkiOiI5NGE3YTc2NGNlN2U0Mjg2OWIxMWNhOTMzNDA5ZmRiNyIsInVzZXJfaWQiOiI0MSJ9.Sz3uMmuPr_uM-HmMZhn7S48JcmXJOq8bXHPk0FGJjYQ	2026-01-07 15:17:05.886265+00	2026-01-12 15:17:05+00	41	94a7a764ce7e42869b11ca933409fdb7	\N
574	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIzMTQxMSwiaWF0IjoxNzY3Nzk5NDExLCJqdGkiOiI3MGM0NmNiNjdlOWY0ZTM0YWU0MTM4Mzg0ZTc0YTU4NyIsInVzZXJfaWQiOiIxMyJ9.qBT5EDDrxTBvocNpeI-Coq5_pKB8lBosG51ClPBD6YM	2026-01-07 15:23:31.709384+00	2026-01-12 15:23:31+00	13	70c46cb67e9f4e34ae4138384e74a587	\N
575	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIzMjgyOCwiaWF0IjoxNzY3ODAwODI4LCJqdGkiOiIwYWQxZDU0YjRkMjQ0ZTI0YTI4M2E3YmRiOWViYjM5OCIsInVzZXJfaWQiOiI0MSJ9.Ux2zMoKzfRuB_VNnV1usajkDeUm4VFN2loUnjMQlkS0	2026-01-07 15:47:08.472853+00	2026-01-12 15:47:08+00	41	0ad1d54b4d244e24a283a7bdb9ebb398	\N
576	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIzNDMyNCwiaWF0IjoxNzY3ODAyMzI0LCJqdGkiOiI5OWU2NjQxZTUyZTI0MmM4YjA0YWUwNDE2NDdhZDRlNCIsInVzZXJfaWQiOiI0MSJ9.a4INIqy2YBwcpgsq8sPOmRvoHL_jkQWJJO8qphcJgfY	2026-01-07 16:12:04.419719+00	2026-01-12 16:12:04+00	41	99e6641e52e242c8b04ae041647ad4e4	\N
577	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIzNjE0NSwiaWF0IjoxNzY3ODA0MTQ1LCJqdGkiOiJmMGVmYzg4M2FkOGI0MDExYmM0MDczNzAxNDUxMDg0MyIsInVzZXJfaWQiOiI0MSJ9.ImOJU2nTBLafJqTSh5oTsV9A0Rye6jhLDCpKdD_PmOM	2026-01-07 16:42:25.215362+00	2026-01-12 16:42:25+00	41	f0efc883ad8b4011bc40737014510843	\N
578	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIzODA2MSwiaWF0IjoxNzY3ODA2MDYxLCJqdGkiOiIyZmE4NTM2NjliNjI0MzQ3OTQ3MTFkNjU4M2ZkMDY2MyIsInVzZXJfaWQiOiI0MSJ9.EG9rRRjJl8JCofc_rFiwrhPy0XPxuxz81bN7UGpeH3Y	2026-01-07 17:14:21.687057+00	2026-01-12 17:14:21+00	41	2fa853669b62434794711d6583fd0663	\N
579	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODIzOTg4NywiaWF0IjoxNzY3ODA3ODg3LCJqdGkiOiIxODI5ZDdkM2I1YjY0YWEzYTM2MzVhZGIwYjJkY2EwYyIsInVzZXJfaWQiOiI0MSJ9.U8RCmZduvd2t28x2F_UvsAfotnie4YsANvqjDORNYd8	2026-01-07 17:44:47.089221+00	2026-01-12 17:44:47+00	41	1829d7d3b5b64aa3a3635adb0b2dca0c	\N
580	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODM5OTUwNiwiaWF0IjoxNzY3OTY3NTA2LCJqdGkiOiIwZGJmOGVkMWYwY2Y0ZGJiYTQyNzc2MDcwMzkxMGM0MiIsInVzZXJfaWQiOiI0MSJ9.fSTO022l-x9o7awlJapDg_PW7SYm401jiZ90RW5g0mo	2026-01-09 14:05:06.355266+00	2026-01-14 14:05:06+00	41	0dbf8ed1f0cf4dbba427760703910c42	\N
581	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODM5OTU0NywiaWF0IjoxNzY3OTY3NTQ3LCJqdGkiOiI2NzRmM2UzYzk2OWU0MzkzYWVjMDY4ZTM2ODYxMWFiMyIsInVzZXJfaWQiOiI0MSJ9.nAymJFxNWJEolF97PM6X9XJ6LDQ-LNGynj-OwYjr69k	2026-01-09 14:05:47.133054+00	2026-01-14 14:05:47+00	41	674f3e3c969e4393aec068e368611ab3	\N
582	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODQwMTQwOCwiaWF0IjoxNzY3OTY5NDA4LCJqdGkiOiI3YTVhZDVlMWRkYmQ0NGRjODY0YzY0NTQwZmMxYWNhYyIsInVzZXJfaWQiOiI0MSJ9.SfY5_B0AswzcNBdNQtBCx8JmTwywAtbnOoLyPj3Uyd4	2026-01-09 14:36:48.2627+00	2026-01-14 14:36:48+00	41	7a5ad5e1ddbd44dc864c64540fc1acac	\N
583	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODQwMzI0MiwiaWF0IjoxNzY3OTcxMjQyLCJqdGkiOiJiMDc5MDA3NzRjMzA0OTFiODEwNzFhYmYwNjM2ODY4MCIsInVzZXJfaWQiOiI0MSJ9.PoBG_DmpLWzkOUv1Au0A9eSRCg1PuHiq3Qes13PaCvQ	2026-01-09 15:07:22.904701+00	2026-01-14 15:07:22+00	41	b07900774c30491b81071abf06368680	\N
584	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY4MDg1MzUzLCJpYXQiOjE3NjgwODE4MTMsImp0aSI6IjkxNjE5YjBiNmNkMzRmN2NhYTAwNTU5N2IyYTI3YjVmIiwidXNlcl9pZCI6IjEzIn0.RJ1W6SNlhbJsl1zrMfiPsBYnPirsDVFfKvUKWyLaIm0	2026-01-10 21:50:13.309359+00	2026-01-10 22:49:13+00	13	91619b0b6cd34f7caa005597b2a27b5f	\N
585	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODA4NTM1MywiaWF0IjoxNzY4MDgxODEzLCJqdGkiOiI5NDQ0MGFmNzMzYjU0ZDdmOTBmOGY1YzI1OTE2NTRhMiIsInVzZXJfaWQiOiIxMyJ9.qoT2_r1Pp9-TYYYgG2HZgPA0t_OAw2W0ye8EIHQLr7U	2026-01-10 21:50:13.495979+00	2026-01-10 22:49:13+00	13	94440af733b54d7f90f8f5c2591654a2	\N
586	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY4MDg1MzUzLCJpYXQiOjE3NjgwODE4MTMsImp0aSI6IjAxYzcwYjQ4ZGJiMjQxNGE4N2Y3MjQ2N2QxNDE5MTkxIiwidXNlcl9pZCI6IjEzIn0.r4P1jVBPqrXWk7jJuM9ZlBD9wNxHTzafF0xZNozJTcQ	2026-01-10 21:50:13.972576+00	2026-01-10 22:49:13+00	13	01c70b48dbb2414a87f72467d1419191	\N
587	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODA4NTM1NCwiaWF0IjoxNzY4MDgxODE0LCJqdGkiOiI1Y2M3NTg3MGY5Y2Q0Y2JjODkwMGIxNTNiZTIxZmJhMyIsInVzZXJfaWQiOiIxMyJ9.P51O6Tb93N7tkxgTu_2yeAxRByKdsegztEhW1kWbaxQ	2026-01-10 21:50:14.003098+00	2026-01-10 22:49:14+00	13	5cc75870f9cd4cbc8900b153be21fba3	\N
588	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODU2Mjg5MywiaWF0IjoxNzY4MTMwODkzLCJqdGkiOiJjYmI3NWY5NTk1NjA0NWExYTNmMmE0NTc0ZWQ0NGNhYiIsInVzZXJfaWQiOiIxMyJ9.4YBrNaDJnodNKZheqxIggfe7BXZxLulO_rGJ612j74I	2026-01-11 11:28:13.444055+00	2026-01-16 11:28:13+00	13	cbb75f95956045a1a3f2a4574ed44cab	\N
589	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODU2Mjg5NiwiaWF0IjoxNzY4MTMwODk2LCJqdGkiOiJkYjQxZTdmYjRkMWM0MmE3OTljZjY3OGEzZjU2N2JlNSIsInVzZXJfaWQiOiIxMyJ9.5tBmeHKSifdvOeHr2M28hAlWcjOjOkiqJcNj1PqVGbw	2026-01-11 11:28:16.585165+00	2026-01-16 11:28:16+00	13	db41e7fb4d1c42a799cf678a3f567be5	\N
590	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY4MTM0NDU3LCJpYXQiOjE3NjgxMzA5MTcsImp0aSI6ImQ3ZGVmNGE3NzIxMTRjY2E4MTJlZmI2NDY3ZWY3ZDljIiwidXNlcl9pZCI6IjEzIn0.KyceqgwdwHPwl7XUc-qgLgoWc0Ppr_xDtD793vx1vkw	2026-01-11 11:28:37.207184+00	2026-01-11 12:27:37+00	13	d7def4a772114cca812efb6467ef7d9c	\N
591	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODEzNDQ1NywiaWF0IjoxNzY4MTMwOTE3LCJqdGkiOiI5MzdkNzNmYzJmMGU0YTAwYWE2YjYwZDgyNWE3MmE2MCIsInVzZXJfaWQiOiIxMyJ9.WLrxJyIZWUBNp5gXJgIqkrUv9ujAgLvmNtDggFSN55s	2026-01-11 11:28:37.233356+00	2026-01-11 12:27:37+00	13	937d73fc2f0e4a00aa6b60d825a72a60	\N
592	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODU2Mzg5OSwiaWF0IjoxNzY4MTMxODk5LCJqdGkiOiIzM2Q3YjdhOGFjMDc0ZWFlYjJmMmFkMDZkZjNkNzFjNSIsInVzZXJfaWQiOiI0MSJ9.Sti4rnfjsCzPixPvwLq0deNbtAFbjH8vOe-8fCZOOVQ	2026-01-11 11:44:59.084272+00	2026-01-16 11:44:59+00	41	33d7b7a8ac074eaeb2f2ad06df3d71c5	\N
593	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY4MTM1NTE0LCJpYXQiOjE3NjgxMzE5NzQsImp0aSI6ImViMDU0ZThkY2U2MTQzNDhiNDc0NTQxNWQ0MGRkOTJmIiwidXNlcl9pZCI6IjEzIn0.JA8QltqS0z411LR3Twv0YTLxPqpkGo2G6Kp2JJt5tMM	2026-01-11 11:46:14.338457+00	2026-01-11 12:45:14+00	13	eb054e8dce614348b4745415d40dd92f	\N
594	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODEzNTUxNCwiaWF0IjoxNzY4MTMxOTc0LCJqdGkiOiIwMjUxMzc4MTJhNTI0ODQwODEyMDQ1ODI5ZjFlMjM4OSIsInVzZXJfaWQiOiIxMyJ9.JepdjqTztmba-OW28Kntli8ZPwo5WZKuVMdFmBNwsqQ	2026-01-11 11:46:14.362558+00	2026-01-11 12:45:14+00	13	025137812a524840812045829f1e2389	\N
595	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY4MTM1NTk0LCJpYXQiOjE3NjgxMzIwNTQsImp0aSI6ImM0NDczMTk5NTRkNTRlMjA5MmQ3NDY4MGZhYjNmMDgxIiwidXNlcl9pZCI6IjEzIn0.FNggY_qp-jDXGGX5j3bxysfoSEBV4RxnuuLuOtkdZWA	2026-01-11 11:47:34.009237+00	2026-01-11 12:46:34+00	13	c447319954d54e2092d74680fab3f081	\N
596	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODEzNTU5NCwiaWF0IjoxNzY4MTMyMDU0LCJqdGkiOiI1Y2JjYzA2YTMwNzk0YzNlYTYwZWI5ZGM4ZDI0YmVlNSIsInVzZXJfaWQiOiIxMyJ9.qrX8AiTTGHw9BKjNp8esvvd4eTgEqZkKLJTu64QwEAs	2026-01-11 11:47:34.038807+00	2026-01-11 12:46:34+00	13	5cbcc06a30794c3ea60eb9dc8d24bee5	\N
597	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY4NTczMzY2LCJpYXQiOjE3Njg1Njk4MjYsImp0aSI6IjZlNDgzNmY1MmZhMjQwOTM5ZjdiZWI4MmEzOWI3OWY4IiwidXNlcl9pZCI6IjEzIn0.TwfPplFJMm3xgelQ9HIJAVvYq3maX6h3NPw6VN1exFo	2026-01-16 13:23:46.257658+00	2026-01-16 14:22:46+00	13	6e4836f52fa240939f7beb82a39b79f8	\N
598	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2ODU3MzM2NiwiaWF0IjoxNzY4NTY5ODI2LCJqdGkiOiJhY2VlMTdkMzY4NmM0Y2Y5OTlkZDE2YmU0NzE5M2NmNSIsInVzZXJfaWQiOiIxMyJ9.zTBpuVw9h5BGNt5mz1wDR_kntG-i2945bi2932NShfM	2026-01-16 13:23:46.532958+00	2026-01-16 14:22:46+00	13	acee17d3686c4cf999dd16be47193cf5	\N
599	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY5NjA4MDk2LCJpYXQiOjE3Njk2MDQ1NTYsImp0aSI6IjQzYWRlMWU4YWNjYzRjZjJiYjMzMmFiZDFlYjQxZDYyIiwidXNlcl9pZCI6IjEzIn0.GFjv5D-2TgHM6Jqdwn3hL1c202s7ycY_rja6UdYcvjI	2026-01-28 12:49:16.076005+00	2026-01-28 13:48:16+00	13	43ade1e8accc4cf2bb332abd1eb41d62	\N
600	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTYwODA5NiwiaWF0IjoxNzY5NjA0NTU2LCJqdGkiOiI0MzYxY2NkN2Y2NTA0MDY4YmM1YWIwMDNiN2M3ZTQ1OCIsInVzZXJfaWQiOiIxMyJ9.6R8CMCHqCgAs9W1IMyrKL4Jve78RFdMH6o6J6Rold7g	2026-01-28 12:49:16.250149+00	2026-01-28 13:48:16+00	13	4361ccd7f6504068bc5ab003b7c7e458	\N
601	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY5NjA4MTAwLCJpYXQiOjE3Njk2MDQ1NjAsImp0aSI6Ijc1YTAwMDYyMTk0NTQ4NjE5ZmQ0ZTAzNDZjMTVlZWQ2IiwidXNlcl9pZCI6IjEzIn0.j9An5-8akQf3fsm0q3VtjPD7aCe18MXGQCs3okZZmOc	2026-01-28 12:49:20.261365+00	2026-01-28 13:48:20+00	13	75a00062194548619fd4e0346c15eed6	\N
602	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTYwODEwMCwiaWF0IjoxNzY5NjA0NTYwLCJqdGkiOiI0NDhjMGIwNmJmZGI0YTI5OWQ3NmE3MmQyMjQ0MjNjYSIsInVzZXJfaWQiOiIxMyJ9.6ZQdycL_GozotA_uPkZpRF3qoKATm--vAvTWx-NaHig	2026-01-28 12:49:20.287964+00	2026-01-28 13:48:20+00	13	448c0b06bfdb4a299d76a72d224423ca	\N
603	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDEwNDg5MSwiaWF0IjoxNzY5NjcyODkxLCJqdGkiOiI2OThkMmE0MDRhYTk0ZDUwYTExNTgwY2JlMmE2NjczOCIsInVzZXJfaWQiOiI0MSJ9.WZvW2yIUf0fYljqBD-m3plC6v0MCxl_d-3b9jpWoVwk	2026-01-29 07:48:11.411963+00	2026-02-03 07:48:11+00	41	698d2a404aa94d50a11580cbe2a66738	\N
604	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDEwNzc4NiwiaWF0IjoxNzY5Njc1Nzg2LCJqdGkiOiJjNGYwODA0N2ZmZmU0NDU0ODI0NzFhOWQzZmMwMDAxZiIsInVzZXJfaWQiOiI0MSJ9.ckcVkM5SMD6ohoZmMdUOaz3j3FyBUiF-7CVT_68Esxg	2026-01-29 08:36:26.144947+00	2026-02-03 08:36:26+00	41	c4f08047fffe445482471a9d3fc0001f	\N
605	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDExMjQwOSwiaWF0IjoxNzY5NjgwNDA5LCJqdGkiOiJiYWNlNjIzZmJmNmE0MTZlYjEyYzQ3NDIzZjUzMjM4NiIsInVzZXJfaWQiOiI0MSJ9.uyL7AsC7PboWYTgOQ4gAhgHzC6T8DfC_s2GLDISXY_0	2026-01-29 09:53:29.395534+00	2026-02-03 09:53:29+00	41	bace623fbf6a416eb12c47423f532386	\N
606	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY5Njg2MDg0LCJpYXQiOjE3Njk2ODI1NDQsImp0aSI6Ijk4OTFhN2VkNzBmNzQwODhiZWJjNjQzNmQ0MzEwM2M2IiwidXNlcl9pZCI6IjEzIn0.yqt3pkFEQZx0XDrh67TyzwxKUmlQzEn8HnL91E7VK9w	2026-01-29 10:29:04.611221+00	2026-01-29 11:28:04+00	13	9891a7ed70f74088bebc6436d43103c6	\N
607	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTY4NjA4NCwiaWF0IjoxNzY5NjgyNTQ0LCJqdGkiOiJlOTFiMGJiNzU3ZGU0MzVmOWE0MGIyMjY0NTYwYTgxZSIsInVzZXJfaWQiOiIxMyJ9.1-ubZpK4y2GJnZaV15n8bq0dq7hnB-0NLx2-eWrhVEI	2026-01-29 10:29:04.799207+00	2026-01-29 11:28:04+00	13	e91b0bb757de435f9a40b2264560a81e	\N
608	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDEzMTIyMSwiaWF0IjoxNzY5Njk5MjIxLCJqdGkiOiJiNzhjOWNiODA0MGM0ZTZjOGQ5ZmM0MTQxZDQ5MDI0MiIsInVzZXJfaWQiOiI0MSJ9.ADoScXmBRMIpIrDykK8ZUmGJ9ayUVmiHommJ1VTneGg	2026-01-29 15:07:01.313578+00	2026-02-03 15:07:01+00	41	b78c9cb8040c4e6c8d9fc4141d490242	\N
609	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDEzNDU1MywiaWF0IjoxNzY5NzAyNTUzLCJqdGkiOiJhOTJjNWQxNTQwYTY0ZmI5YjVjN2ExNzMwOTQ3MWQzYyIsInVzZXJfaWQiOiI0MSJ9.cTBDVCvD6rcA9A7xHQV3XJ0h9wkonPFOcPlMlsdj6cA	2026-01-29 16:02:33.269488+00	2026-02-03 16:02:33+00	41	a92c5d1540a64fb9b5c7a17309471d3c	\N
610	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY5NzA2Mzg2LCJpYXQiOjE3Njk3MDI4NDYsImp0aSI6IjI0MmU2NmFjODAxYzRhZGRhZjkyM2U0Zjk3YWUwMzYwIiwidXNlcl9pZCI6IjEzIn0.BxIZR-32-r-e6GXnOAodaPU_NQiEoTJoSZFya9mNj5E	2026-01-29 16:07:26.086072+00	2026-01-29 17:06:26+00	13	242e66ac801c4addaf923e4f97ae0360	\N
611	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTcwNjM4NiwiaWF0IjoxNzY5NzAyODQ2LCJqdGkiOiIwZmM1M2M1ODkyNmE0MWYzYTIxNjNlYmJjYjMwYzUxMSIsInVzZXJfaWQiOiIxMyJ9.AYQHKahN50H38nvw8sMwPd5EL8ZfEaHgWwQX1Je5UjE	2026-01-29 16:07:26.115199+00	2026-01-29 17:06:26+00	13	0fc53c58926a41f3a2163ebbcb30c511	\N
612	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY5NzEyMTMwLCJpYXQiOjE3Njk3MDg1OTAsImp0aSI6IjJlYTUzY2YzY2FiNjQ0MTJiMzc2NDkxMDY3MGQ1MzM2IiwidXNlcl9pZCI6IjEzIn0.W9PgWWNVfmP1MKEaWncmCt3fFzSFEAGo5XJYBhaVpJU	2026-01-29 17:43:10.048303+00	2026-01-29 18:42:10+00	13	2ea53cf3cab64412b3764910670d5336	\N
613	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTcxMjEzMCwiaWF0IjoxNzY5NzA4NTkwLCJqdGkiOiIzZDg1YWJkMTllNmY0NGZhODIxMWJiOTBmMDhiN2Q3MiIsInVzZXJfaWQiOiIxMyJ9.YVCH3SErzl-m4hIFglB4dNOMaIbIdePH6Jqh8Z3DrhI	2026-01-29 17:43:10.245157+00	2026-01-29 18:42:10+00	13	3d85abd19e6f44fa8211bb90f08b7d72	\N
614	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY5NzYzNjA2LCJpYXQiOjE3Njk3NjAwNjYsImp0aSI6IjkzM2IwM2E4MWIzNzRlYTNiNTQxZTU2MDRjNTlkNmZhIiwidXNlcl9pZCI6IjEzIn0.qgTo4qd-bSP6h5vZR9UgOlRDXjyLOkoAqHVFrqXhJCE	2026-01-30 08:01:06.305748+00	2026-01-30 09:00:06+00	13	933b03a81b374ea3b541e5604c59d6fa	\N
615	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTc2MzYwNiwiaWF0IjoxNzY5NzYwMDY2LCJqdGkiOiJkYTI1NWUyZjliNWI0NzdjYTIzNDBjOWRkY2UwOGRmNyIsInVzZXJfaWQiOiIxMyJ9.bLHpO0tGSq9rCE72UzZde1S4-2hV6aboGk44iVXBShI	2026-01-30 08:01:06.37987+00	2026-01-30 09:00:06+00	13	da255e2f9b5b477ca2340c9ddce08df7	\N
616	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY5NzY4NTM5LCJpYXQiOjE3Njk3NjQ5OTksImp0aSI6IjcxNGMxMjVkMjgzYTRlMzhhOWViMzU3MzNjMTU5YzNmIiwidXNlcl9pZCI6IjEzIn0.jfqjBPPLhteNzzrTCz-QV_ukDUDsR4BHOLa4PgHM934	2026-01-30 09:23:19.356065+00	2026-01-30 10:22:19+00	13	714c125d283a4e38a9eb35733c159c3f	\N
617	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2OTc2ODUzOSwiaWF0IjoxNzY5NzY0OTk5LCJqdGkiOiI3N2VjYTFlYWI3ZmI0M2FiOGYyMzM2OGYxMTJkNmQwNiIsInVzZXJfaWQiOiIxMyJ9.IMkJr67exdGzrdMLkfwE8sr5siLmULKyYEMN89qrZJ0	2026-01-30 09:23:19.417049+00	2026-01-30 10:22:19+00	13	77eca1eab7fb43ab8f23368f112d6d06	\N
618	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDE5NzM0NiwiaWF0IjoxNzY5NzY1MzQ2LCJqdGkiOiI4NDI2Mjg0MDJhMTA0ZmFlYTYzZTg4ZTY5NDVlNTk0ZSIsInVzZXJfaWQiOiI0MSJ9.2Adeeg5HDd0zDY8l3tw6KWwbiUQfQ8q0ycqB2pMZG34	2026-01-30 09:29:06.973461+00	2026-02-04 09:29:06+00	41	842628402a104faea63e88e6945e594e	\N
619	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDQ2MzcxOSwiaWF0IjoxNzcwMDMxNzE5LCJqdGkiOiJlYjcxODYwNTk4NGQ0ODAwYTE1ZGY5NGRjZTNmOGI1ZSIsInVzZXJfaWQiOiIxMyJ9.grXNj0OCK6gKCro76cR48FpGvQM1KIekae3B_CPNXBU	2026-02-02 11:28:39.097203+00	2026-02-07 11:28:39+00	13	eb718605984d4800a15df94dce3f8b5e	\N
620	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDQ2NjAyMCwiaWF0IjoxNzcwMDM0MDIwLCJqdGkiOiJmZGVjYWQ0ZTcyOWU0ZGNmOThiZDEwOWI2OGIzMjQ0MiIsInVzZXJfaWQiOiIxMyJ9.2y-PNaCfXIn4VnqSMmQIyeRxRhYxCJwOEUJOjQ-5pDM	2026-02-02 12:07:00.802039+00	2026-02-07 12:07:00+00	13	fdecad4e729e4dcf98bd109b68b32442	\N
621	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDQ3NzcxMiwiaWF0IjoxNzcwMDQ1NzEyLCJqdGkiOiJlNzE0Yzc3ZmM3ZGI0MjFlODBkMTNlZTljOTIwZjRlMSIsInVzZXJfaWQiOiIxMyJ9.Z94nRJvhDBU3AZ6mTIvnMiOorThak4owpwpq0L8yXgc	2026-02-02 15:21:52.143598+00	2026-02-07 15:21:52+00	13	e714c77fc7db421e80d13ee9c920f4e1	\N
622	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzcwMDQ5NzM1LCJpYXQiOjE3NzAwNDYxOTUsImp0aSI6ImU5YzE4YzJlYTdkZTQ1Yjk4YmMyYzZiM2QwMjliN2E4IiwidXNlcl9pZCI6IjEzIn0.i3MHYDNHXU8wVThAM9S5fcCrx5IxlFUhX0HpWMmwfNk	2026-02-02 15:29:55.180488+00	2026-02-02 16:28:55+00	13	e9c18c2ea7de45b98bc2c6b3d029b7a8	\N
623	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDA0OTczNSwiaWF0IjoxNzcwMDQ2MTk1LCJqdGkiOiIzYTBjZjFlNjkxM2E0NGViOGY0OGY0ZDZjYWRlZmNmMiIsInVzZXJfaWQiOiIxMyJ9.FXOstUYqElNcY85o2CDIFYZPFh7dGCT8zDI616s6gDc	2026-02-02 15:29:55.216296+00	2026-02-02 16:28:55+00	13	3a0cf1e6913a44eb8f48f4d6cadefcf2	\N
624	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzcwMDUwMDAwLCJpYXQiOjE3NzAwNDY0NjAsImp0aSI6IjQwNTNlOGJlYTY1YTQ0ZDFiMDJlM2JhYjdmOTNhM2Y5IiwidXNlcl9pZCI6IjEzIn0.FCIi0KzCzC0wi0eXE9eBj1K8ZBV4D-HqWKuPk48TCVo	2026-02-02 15:34:20.537704+00	2026-02-02 16:33:20+00	13	4053e8bea65a44d1b02e3bab7f93a3f9	\N
625	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDA1MDAwMCwiaWF0IjoxNzcwMDQ2NDYwLCJqdGkiOiI2OGM0Y2NhMjJjYzE0OTAzOTdiYzg3ZDZmZjU2NmExOSIsInVzZXJfaWQiOiIxMyJ9.DXfeO570tBhKk1kEuAx7ISKJswx4tN1aC1tbTB0aFHc	2026-02-02 15:34:20.591611+00	2026-02-02 16:33:20+00	13	68c4cca22cc1490397bc87d6ff566a19	\N
626	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzcwMTI4NzUzLCJpYXQiOjE3NzAxMjUyMTMsImp0aSI6ImRkZjJjMTQ3NzIyYzRkNGQ4YTI0NDViOWQzM2FhN2JhIiwidXNlcl9pZCI6IjEzIn0.v_dpZlekJbzPMgN_DAGOc181culAiDQ3kK8W5rL7WoA	2026-02-03 13:26:53.931704+00	2026-02-03 14:25:53+00	13	ddf2c147722c4d4d8a2445b9d33aa7ba	\N
627	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDEyODc1NCwiaWF0IjoxNzcwMTI1MjE0LCJqdGkiOiI2OTU0M2ZiODlkZDE0YTAzYjRiMzE0MDcyYzFkMGZmYSIsInVzZXJfaWQiOiIxMyJ9.vrztD11RZWc0oB8TeLxsAqfQ6Ztui5l01CPzi1zZXkA	2026-02-03 13:26:54.006384+00	2026-02-03 14:25:54+00	13	69543fb89dd14a03b4b314072c1d0ffa	\N
628	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzcwMTMyNzYzLCJpYXQiOjE3NzAxMjkyMjMsImp0aSI6IjBlNzYxMjJhYjkwZDQxMWRhMTY0MTFlZTVmZWZiMzA2IiwidXNlcl9pZCI6IjEzIn0.RJupRWRoDRNhyzNvOZFT4hWjt3gfiGyhjmNmCALXOQ4	2026-02-03 14:33:43.041193+00	2026-02-03 15:32:43+00	13	0e76122ab90d411da16411ee5fefb306	\N
629	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDEzMjc2MywiaWF0IjoxNzcwMTI5MjIzLCJqdGkiOiI3YmEyZTA4MGRiMjc0ZGY5YTQyM2E2NGUwZjY3YzQzZiIsInVzZXJfaWQiOiIxMyJ9.ltNbEaKM1t03AepiuYiOZxgH2Ta4DT9eo8CQX9YOgHg	2026-02-03 14:33:43.108031+00	2026-02-03 15:32:43+00	13	7ba2e080db274df9a423a64e0f67c43f	\N
630	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDU2MzIxNCwiaWF0IjoxNzcwMTMxMjE0LCJqdGkiOiIzNmIyMDRmMGU4OTA0ODUzYTMzZjY0OGMzYzVjMDU0MyIsInVzZXJfaWQiOiI0MSJ9.fdF1qEglpKi_MXBYoitODE7sBSGLSyqAgAff5m6I2Vc	2026-02-03 15:06:54.760484+00	2026-02-08 15:06:54+00	41	36b204f0e8904853a33f648c3c5c0543	\N
631	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDU2Njc4NiwiaWF0IjoxNzcwMTM0Nzg2LCJqdGkiOiJkMzgwYWIzZjE5Y2Q0NDE2OWM5MmIxYmVjYWFlN2NiYyIsInVzZXJfaWQiOiIxMyJ9.mqUelTvSYe2_D0BttsjXGvxc1pJjMmkNRAIANIqW9dM	2026-02-03 16:06:26.887167+00	2026-02-08 16:06:26+00	13	d380ab3f19cd44169c92b1becaae7cbc	\N
632	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDU2ODkzNSwiaWF0IjoxNzcwMTM2OTM1LCJqdGkiOiJiNWY4ZDQ0NzhkYmM0ZTA2YjYzYzRlY2JkMWFjNWI1YyIsInVzZXJfaWQiOiIxMyJ9.Y_1yBoNB7wJQCkkoaHiksJ_N9nQrx99hG68o4OWMWIU	2026-02-03 16:42:15.834989+00	2026-02-08 16:42:15+00	13	b5f8d4478dbc4e06b63c4ecbd1ac5b5c	\N
633	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDU2ODk3NywiaWF0IjoxNzcwMTM2OTc3LCJqdGkiOiJmZmZkZmViN2Y4NGI0NzYwYTk2NTQ2NWU1NmJhNjQ4OSIsInVzZXJfaWQiOiI0MSJ9.rIafjkIwVwqtljBd-6sg5iSRqTB8SRy-EfRi5olG8vw	2026-02-03 16:42:57.090782+00	2026-02-08 16:42:57+00	41	fffdfeb7f84b4760a965465e56ba6489	\N
634	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDU2OTAzOCwiaWF0IjoxNzcwMTM3MDM4LCJqdGkiOiI1OGEzZjVlNmIzNGQ0OTNiYjEyNWU2ODYwZDc2YWFkNCIsInVzZXJfaWQiOiI0MSJ9.V35hYO01FlN3FS6pwYg15Y2v67vGwBmOzx8UwwJxpDI	2026-02-03 16:43:58.082439+00	2026-02-08 16:43:58+00	41	58a3f5e6b34d493bb125e6860d76aad4	\N
635	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDU3MDkwMSwiaWF0IjoxNzcwMTM4OTAxLCJqdGkiOiI4MDgxZTliZGExNTg0NTdlYmU1OWRmNTU1NDQzNjNkOCIsInVzZXJfaWQiOiI0MSJ9.mVuvXRiWq_Wj0m65seyHI6GceXUzq8A55NPanNv2YHs	2026-02-03 17:15:01.948176+00	2026-02-08 17:15:01+00	41	8081e9bda158457ebe59df55544363d8	\N
636	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDU3MjE5MSwiaWF0IjoxNzcwMTQwMTkxLCJqdGkiOiIxYmE5ZDRjOTE1YmQ0MDEyYWYzMDMyNWJhYzJkZDBiZSIsInVzZXJfaWQiOiIxMyJ9.7Csf8yCxrw9-TA3Q9lY-Obtkit8kIzjUOx81bgVZPvM	2026-02-03 17:36:31.290838+00	2026-02-08 17:36:31+00	13	1ba9d4c915bd4012af30325bac2dd0be	\N
637	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDYzMzAwMCwiaWF0IjoxNzcwMjAxMDAwLCJqdGkiOiIyY2IzMTg4MWJiODE0NGUxOTQxYWY3MzBhZDFiZDg5YiIsInVzZXJfaWQiOiI0MSJ9.dsSExYfk4ROzkgBZJDk8GYl6O63Lu-sX3LgZBYN8gZ4	2026-02-04 10:30:00.626422+00	2026-02-09 10:30:00+00	41	2cb31881bb8144e1941af730ad1bd89b	\N
638	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDY0ODkzOCwiaWF0IjoxNzcwMjE2OTM4LCJqdGkiOiJmYjM3ZGZhMDcwNGI0YTgxOGUwNmZhZTQ3YWVlZGEyOSIsInVzZXJfaWQiOiI0MSJ9.iH73T0P1t5_CpLPEtQFqZC5Bl05f3m_KrH2ImthbWr0	2026-02-04 14:55:38.487615+00	2026-02-09 14:55:38+00	41	fb37dfa0704b4a818e06fae47aeeda29	\N
639	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzcwMjIxNTIwLCJpYXQiOjE3NzAyMTc5ODAsImp0aSI6ImM2OTk3ZWQ4NDM0ZjQ4NDFiOWY4OWM5N2Q3Y2VmMDRlIiwidXNlcl9pZCI6IjEzIn0.VU4Yl23v0ILJrQUDtRkOYD2m_SEdAr60ZpZUb0keH9M	2026-02-04 15:13:00.340077+00	2026-02-04 16:12:00+00	13	c6997ed8434f4841b9f89c97d7cef04e	\N
640	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDIyMTUyMCwiaWF0IjoxNzcwMjE3OTgwLCJqdGkiOiIyNzVmZDk3NzZkMTU0ODRjYmE0YTNiNGU3YjM1ZWU3MiIsInVzZXJfaWQiOiIxMyJ9.O0OzLr6kVFl7Y4Kmr5Ni5p9C16U9axAJCa6Xlbiinwk	2026-02-04 15:13:00.37264+00	2026-02-04 16:12:00+00	13	275fd9776d15484cba4a3b4e7b35ee72	\N
641	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDY1MjU4MCwiaWF0IjoxNzcwMjIwNTgwLCJqdGkiOiIxMjhjOTM1ZWY4ZjU0MzEzYmZmNTM5YWRjOTI0ZDQ0MCIsInVzZXJfaWQiOiI0MSJ9.jiNcBa-wT7iHVk41xT7ZYDtAtgjK_Nm1-YHTHRLdpHA	2026-02-04 15:56:20.554857+00	2026-02-09 15:56:20+00	41	128c935ef8f54313bff539adc924d440	\N
642	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzcwMjI1MTY0LCJpYXQiOjE3NzAyMjE2MjQsImp0aSI6IjM5ZWJkNGJkODg5NTQ2N2VhYzU1YThmZmZlYTg0YzBkIiwidXNlcl9pZCI6IjEzIn0.eD2tqazxPrNFLhjW1Vd2138-GwVOtPd2aKM1PWLbdso	2026-02-04 16:13:44.705209+00	2026-02-04 17:12:44+00	13	39ebd4bd8895467eac55a8fffea84c0d	\N
643	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDIyNTE2NCwiaWF0IjoxNzcwMjIxNjI0LCJqdGkiOiI0OTNmN2QyZDgzMTk0MTU1YjllM2VjY2Y0NzdjOWRjMCIsInVzZXJfaWQiOiIxMyJ9.e7xqc6DmN2hJ8ojRUUYGXVBWhs3oOlr8H_4a-s__9og	2026-02-04 16:13:44.735576+00	2026-02-04 17:12:44+00	13	493f7d2d83194155b9e3eccf477c9dc0	\N
644	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDcxMTk0MCwiaWF0IjoxNzcwMjc5OTQwLCJqdGkiOiI5ODQ5NDY1ZGY1MjE0YTQ4OTY4NzFmMzRlZTVjMGQ2NyIsInVzZXJfaWQiOiI0MSJ9.yy-Qso-oyC3py6JXQ-xVAvJMSKpkiI5aHTSqkZ6ncBQ	2026-02-05 08:25:40.947823+00	2026-02-10 08:25:40+00	41	9849465df5214a4896871f34ee5c0d67	\N
645	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDcxOTk4NSwiaWF0IjoxNzcwMjg3OTg1LCJqdGkiOiJlMzFiYjZiMTU5ZjQ0NDFkOGNiZjVmMDFiYzczNjQ2MyIsInVzZXJfaWQiOiI0MSJ9.4Asc00JEI39Lu1b2B8twjc1PoZQts9BFlLbQQKwMeN8	2026-02-05 10:39:45.186971+00	2026-02-10 10:39:45+00	41	e31bb6b159f4441d8cbf5f01bc736463	\N
646	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDcyMjU0NywiaWF0IjoxNzcwMjkwNTQ3LCJqdGkiOiIxNDcwOTYwNTkzYjg0YWQzYjEzNGUzZDI3YzM4MWZkMSIsInVzZXJfaWQiOiI0MSJ9.s_bRhEp6VWolNk6DZBtFccpxatoI__Kw3mQrCDHbtSA	2026-02-05 11:22:27.981658+00	2026-02-10 11:22:27+00	41	1470960593b84ad3b134e3d27c381fd1	\N
647	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDcyMjU0OSwiaWF0IjoxNzcwMjkwNTQ5LCJqdGkiOiI0ZWNmMjA1ZmZiMWE0NzE3YjNiY2IwMzdlYzgzMTYyMSIsInVzZXJfaWQiOiI0MSJ9.AnQtcI6JoONVJlKcjKpyPUMcSMLebyqp5wprA9ss8Fc	2026-02-05 11:22:29.13638+00	2026-02-10 11:22:29+00	41	4ecf205ffb1a4717b3bcb037ec831621	\N
648	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDcyNDY1NSwiaWF0IjoxNzcwMjkyNjU1LCJqdGkiOiIwMzU1MWQ3YTNjODg0NzM0YWE3ZjVmNDhmMjk1Y2Q0MyIsInVzZXJfaWQiOiI0MSJ9.gPXzSggbb0PchHDVDtO1EXvQgafg2_j7Z9oaYqp1RWQ	2026-02-05 11:57:35.988419+00	2026-02-10 11:57:35+00	41	03551d7a3c884734aa7f5f48f295cd43	\N
649	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDcyNjk2NCwiaWF0IjoxNzcwMjk0OTY0LCJqdGkiOiIwNTI5NDE4YjkzNGM0ZjE1ODI2MjQ3MTYzZDlmMTA4ZCIsInVzZXJfaWQiOiI0MSJ9.X9Jxsut_X4a0WBcTffUyMBYkRLO2KM0VBDGH4vFgiHI	2026-02-05 12:36:04.504443+00	2026-02-10 12:36:04+00	41	0529418b934c4f15826247163d9f108d	\N
650	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDczMDQ5MiwiaWF0IjoxNzcwMjk4NDkyLCJqdGkiOiIzNWI3YTQ3NDVkODA0YjFhYTYyNmY2NjVhNjAwZjNjZSIsInVzZXJfaWQiOiI0MSJ9.edIuf7vjqfuhE4Keji0PHq-oGYjVbeakY9SkDpgqcoA	2026-02-05 13:34:52.641195+00	2026-02-10 13:34:52+00	41	35b7a4745d804b1aa626f665a600f3ce	\N
651	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDczMjU4MSwiaWF0IjoxNzcwMzAwNTgxLCJqdGkiOiIwMmFkNTEwNGY4ZDI0ZGNkYjMzNmFmYzY5MTVkYTY2NyIsInVzZXJfaWQiOiI0MSJ9.UyHpx75iAlv551WX3MlcxXWtLqyo6NfoYoZle3irX4c	2026-02-05 14:09:41.959176+00	2026-02-10 14:09:41+00	41	02ad5104f8d24dcdb336afc6915da667	\N
652	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDczNTgxNiwiaWF0IjoxNzcwMzAzODE2LCJqdGkiOiJlOWU2NThkNjI0ZmY0OWUwOGQ4N2Y1MzBkYmY5NWJlNSIsInVzZXJfaWQiOiI0MSJ9.4xHBYDkwiAVv1CzOsHdRr7KMdka0U3CnBjfJOPTUlBA	2026-02-05 15:03:36.392358+00	2026-02-10 15:03:36+00	41	e9e658d624ff49e08d87f530dbf95be5	\N
653	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDczNzYyNiwiaWF0IjoxNzcwMzA1NjI2LCJqdGkiOiJkMTdmNzA4YmJmODc0MWEzYWYwNTgxZjg4ZWQwNTBhMiIsInVzZXJfaWQiOiI0MSJ9.WxlLiaBNhr68wU2XI1yweh4WPAD6V3i2rrGqsmAgNmw	2026-02-05 15:33:46.029615+00	2026-02-10 15:33:46+00	41	d17f708bbf8741a3af0581f88ed050a2	\N
654	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDc5MjkxMCwiaWF0IjoxNzcwMzYwOTEwLCJqdGkiOiI0ZTQ2NGE3Mjk2MGI0Yjg2OTUyNWEwNTNlOGFiN2JlMyIsInVzZXJfaWQiOiI0MSJ9.OBcCzEZuk35LUKHec8MorUARMTChHa3oRoV9YsOxRMo	2026-02-06 06:55:10.349347+00	2026-02-11 06:55:10+00	41	4e464a72960b4b869525a053e8ab7be3	\N
655	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDgwNzAyMSwiaWF0IjoxNzcwMzc1MDIxLCJqdGkiOiI2OWNjMjMxYTY0YTU0ZTMyYWNlMWNlOTdkYzkyN2FjZSIsInVzZXJfaWQiOiI0MSJ9._iREPNuG2n_NyDo1WvBYVArLyDS_WoBlF-0-jbj51UQ	2026-02-06 10:50:21.162564+00	2026-02-11 10:50:21+00	41	69cc231a64a54e32ace1ce97dc927ace	\N
656	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDk5NDQxNSwiaWF0IjoxNzcwNTYyNDE1LCJqdGkiOiJkNTJkODUwYjA0Zjc0NmRiYjJjNWMzNTQxZmRiZDAyYyIsInVzZXJfaWQiOiI0MSJ9.Vo-6DRF1YsV9myi44XCNhsZ4c2OvevwMC90nmJz-AkQ	2026-02-08 14:53:35.90229+00	2026-02-13 14:53:35+00	41	d52d850b04f746dbb2c5c3541fdbd02c	\N
657	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDk5NjM5OSwiaWF0IjoxNzcwNTY0Mzk5LCJqdGkiOiJhMTNmYTVjZGJlMDg0OWZjYWYxMGFiMzU0ZmY3MmNiYyIsInVzZXJfaWQiOiI0MSJ9.VYtGJYgFAG8mCts7lumE5z1HdVLi757UQU1yZ4xUV2M	2026-02-08 15:26:39.259826+00	2026-02-13 15:26:39+00	41	a13fa5cdbe0849fcaf10ab354ff72cbc	\N
658	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDk5ODU0NSwiaWF0IjoxNzcwNTY2NTQ1LCJqdGkiOiJiNzk1MTgwM2JkZmE0OTNkODEwNTBlZjViYzgxZDVlNCIsInVzZXJfaWQiOiI0MSJ9.zOzd-hD02HAE5vKVluyLyGWZpAG6Ki3ZZAVgG8de-Rc	2026-02-08 16:02:25.487125+00	2026-02-13 16:02:25+00	41	b7951803bdfa493d81050ef5bc81d5e4	\N
659	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTAwMDM4MSwiaWF0IjoxNzcwNTY4MzgxLCJqdGkiOiI0ZjdjMTQ0NTA0MWM0OGVjYmRkM2I4YzE0MDg4NDVhZiIsInVzZXJfaWQiOiI0MSJ9.e4xL6juqW5HF_h_9LnZ3sos5-WlDfm0bioxeHvMes1w	2026-02-08 16:33:01.051238+00	2026-02-13 16:33:01+00	41	4f7c1445041c48ecbdd3b8c1408845af	\N
660	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTAwMjI2MCwiaWF0IjoxNzcwNTcwMjYwLCJqdGkiOiJkMWJlNTE5Y2JjOWU0OGMwODhhODY4MzM3MGNmYzE1MSIsInVzZXJfaWQiOiI0MSJ9.7F_6pFG37T2zR3-7c83oM8fsF00YQh9LIcPIetaM8pM	2026-02-08 17:04:20.304941+00	2026-02-13 17:04:20+00	41	d1be519cbc9e48c088a8683370cfc151	\N
661	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA0ODM0MSwiaWF0IjoxNzcwNjE2MzQxLCJqdGkiOiJjOWE5M2YwMTM5NTM0NTk1OGVlNDZjYjA3NjNjMTYzYyIsInVzZXJfaWQiOiI0NSJ9.ZMlUV3-UB8FqBZg0DReyp8sxJV5e6UCGcmjlzx7ICQ8	2026-02-09 05:52:21.495849+00	2026-02-14 05:52:21+00	45	c9a93f01395345958ee46cb0763c163c	\N
662	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA0OTA1NywiaWF0IjoxNzcwNjE3MDU3LCJqdGkiOiJiMjJmOGQ0YTYzMTI0MjZiYWI4Yzg1YTI2M2UyZDk1MyIsInVzZXJfaWQiOiI0NSJ9.4KVzpoWdLgrcTIZtOx7S2_YdgZi80949T5WtcW6O3b4	2026-02-09 06:04:17.885487+00	2026-02-14 06:04:17+00	45	b22f8d4a6312426bab8c85a263e2d953	\N
663	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA1NTEyMCwiaWF0IjoxNzcwNjIzMTIwLCJqdGkiOiJiMTJjZTMxZWQ2NTI0ZWJkOWIyZTM3NmRmNjc3ZDgxNiIsInVzZXJfaWQiOiI0NSJ9.QaH83gP8XSbx55Ao2ZtIH-i6z6p15U1-MrRFMEXlX2E	2026-02-09 07:45:20.180912+00	2026-02-14 07:45:20+00	45	b12ce31ed6524ebd9b2e376df677d816	\N
664	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA1NTcyNywiaWF0IjoxNzcwNjIzNzI3LCJqdGkiOiJiMTgwZDJlNmJkNjE0YjlkOTFmYjNmYTcwNDVhZjI3OCIsInVzZXJfaWQiOiI0MSJ9.kKKEfMKjEdvrREM-Xg6X0rmtIUp7c3NtaEDR9n-4kXQ	2026-02-09 07:55:27.769431+00	2026-02-14 07:55:27+00	41	b180d2e6bd614b9d91fb3fa7045af278	\N
665	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA1ODMxMiwiaWF0IjoxNzcwNjI2MzEyLCJqdGkiOiI5YTUzNWFlY2M3MGU0NDUyOTc4MTkwYmM0ZjNkNmQ5ZSIsInVzZXJfaWQiOiI0NSJ9.kaW5IYxth_dn1s1CL4rPVuUcA8FRn6btXWngsJ0MxTw	2026-02-09 08:38:32.011713+00	2026-02-14 08:38:32+00	45	9a535aecc70e4452978190bc4f3d6d9e	\N
666	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA2MDg3NSwiaWF0IjoxNzcwNjI4ODc1LCJqdGkiOiIyN2FjNTM2YTU4YmM0YWEzYTVmNWNjODVjNzZkODAwZCIsInVzZXJfaWQiOiI0MSJ9.wGBD_bxbXOngggsCf8fvlzPmuUl75ZOebxukNwqo0Vw	2026-02-09 09:21:15.699745+00	2026-02-14 09:21:15+00	41	27ac536a58bc4aa3a5f5cc85c76d800d	\N
667	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA2NTQ1NSwiaWF0IjoxNzcwNjMzNDU1LCJqdGkiOiJmNGVlYzY5MTU1MzQ0Nzg0OTIxNzM4OTM4MGZlMWI3ZCIsInVzZXJfaWQiOiI0MSJ9.ZP_nOfk7Hm97M5CXElUGlRyPaiBgpmW-Zo1wBYerOgo	2026-02-09 10:37:35.05404+00	2026-02-14 10:37:35+00	41	f4eec691553447849217389380fe1b7d	\N
668	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA2ODM4MywiaWF0IjoxNzcwNjM2MzgzLCJqdGkiOiIzNDQwZTYyNDUxNmQ0YWJjOWVjYWU4YWNjY2YyMDRhNiIsInVzZXJfaWQiOiI0MSJ9.FBz5mwPYkuFSJAeKowAgQ0dgknh3At8UJJ-hxIKCQE8	2026-02-09 11:26:23.025253+00	2026-02-14 11:26:23+00	41	3440e624516d4abc9ecae8acccf204a6	\N
669	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA2ODU3MSwiaWF0IjoxNzcwNjM2NTcxLCJqdGkiOiI3MWU0ODAyMmVjOTI0NGJkOGJiZTg0ZmFjMTBlNjFiMiIsInVzZXJfaWQiOiI0NSJ9.JEAJyd5wHuADpaAXKXJEniv61wWwyzztGi3xGblTpbc	2026-02-09 11:29:31.70035+00	2026-02-14 11:29:31+00	45	71e48022ec9244bd8bbe84fac10e61b2	\N
670	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA2OTM5MSwiaWF0IjoxNzcwNjM3MzkxLCJqdGkiOiI4ODA3MmJlZTczYzI0MTE2OTU0NGRhZjBmMWUxYTlkYiIsInVzZXJfaWQiOiI0NSJ9.Xm9pxN0PhZxCCqNj4-04UQYDZ0CIXH4S1eA2WFU-4iQ	2026-02-09 11:43:11.430197+00	2026-02-14 11:43:11+00	45	88072bee73c241169544daf0f1e1a9db	\N
671	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA3MDAxMSwiaWF0IjoxNzcwNjM4MDExLCJqdGkiOiIyZDgyYTlkNDUzZjQ0NjY5YTUwNzYyMTQ3MTBkNGZhMCIsInVzZXJfaWQiOiI0NSJ9.BRQom75L7PaeB85JL7WIuGtiINElI7r9g5LT5JNuC3Y	2026-02-09 11:53:31.190446+00	2026-02-14 11:53:31+00	45	2d82a9d453f44669a5076214710d4fa0	\N
672	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA3MjQwNiwiaWF0IjoxNzcwNjQwNDA2LCJqdGkiOiI1MmZhZjU2ZDdmNjI0OWNmYWZhYjVlZjhiNDNlNWIzOSIsInVzZXJfaWQiOiI0NSJ9.37z0DUdwelmPt3EjPM_hqBByazn6oJmOPeUtZYa1hkk	2026-02-09 12:33:26.659402+00	2026-02-14 12:33:26+00	45	52faf56d7f6249cfafab5ef8b43e5b39	\N
673	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA3MjUzNCwiaWF0IjoxNzcwNjQwNTM0LCJqdGkiOiJmMWVjOWYwYTRiY2Q0NzNlODdmMDE1MDEwNTJlYjM0YyIsInVzZXJfaWQiOiI0MSJ9.lbqMxJthJ-UzKy0S3Xdj5Jn6QA62zojEGzsMyRYj6f8	2026-02-09 12:35:34.962753+00	2026-02-14 12:35:34+00	41	f1ec9f0a4bcd473e87f01501052eb34c	\N
674	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA3NDQ1OCwiaWF0IjoxNzcwNjQyNDU4LCJqdGkiOiJhYjk4M2JlN2JjMWI0MDAyYWJlOTU2OTA4NGNkMjA2MCIsInVzZXJfaWQiOiI0MSJ9.6cenOGmahUaB_WPyDE3ytouuIg8QOdo73SCHTHMDxvQ	2026-02-09 13:07:38.866263+00	2026-02-14 13:07:38+00	41	ab983be7bc1b4002abe9569084cd2060	\N
675	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA3NTkyNywiaWF0IjoxNzcwNjQzOTI3LCJqdGkiOiJkMjAwNjdjNGJjYTY0ZGUyODU2NTc5NDI5N2UxMTBkOSIsInVzZXJfaWQiOiI0NSJ9.r8EJWdBQNamj_bfszbHFvD8HP1UFqUfaNsAJfDTx4TM	2026-02-09 13:32:07.707021+00	2026-02-14 13:32:07+00	45	d20067c4bca64de28565794297e110d9	\N
676	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA3NjQyNCwiaWF0IjoxNzcwNjQ0NDI0LCJqdGkiOiJkZGJmNzM3Yzg0MjI0MWIzODZlZGMwY2U4YmMyNjIyMSIsInVzZXJfaWQiOiI0MSJ9.xgG-7t9jMEZnlDoMSnvBLTtpKoKpgCFlJZvZXRn2oW8	2026-02-09 13:40:24.820842+00	2026-02-14 13:40:24+00	41	ddbf737c842241b386edc0ce8bc26221	\N
677	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA3ODMyMCwiaWF0IjoxNzcwNjQ2MzIwLCJqdGkiOiJlNDY2ZWY3MWU5NzY0NmYyYjJhNGMzOGY3MTJlYjYxMyIsInVzZXJfaWQiOiI0MSJ9.kDObfJaSN97UeBOg26tzoRfwh6Xt8TMrmjkajjPvA1Y	2026-02-09 14:12:00.609592+00	2026-02-14 14:12:00+00	41	e466ef71e97646f2b2a4c38f712eb613	\N
678	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA3ODM2OCwiaWF0IjoxNzcwNjQ2MzY4LCJqdGkiOiI5NmE4ODgyMzc0Zjc0ZTE1YmE4OTAyZTdmY2I4NGE5OSIsInVzZXJfaWQiOiI0MSJ9.icXDOaxg75pbb3ddbvTb5ZyLZsJHOQAEv6N3EZaSYjI	2026-02-09 14:12:48.309368+00	2026-02-14 14:12:48+00	41	96a8882374f74e15ba8902e7fcb84a99	\N
679	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA4MDQ2MywiaWF0IjoxNzcwNjQ4NDYzLCJqdGkiOiIwY2YzOTJkMzhhM2E0YjYwYjdmOTNkNzYyMTRhNzkwMiIsInVzZXJfaWQiOiI0MSJ9.81jmsk25ZM4Xn_Fo4AslUYVzB5zWzFuxJx7HND06c_k	2026-02-09 14:47:43.041426+00	2026-02-14 14:47:43+00	41	0cf392d38a3a4b60b7f93d76214a7902	\N
680	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA4MjI4NCwiaWF0IjoxNzcwNjUwMjg0LCJqdGkiOiJhNDQyNzNlMDFkZDk0ODYzODhkNDViZGM2ZTEwNjFiMyIsInVzZXJfaWQiOiI0MSJ9.jH0gWsNvmodbXFFWZqiTQqheEc3dKVjkiK0y86CsUQ0	2026-02-09 15:18:04.410682+00	2026-02-14 15:18:04+00	41	a44273e01dd9486388d45bdc6e1061b3	\N
681	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA4NTAzMSwiaWF0IjoxNzcwNjUzMDMxLCJqdGkiOiJjYmM2YzA3MWE3NjE0ODkwODZlNTcxYTQwZDAyZGNhMCIsInVzZXJfaWQiOiI0MSJ9.Li_R0C4GoqiAIANduU8L64aCnXCLV8H5b_XCVqwJnDk	2026-02-09 16:03:51.670439+00	2026-02-14 16:03:51+00	41	cbc6c071a761489086e571a40d02dca0	\N
682	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA4Njg4OSwiaWF0IjoxNzcwNjU0ODg5LCJqdGkiOiIwZGMyMDYzNWIwY2I0ZTI1YWY2ZTA3ZWRmNjZjMzg4NyIsInVzZXJfaWQiOiI0MSJ9.P3nhEPf8xXzgDNLES2lbC_idG4TBik1Lce4wtGoF5os	2026-02-09 16:34:49.678151+00	2026-02-14 16:34:49+00	41	0dc20635b0cb4e25af6e07edf66c3887	\N
683	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA4ODcwNywiaWF0IjoxNzcwNjU2NzA3LCJqdGkiOiJkMDJkMTUzNmIzZjQ0ODRkYmZlMTcxYWUwZmVjMjhlNyIsInVzZXJfaWQiOiI0MSJ9.F5Bbo3c0sTUnFDUhlFg6qKyd0YHeza3IHZ2wpCfquGE	2026-02-09 17:05:07.517544+00	2026-02-14 17:05:07+00	41	d02d1536b3f4484dbfe171ae0fec28e7	\N
684	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTA5MDUzMywiaWF0IjoxNzcwNjU4NTMzLCJqdGkiOiIxYzg4YzJlMGY1Mjk0NGZiOGEwNDE1ZTRhZjk1ZjRhYiIsInVzZXJfaWQiOiI0MSJ9.mIHFSmUHIhpRiFRZ030sK4jIC_66dy9B4PGdqbplruk	2026-02-09 17:35:33.903155+00	2026-02-14 17:35:33+00	41	1c88c2e0f52944fb8a0415e4af95f4ab	\N
685	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE0Mzg3MywiaWF0IjoxNzcwNzExODczLCJqdGkiOiI1MmE1YTI4MjQ4YmQ0Y2M1YmQyNmJiNjVlYTAxNjk3NCIsInVzZXJfaWQiOiI0MSJ9.pi1LGcDJ6gIkMMK6XRbplvwHa8RAKuEiDNwSCXba5PQ	2026-02-10 08:24:33.134462+00	2026-02-15 08:24:33+00	41	52a5a28248bd4cc5bd26bb65ea016974	\N
686	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE0NTk5OSwiaWF0IjoxNzcwNzEzOTk5LCJqdGkiOiIxZjQxNDgzZjZmZTM0OTkxODM4MzMzNzEyYzMxNWNlOCIsInVzZXJfaWQiOiI0MSJ9.U5_j_IbvJN4tlGxPw2zElOuUiWAsfrVGsIgiCTB-ztM	2026-02-10 08:59:59.026494+00	2026-02-15 08:59:59+00	41	1f41483f6fe34991838333712c315ce8	\N
687	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE0ODExMywiaWF0IjoxNzcwNzE2MTEzLCJqdGkiOiJiZmRmYTg4NzFhNGQ0YzM0YmJhYjBiNDkzNTVmMjk5NSIsInVzZXJfaWQiOiI0MSJ9.WRnIWwZnqFvnHnScrULstNwMS49ix-UUw6mvYt0U9Ng	2026-02-10 09:35:13.931023+00	2026-02-15 09:35:13+00	41	bfdfa8871a4d4c34bbab0b49355f2995	\N
688	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE1MDc1OCwiaWF0IjoxNzcwNzE4NzU4LCJqdGkiOiJlZjY3OGVkODMxNDg0MWVjODQwN2JlYzA5MDY1MjUxNSIsInVzZXJfaWQiOiI0MSJ9.l4hWa-yUUcNEpKAnlLdECYeAIcslVNSGyYVxOvaPFj0	2026-02-10 10:19:18.712503+00	2026-02-15 10:19:18+00	41	ef678ed8314841ec8407bec090652515	\N
689	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE1MjY1NiwiaWF0IjoxNzcwNzIwNjU2LCJqdGkiOiI2MGRlNTJmNjc3YmI0NTIzOWU5OGFjMWIyMmI5M2U3YyIsInVzZXJfaWQiOiI0MSJ9.RQ6FVmE56U1VsAo0ZBUaRHFJRN4uIAGsz-6g9Lp48cE	2026-02-10 10:50:56.283493+00	2026-02-15 10:50:56+00	41	60de52f677bb45239e98ac1b22b93e7c	\N
690	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE1NDUwNSwiaWF0IjoxNzcwNzIyNTA1LCJqdGkiOiI0N2FkMzBjMDc2YTc0OWE0YTJhYzk1MWI2YThiMTU4NiIsInVzZXJfaWQiOiI0MSJ9.EPhOM541tKEXEfUoK_JxNGP3FaG2jkbImCLnRSVwFSk	2026-02-10 11:21:45.853769+00	2026-02-15 11:21:45+00	41	47ad30c076a749a4a2ac951b6a8b1586	\N
691	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE1NzM3NiwiaWF0IjoxNzcwNzI1Mzc2LCJqdGkiOiJmZDFlNDJhZDQ1OGY0MzI5ODVmNzg2MTM2NTI0NjBjYyIsInVzZXJfaWQiOiI0MSJ9.HAkbbVUKa6L8XvwF4u3VNrSdaW9lsAYn4brdaqbNS-I	2026-02-10 12:09:36.544651+00	2026-02-15 12:09:36+00	41	fd1e42ad458f432985f78613652460cc	\N
692	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE2MDY0NCwiaWF0IjoxNzcwNzI4NjQ0LCJqdGkiOiI0N2MwNTI3NGI4ZDc0M2I5YjQ0MTQ5NGNhZmNkNjNhMiIsInVzZXJfaWQiOiI0MSJ9.qgidhjIVdU73dVf_HAiD8BR2la2rqloawIh3_Lxrr9o	2026-02-10 13:04:04.061623+00	2026-02-15 13:04:04+00	41	47c05274b8d743b9b441494cafcd63a2	\N
693	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE2MjQ2NywiaWF0IjoxNzcwNzMwNDY3LCJqdGkiOiJhZjQ4ZTQ4YWJjY2U0MTIzOWZjZjZiMzI1MTdiMmY0ZiIsInVzZXJfaWQiOiI0MSJ9.0jfztq2KthOM_PhabpHR4TvHnHHWmkGvdoyKDA1U15s	2026-02-10 13:34:27.482042+00	2026-02-15 13:34:27+00	41	af48e48abcce41239fcf6b32517b2f4f	\N
694	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE2NDM5NywiaWF0IjoxNzcwNzMyMzk3LCJqdGkiOiIyNzBhMzg2MjZjNDQ0OGIyOGMxYzA1MzY3Y2VhYjhjOSIsInVzZXJfaWQiOiI0MSJ9.bFM4lSR59qDo1ZwZ05xjFKo0xQjwrbdA4TCtxEjZRV0	2026-02-10 14:06:37.343021+00	2026-02-15 14:06:37+00	41	270a38626c4448b28c1c05367ceab8c9	\N
695	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE2NjIwMSwiaWF0IjoxNzcwNzM0MjAxLCJqdGkiOiIxYzM3ZTk2MzdhNDQ0ZmNmOGQzMzYwNjgxNjU5NmM3NCIsInVzZXJfaWQiOiI0MSJ9.kp-gkSIgdKADw_uEH-FXyo431yMMp-msyUA9fPjPDA0	2026-02-10 14:36:41.630777+00	2026-02-15 14:36:41+00	41	1c37e9637a444fcf8d33606816596c74	\N
696	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE2NzcyNiwiaWF0IjoxNzcwNzM1NzI2LCJqdGkiOiIwNDM3NzJmMmZiM2M0MmMwOGEyMGRkOWZhOWFlNTMwMCIsInVzZXJfaWQiOiIxMyJ9.99ESBC85qHucxRAdw-0I5OvemHnp_nrirMYI1vHhZYY	2026-02-10 15:02:06.929045+00	2026-02-15 15:02:06+00	13	043772f2fb3c42c08a20dd9fa9ae5300	\N
697	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE2OTY5NSwiaWF0IjoxNzcwNzM3Njk1LCJqdGkiOiJhMGY5MzA5YWQ4Yzk0OGRkYWQ3ODc4MzNhMjMxN2FkZCIsInVzZXJfaWQiOiIxMyJ9.NenH6yqMr7E0dNnlokxuK67u3kL0qNdYFkbioUX-PcA	2026-02-10 15:34:55.788697+00	2026-02-15 15:34:55+00	13	a0f9309ad8c948ddad787833a2317add	\N
698	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzcwNzQxMjcyLCJpYXQiOjE3NzA3Mzc3MzIsImp0aSI6IjZiZTZiZTkyNDYzODQ3ODQ5ZWZlZDVkOGY3ZjM3NTViIiwidXNlcl9pZCI6IjEzIn0.PeP5mnyRE7w9jsXsQ2aJYK32YqyLsZv-YFKRFl0a6j0	2026-02-10 15:35:32.881486+00	2026-02-10 16:34:32+00	13	6be6be92463847849efed5d8f7f3755b	\N
699	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDc0MTI3MiwiaWF0IjoxNzcwNzM3NzMyLCJqdGkiOiIyNjE4MWIxNGExMTA0ZjA2YjhkMzI3OGM3YWU0MWY1MyIsInVzZXJfaWQiOiIxMyJ9.ILIrupdfs8J-mVgbfGMqPvIxY5GIympbe1yAC0t1jb0	2026-02-10 15:35:32.906575+00	2026-02-10 16:34:32+00	13	26181b14a1104f06b8d3278c7ae41f53	\N
700	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE2OTgwNSwiaWF0IjoxNzcwNzM3ODA1LCJqdGkiOiIxMzJlMDYyYjMzYzA0M2Y1ODc0MGNiY2EyMWE4YTYwNCIsInVzZXJfaWQiOiI0MSJ9.Q1zx8m1lGbUpUCx3GwZOa738BEfonoyOfozX82X3SGk	2026-02-10 15:36:45.732415+00	2026-02-15 15:36:45+00	41	132e062b33c043f58740cbca21a8a604	\N
701	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzcwNzQ0MTIzLCJpYXQiOjE3NzA3NDA1ODMsImp0aSI6IjFmMTkyNzE1YzliZjRhM2RiMGIwMTQ0ZWUwMjc3MDhhIiwidXNlcl9pZCI6IjEzIn0.he2dyhaj7n0D0_k2Mf3gcFbZQ9zpeQXLKzveVatW71w	2026-02-10 16:23:03.815792+00	2026-02-10 17:22:03+00	13	1f192715c9bf4a3db0b0144ee027708a	\N
702	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MDc0NDEyMywiaWF0IjoxNzcwNzQwNTgzLCJqdGkiOiI0YjYzZDNmMDBhMTE0MDU0OGZmYTY5NTc3MmYzY2M2NiIsInVzZXJfaWQiOiIxMyJ9.ieIJBqXAFwoQW-sBu7xmgXEb4pWYsIUG918t6noqETc	2026-02-10 16:23:03.886459+00	2026-02-10 17:22:03+00	13	4b63d3f00a1140548ffa695772f3cc66	\N
703	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE3Mjc1MSwiaWF0IjoxNzcwNzQwNzUxLCJqdGkiOiJmZTQxZmJhZmEyZDc0NWI3ODliY2IyN2NlNjYzZGU3NiIsInVzZXJfaWQiOiI0MSJ9.eEybZcnt01oq8ojK155mdgTHXedaDEfvaFKYvYHRVjk	2026-02-10 16:25:51.526888+00	2026-02-15 16:25:51+00	41	fe41fbafa2d745b789bcb27ce663de76	\N
704	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE3Mjc1MiwiaWF0IjoxNzcwNzQwNzUyLCJqdGkiOiI4ZWQ2MDgzOTA1ZjA0MDY4YThkZTYzZmIyNGFkNTUyMSIsInVzZXJfaWQiOiI0MSJ9.vJyIlyReNmum4n4NUlO84juukDhPemh5X8vrmISzgto	2026-02-10 16:25:52.221267+00	2026-02-15 16:25:52+00	41	8ed6083905f04068a8de63fb24ad5521	\N
705	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE3NDU5NCwiaWF0IjoxNzcwNzQyNTk0LCJqdGkiOiI2MjA2NzYyNDczMGM0MjI2OTY3ODdjYmNlNjVlZDQ0MiIsInVzZXJfaWQiOiI0MSJ9.yJqKBojDc1SMEm3E7ImmHaG3McFmi1CD6sT_u060aIo	2026-02-10 16:56:34.095227+00	2026-02-15 16:56:34+00	41	62067624730c422696787cbce65ed442	\N
706	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE3NjUyNCwiaWF0IjoxNzcwNzQ0NTI0LCJqdGkiOiIzZDMyYjM2MDExNWM0YzFiYWMyYmU0MGNkYjBhODg0OCIsInVzZXJfaWQiOiI0MSJ9.7S4jvP-Cqtv_kop_g72hzpX8veQrD5Zi78Kr7t70sbg	2026-02-10 17:28:44.119217+00	2026-02-15 17:28:44+00	41	3d32b360115c4c1bac2be40cdb0a8848	\N
707	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTE4ODcwMSwiaWF0IjoxNzcwNzU2NzAxLCJqdGkiOiI1MDY3MTNhMTE4Mjk0YTFkOTU1MTk5OGM2NjE0MTMxOSIsInVzZXJfaWQiOiI0MSJ9.D85SBxuujiIt6X1_qJloYjhBlPXNVcSFN3-M-J0oVRs	2026-02-10 20:51:41.051855+00	2026-02-15 20:51:41+00	41	506713a118294a1d9551998c66141319	\N
708	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTIyNDcwNCwiaWF0IjoxNzcwNzkyNzA0LCJqdGkiOiJiMmEzNzI1YTI5YTU0ODFhODc3OTU2NDE4ODQ4ZDFmNCIsInVzZXJfaWQiOiI0MSJ9.TEDhHm7R1q0xrbhp94HvSqO8c-HSHN2fPiZILpQMHqk	2026-02-11 06:51:44.288202+00	2026-02-16 06:51:44+00	41	b2a3725a29a5481a877956418848d1f4	\N
709	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc3MTI2MDk5NCwiaWF0IjoxNzcwODI4OTk0LCJqdGkiOiJiM2MzNGNjNDlhZjQ0MzhkYTEwNzMwYmRiNDFiM2RkNyIsInVzZXJfaWQiOiI0MSJ9.gg9wa_8629iI6RaBlgvK6lXWnoAuh0YVY65CuxtYQ9g	2026-02-11 16:56:34.626362+00	2026-02-16 16:56:34+00	41	b3c34cc49af4438da10730bdb41b3dd7	\N
\.


--
-- TOC entry 4385 (class 0 OID 116667)
-- Dependencies: 343
-- Data for Name: user_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_profile (id, first_name, last_name, company_name, country, state, region, street_name, apartment_number, zip_code, phone_number, created_at, updated_at, user_id) FROM stdin;
1	Genrih	Damascus					\N	\N		+79091707622	2025-09-23 20:42:40.820753+00	2025-09-23 20:42:40.820765+00	2
2	Genrih	Damascus					\N	\N		+4550852311	2025-09-23 20:44:11.281214+00	2025-09-23 20:44:11.281243+00	3
3	Genrih	Damascus					\N	\N		+4550852311	2025-09-23 23:16:59.456308+00	2025-09-23 23:16:59.456345+00	4
4	Genrih	Damascus					\N	\N		+4550852311	2025-09-23 23:41:48.697023+00	2025-09-23 23:41:48.697034+00	5
5	Genrih	Damascus					\N	\N		+4550852311	2025-09-23 23:42:03.624432+00	2025-09-23 23:42:03.624465+00	6
6	Genrih	Damascus					\N	\N		+4550852311	2025-09-23 23:48:18.019354+00	2025-09-23 23:48:18.019385+00	7
7	Genrih	Damascus					\N	\N		+4550852311	2025-09-24 17:59:50.316315+00	2025-09-24 17:59:50.316349+00	8
9	Avi	Stepovyi	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-25 00:59:35.056375+00	2025-09-25 00:59:35.056429+00	10
10	Genrih	Damascus					\N	\N		+4550852311	2025-09-28 17:09:31.557757+00	2025-09-28 17:09:31.557788+00	11
11	Adrian	Ziegler					\N	\N			2025-09-30 16:53:25.655768+00	2025-09-30 16:53:25.655793+00	12
13	Test	Test									2025-12-01 16:49:24.371825+00	2025-12-01 16:49:24.371845+00	14
14	Test	Test									2025-12-01 16:55:34.908236+00	2025-12-01 16:55:34.908257+00	15
15	Test	Test									2025-12-01 16:59:34.793234+00	2025-12-01 16:59:34.793253+00	16
16	Еуіе	Еуіе									2025-12-01 17:20:21.790136+00	2025-12-01 17:20:21.790156+00	17
17	Test	Test									2025-12-01 17:29:05.996164+00	2025-12-01 17:29:05.996188+00	18
18	Test	Test									2025-12-01 17:31:10.690039+00	2025-12-01 17:31:10.690059+00	19
19	Test	Test									2025-12-01 17:32:57.790895+00	2025-12-01 17:32:57.79092+00	20
20	Test	Test									2025-12-01 17:39:38.301707+00	2025-12-01 17:39:38.301728+00	21
21	Test	Test									2025-12-02 08:57:11.818084+00	2025-12-02 08:57:11.818108+00	22
22	Test	Test									2025-12-02 09:08:24.492081+00	2025-12-02 09:08:24.492104+00	23
23	Test	Test									2025-12-02 09:56:27.807341+00	2025-12-02 09:56:27.807364+00	24
24	Еууу	Еуууу									2025-12-04 15:38:11.258087+00	2025-12-04 15:38:11.258106+00	25
25	Rrr	Rrr									2025-12-04 16:31:58.461077+00	2025-12-04 16:31:58.461102+00	26
26	Rqqq	Qqqq									2025-12-04 16:36:51.351569+00	2025-12-04 16:36:51.351589+00	27
27	Rqqq	Qqqq									2025-12-04 16:37:32.549905+00	2025-12-04 16:37:32.549925+00	28
28	Rqqq	Qqqq									2025-12-04 16:39:00.196219+00	2025-12-04 16:39:00.196243+00	29
29	Rqqq	Qqqq									2025-12-04 16:39:36.951348+00	2025-12-04 16:39:36.951366+00	30
30	Rqqq	Qqqq									2025-12-04 16:44:22.853099+00	2025-12-04 16:44:22.853117+00	31
31	Rrr	Rrr									2025-12-04 16:48:09.196071+00	2025-12-04 16:48:09.196096+00	32
32	Rt	Rt									2025-12-04 16:51:15.648121+00	2025-12-04 16:51:15.648143+00	33
33	Mike	Tyson	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-05 18:52:15.439365+00	2025-12-05 18:52:15.439382+00	34
43	Admin	Admin									2025-12-09 16:45:10.740988+00	2025-12-09 16:45:10.741012+00	37
61	Test	Test	\N	Ukraine	Kharkiv	Kharkiv	Sun	20	11111	+380502637520	2025-12-18 21:46:20.577548+00	2025-12-28 12:46:42.11297+00	41
73	Kateryna	Rost		Ukraine	Kharkiv	Kharkiv	Neskorenykh	10	11111	+380502333385	2025-12-28 17:33:40.07375+00	2025-12-28 17:33:40.073775+00	\N
44	Testh	Testh								+380501234567	2025-12-10 09:27:27.046997+00	2025-12-12 12:09:53.156161+00	38
45	Testn	Testn									2025-12-16 10:38:47.822986+00	2025-12-16 10:38:47.823012+00	39
46	Testt	Testt		Ukraine	Od	Od	Nebesnoi	1	12345	+380931234567	2025-12-17 10:57:38.786032+00	2025-12-29 08:25:41.603017+00	40
74	Testt	Testt		Ukraine	Od	Od	Nebesnoi	1	12345	+380931234567	2025-12-29 08:26:38.789856+00	2025-12-29 08:26:38.789882+00	\N
75	Test	Test	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-29 18:54:52.538544+00	2025-12-29 18:54:52.538566+00	44
76	Genrih	Damascus					\N	\N		+4550852311	2025-12-31 13:44:15.078685+00	2025-12-31 13:44:15.078712+00	46
77	Genrih	Damascus					\N	\N		+4550852311	2026-01-04 19:06:36.128396+00	2026-01-04 19:06:36.128423+00	49
70	Nata	Hggjn	\N	\N	\N	\N	\N	\N	\N	+380952658345	2025-12-26 21:07:17.555632+00	2026-01-04 19:19:59.326407+00	42
63	Kateryna	Rost		Ukraine	Kharkiv	Kharkiv	Neskorenykh	10	11111	+380502333385	2025-12-26 09:32:11.905047+00	2025-12-26 09:32:11.905067+00	\N
64	Kateryna	Rost		Ukraine	Kharkiv	Kharkiv	Neskorenykh	10	11111	+380502333385	2025-12-26 15:50:49.085121+00	2025-12-26 15:50:49.085145+00	\N
65	Kateryna	Rost		Ukraine	Kharkiv	Kharkiv	Neskorenykh	10	11111	+380502333385	2025-12-26 16:17:55.2387+00	2025-12-26 16:17:55.238721+00	\N
66	Kateryna	Rost		Ukraine	Kharkiv	Kharkiv	Neskorenykh	10	11111	+380502333385	2025-12-26 16:18:46.960013+00	2025-12-26 16:18:46.960033+00	\N
67	Kateryna	Rost		Ukraine	Kharkiv	Kharkiv	Neskorenykh	10	11111	+380502333385	2025-12-26 16:35:45.99397+00	2025-12-26 16:35:45.994156+00	\N
68	Kateryna	Rost		Ukraine	Kharkiv	Kharkiv	Neskorenykh	10	11111	+380502333385	2025-12-26 18:59:40.023723+00	2025-12-26 18:59:40.023742+00	\N
69	Kateryna	Rost		Ukraine	Kharkiv	Kharkiv	Neskorenykh	10	11111	+380502333385	2025-12-26 19:04:46.657258+00	2025-12-26 19:04:46.657283+00	\N
71	Lex	Rost	\N	\N	\N	\N	\N	\N	\N	\N	2025-12-26 22:45:04.616706+00	2025-12-26 22:45:04.616728+00	43
72	Kateryna	Rost		Ukraine	Kharkiv	Kharkiv	Neskorenykh	10	11111	+380502333385	2025-12-27 16:24:19.221067+00	2025-12-27 16:24:19.22109+00	\N
12	Kateryna	Rost	Test	Ukraine	Kharkiv	Kharkiv	Neskorenykh	20	11111	+380502333399	2025-12-01 09:42:47.709939+00	2026-02-03 17:58:08.464264+00	13
\.


--
-- TOC entry 4363 (class 0 OID 17084)
-- Dependencies: 317
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-07-15 14:14:06
20211116045059	2025-07-15 14:14:08
20211116050929	2025-07-15 14:14:10
20211116051442	2025-07-15 14:14:12
20211116212300	2025-07-15 14:14:14
20211116213355	2025-07-15 14:14:16
20211116213934	2025-07-15 14:14:17
20211116214523	2025-07-15 14:14:20
20211122062447	2025-07-15 14:14:21
20211124070109	2025-07-15 14:14:23
20211202204204	2025-07-15 14:14:25
20211202204605	2025-07-15 14:14:26
20211210212804	2025-07-15 14:14:32
20211228014915	2025-07-15 14:14:33
20220107221237	2025-07-15 14:14:35
20220228202821	2025-07-15 14:14:37
20220312004840	2025-07-15 14:14:39
20220603231003	2025-07-15 14:14:41
20220603232444	2025-07-15 14:14:43
20220615214548	2025-07-15 14:14:45
20220712093339	2025-07-15 14:14:47
20220908172859	2025-07-15 14:14:48
20220916233421	2025-07-15 14:14:50
20230119133233	2025-07-15 14:14:52
20230128025114	2025-07-15 14:14:54
20230128025212	2025-07-15 14:14:56
20230227211149	2025-07-15 14:14:57
20230228184745	2025-07-15 14:14:59
20230308225145	2025-07-15 14:15:01
20230328144023	2025-07-15 14:15:02
20231018144023	2025-07-15 14:15:05
20231204144023	2025-07-15 14:15:07
20231204144024	2025-07-15 14:15:09
20231204144025	2025-07-15 14:15:11
20240108234812	2025-07-15 14:15:12
20240109165339	2025-07-15 14:15:14
20240227174441	2025-07-15 14:15:17
20240311171622	2025-07-15 14:15:19
20240321100241	2025-07-15 14:15:23
20240401105812	2025-07-15 14:15:28
20240418121054	2025-07-15 14:15:30
20240523004032	2025-07-15 14:15:36
20240618124746	2025-07-15 14:15:38
20240801235015	2025-07-15 14:15:40
20240805133720	2025-07-15 14:15:41
20240827160934	2025-07-15 14:15:43
20240919163303	2025-07-15 14:15:45
20240919163305	2025-07-15 14:15:47
20241019105805	2025-07-15 14:15:49
20241030150047	2025-07-15 14:15:55
20241108114728	2025-07-15 14:15:57
20241121104152	2025-07-15 14:15:59
20241130184212	2025-07-15 14:16:01
20241220035512	2025-07-15 14:16:03
20241220123912	2025-07-15 14:16:05
20241224161212	2025-07-15 14:16:06
20250107150512	2025-07-15 14:16:08
20250110162412	2025-07-15 14:16:10
20250123174212	2025-07-15 14:16:11
20250128220012	2025-07-15 14:16:13
20250506224012	2025-07-15 14:16:14
20250523164012	2025-07-15 14:16:16
20250714121412	2025-07-22 12:58:33
20250905041441	2026-01-02 21:21:42
20251103001201	2026-01-02 21:21:43
\.


--
-- TOC entry 4365 (class 0 OID 17107)
-- Dependencies: 320
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- TOC entry 4347 (class 0 OID 16544)
-- Dependencies: 298
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- TOC entry 4367 (class 0 OID 82006)
-- Dependencies: 325
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- TOC entry 4433 (class 0 OID 219045)
-- Dependencies: 391
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4349 (class 0 OID 16586)
-- Dependencies: 300
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-07-15 14:14:02.802771
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-07-15 14:14:02.817919
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-07-15 14:14:02.853138
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-07-15 14:14:02.885053
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-07-15 14:14:02.898709
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-07-15 14:14:02.904562
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-07-15 14:14:02.911399
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-07-15 14:14:02.91782
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-07-15 14:14:02.92463
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-07-15 14:14:02.931066
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-07-15 14:14:02.937489
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-07-15 14:14:02.944222
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-07-15 14:14:02.951301
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-07-15 14:14:02.95738
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-07-15 14:14:02.963594
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-07-15 14:14:02.982728
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-07-15 14:14:02.988867
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-07-15 14:14:02.995155
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-07-15 14:14:03.002468
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-07-15 14:14:03.010019
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-07-15 14:14:03.016587
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-07-15 14:14:03.027091
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-07-15 14:14:03.041896
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-07-15 14:14:03.053551
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-07-15 14:14:03.05979
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-07-15 14:14:03.06634
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-08-28 07:25:13.335395
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-08-28 07:25:13.464888
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2025-08-28 07:25:13.526165
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2025-08-28 07:25:13.541476
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2025-08-28 07:25:13.555198
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-08-28 07:25:13.565094
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-08-28 07:25:13.619631
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-08-28 07:25:13.640041
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-08-28 07:25:13.653582
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-08-28 07:25:13.725732
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2025-08-28 07:25:13.743942
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-08-28 07:25:13.76809
38	iceberg-catalog-flag-on-buckets	19a8bd89d5dfa69af7f222a46c726b7c41e462c5	2025-08-28 07:25:13.779961
39	add-search-v2-sort-support	39cf7d1e6bf515f4b02e41237aba845a7b492853	2026-01-02 21:21:31.02313
40	fix-prefix-race-conditions-optimized	fd02297e1c67df25a9fc110bf8c8a9af7fb06d1f	2026-01-02 21:21:31.044824
41	add-object-level-update-trigger	44c22478bf01744b2129efc480cd2edc9a7d60e9	2026-01-02 21:21:31.076342
42	rollback-prefix-triggers	f2ab4f526ab7f979541082992593938c05ee4b47	2026-01-02 21:21:31.083196
43	fix-object-level	ab837ad8f1c7d00cc0b7310e989a23388ff29fc6	2026-01-02 21:21:31.091948
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-01-02 21:21:31.095207
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-01-02 21:21:31.101691
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-01-02 21:21:31.174167
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-01-02 21:21:31.18533
48	iceberg-catalog-ids	2666dff93346e5d04e0a878416be1d5fec345d6f	2026-01-02 21:21:31.188127
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-01-02 21:21:31.235645
\.


--
-- TOC entry 4348 (class 0 OID 16559)
-- Dependencies: 299
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- TOC entry 4366 (class 0 OID 81962)
-- Dependencies: 324
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4361 (class 0 OID 17032)
-- Dependencies: 315
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- TOC entry 4362 (class 0 OID 17046)
-- Dependencies: 316
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- TOC entry 4434 (class 0 OID 219055)
-- Dependencies: 392
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3703 (class 0 OID 16656)
-- Dependencies: 301
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4537 (class 0 OID 0)
-- Dependencies: 293
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- TOC entry 4538 (class 0 OID 0)
-- Dependencies: 395
-- Name: accessory_photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accessory_photo_id_seq', 1, false);


--
-- TOC entry 4539 (class 0 OID 0)
-- Dependencies: 332
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 4540 (class 0 OID 0)
-- Dependencies: 334
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 4541 (class 0 OID 0)
-- Dependencies: 330
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 112, true);


--
-- TOC entry 4542 (class 0 OID 0)
-- Dependencies: 338
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- TOC entry 4543 (class 0 OID 0)
-- Dependencies: 336
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 49, true);


--
-- TOC entry 4544 (class 0 OID 0)
-- Dependencies: 340
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 4545 (class 0 OID 0)
-- Dependencies: 379
-- Name: basket_basket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.basket_basket_id_seq', 312, true);


--
-- TOC entry 4546 (class 0 OID 0)
-- Dependencies: 381
-- Name: basket_basketitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.basket_basketitem_id_seq', 136, true);


--
-- TOC entry 4547 (class 0 OID 0)
-- Dependencies: 377
-- Name: discount_codes_discountcode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.discount_codes_discountcode_id_seq', 2, true);


--
-- TOC entry 4548 (class 0 OID 0)
-- Dependencies: 344
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 20, true);


--
-- TOC entry 4549 (class 0 OID 0)
-- Dependencies: 348
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_celery_results_chordcounter_id_seq', 1, false);


--
-- TOC entry 4550 (class 0 OID 0)
-- Dependencies: 350
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_celery_results_groupresult_id_seq', 1, false);


--
-- TOC entry 4551 (class 0 OID 0)
-- Dependencies: 346
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_celery_results_taskresult_id_seq', 1, false);


--
-- TOC entry 4552 (class 0 OID 0)
-- Dependencies: 328
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 28, true);


--
-- TOC entry 4553 (class 0 OID 0)
-- Dependencies: 326
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 131, true);


--
-- TOC entry 4554 (class 0 OID 0)
-- Dependencies: 386
-- Name: favorites_favoriteitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favorites_favoriteitem_id_seq', 41, true);


--
-- TOC entry 4555 (class 0 OID 0)
-- Dependencies: 384
-- Name: favorites_favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favorites_favorites_id_seq', 1, true);


--
-- TOC entry 4556 (class 0 OID 0)
-- Dependencies: 352
-- Name: flavor_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flavor_profile_id_seq', 7, true);


--
-- TOC entry 4557 (class 0 OID 0)
-- Dependencies: 364
-- Name: order_positions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_positions_id_seq', 79, true);


--
-- TOC entry 4558 (class 0 OID 0)
-- Dependencies: 362
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 106, true);


--
-- TOC entry 4559 (class 0 OID 0)
-- Dependencies: 358
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.photo_id_seq', 1, false);


--
-- TOC entry 4560 (class 0 OID 0)
-- Dependencies: 356
-- Name: product_flavor_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_flavor_profiles_id_seq', 17, true);


--
-- TOC entry 4561 (class 0 OID 0)
-- Dependencies: 354
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 18, true);


--
-- TOC entry 4562 (class 0 OID 0)
-- Dependencies: 393
-- Name: products_accessory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_accessory_id_seq', 24, true);


--
-- TOC entry 4563 (class 0 OID 0)
-- Dependencies: 360
-- Name: products_photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_photo_id_seq', 79, true);


--
-- TOC entry 4564 (class 0 OID 0)
-- Dependencies: 366
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- TOC entry 4565 (class 0 OID 0)
-- Dependencies: 369
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 1, false);


--
-- TOC entry 4566 (class 0 OID 0)
-- Dependencies: 371
-- Name: supplies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplies_id_seq', 18, true);


--
-- TOC entry 4567 (class 0 OID 0)
-- Dependencies: 373
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_blacklist_blacklistedtoken_id_seq', 122, true);


--
-- TOC entry 4568 (class 0 OID 0)
-- Dependencies: 375
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_blacklist_outstandingtoken_id_seq', 709, true);


--
-- TOC entry 4569 (class 0 OID 0)
-- Dependencies: 342
-- Name: user_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_profile_id_seq', 77, true);


--
-- TOC entry 4570 (class 0 OID 0)
-- Dependencies: 319
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- TOC entry 3870 (class 2606 OID 16825)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 3824 (class 2606 OID 16529)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 3893 (class 2606 OID 16931)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 3848 (class 2606 OID 16949)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 3850 (class 2606 OID 16959)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 3822 (class 2606 OID 16522)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 3872 (class 2606 OID 16818)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 3868 (class 2606 OID 16806)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 3860 (class 2606 OID 16999)
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- TOC entry 3862 (class 2606 OID 16793)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 4078 (class 2606 OID 137078)
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- TOC entry 4080 (class 2606 OID 137076)
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- TOC entry 4082 (class 2606 OID 137074)
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- TOC entry 4092 (class 2606 OID 196815)
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- TOC entry 4064 (class 2606 OID 131470)
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- TOC entry 4086 (class 2606 OID 137100)
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- TOC entry 4088 (class 2606 OID 137102)
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- TOC entry 3897 (class 2606 OID 16984)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3816 (class 2606 OID 16512)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3819 (class 2606 OID 16736)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3882 (class 2606 OID 16865)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 3884 (class 2606 OID 16863)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3889 (class 2606 OID 16879)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 3827 (class 2606 OID 16535)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3855 (class 2606 OID 16757)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3879 (class 2606 OID 16846)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 3874 (class 2606 OID 16837)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3809 (class 2606 OID 16919)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 3811 (class 2606 OID 16499)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4105 (class 2606 OID 263314)
-- Name: accessory_photo accessory_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accessory_photo
    ADD CONSTRAINT accessory_photo_pkey PRIMARY KEY (id);


--
-- TOC entry 3934 (class 2606 OID 263324)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 3939 (class 2606 OID 116630)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 3942 (class 2606 OID 116619)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 3936 (class 2606 OID 116611)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3929 (class 2606 OID 116621)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 3931 (class 2606 OID 116605)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 3945 (class 2606 OID 116653)
-- Name: auth_user auth_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_email_key UNIQUE (email);


--
-- TOC entry 3950 (class 2606 OID 116659)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3953 (class 2606 OID 116678)
-- Name: auth_user_groups auth_user_groups_usermodel_id_group_id_7ca6416c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_usermodel_id_group_id_7ca6416c_uniq UNIQUE (usermodel_id, group_id);


--
-- TOC entry 3947 (class 2606 OID 116651)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 3955 (class 2606 OID 116692)
-- Name: auth_user_user_permissions auth_user_user_permissio_usermodel_id_permission__7325a6f6_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissio_usermodel_id_permission__7325a6f6_uniq UNIQUE (usermodel_id, permission_id);


--
-- TOC entry 3958 (class 2606 OID 116665)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4049 (class 2606 OID 126977)
-- Name: basket_basket basket_basket_guest_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket_basket
    ADD CONSTRAINT basket_basket_guest_token_key UNIQUE (guest_token);


--
-- TOC entry 4051 (class 2606 OID 126975)
-- Name: basket_basket basket_basket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket_basket
    ADD CONSTRAINT basket_basket_pkey PRIMARY KEY (id);


--
-- TOC entry 4053 (class 2606 OID 211186)
-- Name: basket_basket basket_basket_user_id_64ce4265_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket_basket
    ADD CONSTRAINT basket_basket_user_id_64ce4265_uniq UNIQUE (user_id);


--
-- TOC entry 4057 (class 2606 OID 126984)
-- Name: basket_basketitem basket_basketitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket_basketitem
    ADD CONSTRAINT basket_basketitem_pkey PRIMARY KEY (id);


--
-- TOC entry 4044 (class 2606 OID 126968)
-- Name: discount_codes_discountcode discount_codes_discountcode_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_codes_discountcode
    ADD CONSTRAINT discount_codes_discountcode_code_key UNIQUE (code);


--
-- TOC entry 4046 (class 2606 OID 126966)
-- Name: discount_codes_discountcode discount_codes_discountcode_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount_codes_discountcode
    ADD CONSTRAINT discount_codes_discountcode_pkey PRIMARY KEY (id);


--
-- TOC entry 3966 (class 2606 OID 116718)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3981 (class 2606 OID 116762)
-- Name: django_celery_results_chordcounter django_celery_results_chordcounter_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_chordcounter
    ADD CONSTRAINT django_celery_results_chordcounter_group_id_key UNIQUE (group_id);


--
-- TOC entry 3983 (class 2606 OID 116760)
-- Name: django_celery_results_chordcounter django_celery_results_chordcounter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_chordcounter
    ADD CONSTRAINT django_celery_results_chordcounter_pkey PRIMARY KEY (id);


--
-- TOC entry 3988 (class 2606 OID 116773)
-- Name: django_celery_results_groupresult django_celery_results_groupresult_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_groupresult
    ADD CONSTRAINT django_celery_results_groupresult_group_id_key UNIQUE (group_id);


--
-- TOC entry 3990 (class 2606 OID 116771)
-- Name: django_celery_results_groupresult django_celery_results_groupresult_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_groupresult
    ADD CONSTRAINT django_celery_results_groupresult_pkey PRIMARY KEY (id);


--
-- TOC entry 3975 (class 2606 OID 116738)
-- Name: django_celery_results_taskresult django_celery_results_taskresult_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_taskresult
    ADD CONSTRAINT django_celery_results_taskresult_pkey PRIMARY KEY (id);


--
-- TOC entry 3978 (class 2606 OID 116740)
-- Name: django_celery_results_taskresult django_celery_results_taskresult_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_taskresult
    ADD CONSTRAINT django_celery_results_taskresult_task_id_key UNIQUE (task_id);


--
-- TOC entry 3924 (class 2606 OID 116599)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 3926 (class 2606 OID 116597)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 3922 (class 2606 OID 116567)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4025 (class 2606 OID 116917)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 4071 (class 2606 OID 134801)
-- Name: favorites_favoriteitem favorites_favoriteitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites_favoriteitem
    ADD CONSTRAINT favorites_favoriteitem_pkey PRIMARY KEY (id);


--
-- TOC entry 4066 (class 2606 OID 134795)
-- Name: favorites_favorites favorites_favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites_favorites
    ADD CONSTRAINT favorites_favorites_pkey PRIMARY KEY (id);


--
-- TOC entry 3992 (class 2606 OID 116788)
-- Name: flavor_profile flavor_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flavor_profile
    ADD CONSTRAINT flavor_profile_pkey PRIMARY KEY (id);


--
-- TOC entry 4018 (class 2606 OID 116864)
-- Name: order_positions order_positions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_positions
    ADD CONSTRAINT order_positions_pkey PRIMARY KEY (id);


--
-- TOC entry 4014 (class 2606 OID 116858)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4006 (class 2606 OID 116810)
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- TOC entry 4000 (class 2606 OID 116804)
-- Name: product_flavor_profiles product_flavor_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_flavor_profiles
    ADD CONSTRAINT product_flavor_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4003 (class 2606 OID 116820)
-- Name: product_flavor_profiles product_flavor_profiles_product_id_flavorprofile_0b706861_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_flavor_profiles
    ADD CONSTRAINT product_flavor_profiles_product_id_flavorprofile_0b706861_uniq UNIQUE (product_id, flavorprofile_id);


--
-- TOC entry 3994 (class 2606 OID 116796)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 3997 (class 2606 OID 116798)
-- Name: product product_sku_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_sku_key UNIQUE (sku);


--
-- TOC entry 4099 (class 2606 OID 263306)
-- Name: products_accessory products_accessory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_accessory
    ADD CONSTRAINT products_accessory_pkey PRIMARY KEY (id);


--
-- TOC entry 4102 (class 2606 OID 263308)
-- Name: products_accessory products_accessory_sku_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_accessory
    ADD CONSTRAINT products_accessory_sku_key UNIQUE (sku);


--
-- TOC entry 4009 (class 2606 OID 116816)
-- Name: products_photo products_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_photo
    ADD CONSTRAINT products_photo_pkey PRIMARY KEY (id);


--
-- TOC entry 4022 (class 2606 OID 116904)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- TOC entry 4028 (class 2606 OID 116925)
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- TOC entry 4030 (class 2606 OID 116933)
-- Name: supplies supplies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplies
    ADD CONSTRAINT supplies_pkey PRIMARY KEY (id);


--
-- TOC entry 4033 (class 2606 OID 116979)
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_pkey PRIMARY KEY (id);


--
-- TOC entry 4035 (class 2606 OID 117000)
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_key UNIQUE (token_id);


--
-- TOC entry 4038 (class 2606 OID 116970)
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq UNIQUE (jti);


--
-- TOC entry 4040 (class 2606 OID 116988)
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_pkey PRIMARY KEY (id);


--
-- TOC entry 4061 (class 2606 OID 126986)
-- Name: basket_basketitem unique_basket_item; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket_basketitem
    ADD CONSTRAINT unique_basket_item UNIQUE (basket_id, product_id, accessory_id, supply_id);


--
-- TOC entry 4075 (class 2606 OID 134803)
-- Name: favorites_favoriteitem unique_favorite_item; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites_favoriteitem
    ADD CONSTRAINT unique_favorite_item UNIQUE (favorites_id, product_id, accessory_id, supply_id);


--
-- TOC entry 3961 (class 2606 OID 116673)
-- Name: user_profile user_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_pkey PRIMARY KEY (id);


--
-- TOC entry 3963 (class 2606 OID 116675)
-- Name: user_profile user_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_user_id_key UNIQUE (user_id);


--
-- TOC entry 3914 (class 2606 OID 17267)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3910 (class 2606 OID 17115)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 3907 (class 2606 OID 17088)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3919 (class 2606 OID 219078)
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- TOC entry 3830 (class 2606 OID 16552)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 4094 (class 2606 OID 219054)
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- TOC entry 3840 (class 2606 OID 16593)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 3842 (class 2606 OID 16591)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3838 (class 2606 OID 16569)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 3917 (class 2606 OID 81971)
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- TOC entry 3905 (class 2606 OID 17055)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 3903 (class 2606 OID 17040)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 4097 (class 2606 OID 219064)
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- TOC entry 3825 (class 1259 OID 16530)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 3799 (class 1259 OID 16746)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3800 (class 1259 OID 16748)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3801 (class 1259 OID 16749)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3858 (class 1259 OID 16827)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 3891 (class 1259 OID 16935)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 3846 (class 1259 OID 16915)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 4571 (class 0 OID 0)
-- Dependencies: 3846
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 3851 (class 1259 OID 16743)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 3894 (class 1259 OID 16932)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 4090 (class 1259 OID 196816)
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- TOC entry 3895 (class 1259 OID 16933)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 3866 (class 1259 OID 16938)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 3863 (class 1259 OID 16799)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 3864 (class 1259 OID 16944)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 4076 (class 1259 OID 137089)
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- TOC entry 4062 (class 1259 OID 131474)
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- TOC entry 4083 (class 1259 OID 137115)
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- TOC entry 4084 (class 1259 OID 137113)
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- TOC entry 4089 (class 1259 OID 137114)
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- TOC entry 3898 (class 1259 OID 16991)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 3899 (class 1259 OID 16990)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 3900 (class 1259 OID 16992)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 3802 (class 1259 OID 16750)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3803 (class 1259 OID 16747)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3812 (class 1259 OID 16513)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 3813 (class 1259 OID 16514)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 3814 (class 1259 OID 16742)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 3817 (class 1259 OID 16829)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 3820 (class 1259 OID 16934)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 3885 (class 1259 OID 16871)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 3886 (class 1259 OID 16936)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 3887 (class 1259 OID 16886)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 3890 (class 1259 OID 16885)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 3852 (class 1259 OID 16937)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 3853 (class 1259 OID 137127)
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- TOC entry 3856 (class 1259 OID 16828)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 3877 (class 1259 OID 16853)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 3880 (class 1259 OID 16852)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 3875 (class 1259 OID 16838)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 3876 (class 1259 OID 131453)
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- TOC entry 3865 (class 1259 OID 16997)
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- TOC entry 3857 (class 1259 OID 16826)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 3804 (class 1259 OID 16906)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 4572 (class 0 OID 0)
-- Dependencies: 3804
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 3805 (class 1259 OID 16744)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 3806 (class 1259 OID 16503)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 3807 (class 1259 OID 16961)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 4103 (class 1259 OID 263321)
-- Name: accessory_photo_accessory_id_b39a6abb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accessory_photo_accessory_id_b39a6abb ON public.accessory_photo USING btree (accessory_id);


--
-- TOC entry 3932 (class 1259 OID 263325)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 3937 (class 1259 OID 116641)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 3940 (class 1259 OID 116642)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 3927 (class 1259 OID 116627)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 3943 (class 1259 OID 116676)
-- Name: auth_user_email_1c89df09_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_email_1c89df09_like ON public.auth_user USING btree (email varchar_pattern_ops);


--
-- TOC entry 3948 (class 1259 OID 116690)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- TOC entry 3951 (class 1259 OID 116689)
-- Name: auth_user_groups_usermodel_id_eaf3a875; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_usermodel_id_eaf3a875 ON public.auth_user_groups USING btree (usermodel_id);


--
-- TOC entry 3956 (class 1259 OID 116704)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 3959 (class 1259 OID 116703)
-- Name: auth_user_user_permissions_usermodel_id_c47d54cf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_usermodel_id_c47d54cf ON public.auth_user_user_permissions USING btree (usermodel_id);


--
-- TOC entry 4047 (class 1259 OID 126997)
-- Name: basket_basket_discount_code_id_5dc73014; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX basket_basket_discount_code_id_5dc73014 ON public.basket_basket USING btree (discount_code_id);


--
-- TOC entry 4054 (class 1259 OID 127019)
-- Name: basket_basketitem_accessory_id_b477334e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX basket_basketitem_accessory_id_b477334e ON public.basket_basketitem USING btree (accessory_id);


--
-- TOC entry 4055 (class 1259 OID 127020)
-- Name: basket_basketitem_basket_id_54949c86; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX basket_basketitem_basket_id_54949c86 ON public.basket_basketitem USING btree (basket_id);


--
-- TOC entry 4058 (class 1259 OID 127021)
-- Name: basket_basketitem_product_id_14a4b24c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX basket_basketitem_product_id_14a4b24c ON public.basket_basketitem USING btree (product_id);


--
-- TOC entry 4059 (class 1259 OID 127022)
-- Name: basket_basketitem_supply_id_8cbdede0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX basket_basketitem_supply_id_8cbdede0 ON public.basket_basketitem USING btree (supply_id);


--
-- TOC entry 4042 (class 1259 OID 126969)
-- Name: discount_codes_discountcode_code_c1bdb523_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX discount_codes_discountcode_code_c1bdb523_like ON public.discount_codes_discountcode USING btree (code varchar_pattern_ops);


--
-- TOC entry 3964 (class 1259 OID 116729)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 3967 (class 1259 OID 116730)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 3984 (class 1259 OID 116779)
-- Name: django_cele_date_cr_bd6c1d_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_date_cr_bd6c1d_idx ON public.django_celery_results_groupresult USING btree (date_created);


--
-- TOC entry 3968 (class 1259 OID 116777)
-- Name: django_cele_date_cr_f04a50_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_date_cr_f04a50_idx ON public.django_celery_results_taskresult USING btree (date_created);


--
-- TOC entry 3985 (class 1259 OID 116780)
-- Name: django_cele_date_do_caae0e_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_date_do_caae0e_idx ON public.django_celery_results_groupresult USING btree (date_done);


--
-- TOC entry 3969 (class 1259 OID 116778)
-- Name: django_cele_date_do_f59aad_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_date_do_f59aad_idx ON public.django_celery_results_taskresult USING btree (date_done);


--
-- TOC entry 3970 (class 1259 OID 116782)
-- Name: django_cele_periodi_1993cf_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_periodi_1993cf_idx ON public.django_celery_results_taskresult USING btree (periodic_task_name);


--
-- TOC entry 3971 (class 1259 OID 116775)
-- Name: django_cele_status_9b6201_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_status_9b6201_idx ON public.django_celery_results_taskresult USING btree (status);


--
-- TOC entry 3972 (class 1259 OID 116774)
-- Name: django_cele_task_na_08aec9_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_task_na_08aec9_idx ON public.django_celery_results_taskresult USING btree (task_name);


--
-- TOC entry 3973 (class 1259 OID 116776)
-- Name: django_cele_worker_d54dd8_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_worker_d54dd8_idx ON public.django_celery_results_taskresult USING btree (worker);


--
-- TOC entry 3979 (class 1259 OID 116763)
-- Name: django_celery_results_chordcounter_group_id_1f70858c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_celery_results_chordcounter_group_id_1f70858c_like ON public.django_celery_results_chordcounter USING btree (group_id varchar_pattern_ops);


--
-- TOC entry 3986 (class 1259 OID 116781)
-- Name: django_celery_results_groupresult_group_id_a085f1a9_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_celery_results_groupresult_group_id_a085f1a9_like ON public.django_celery_results_groupresult USING btree (group_id varchar_pattern_ops);


--
-- TOC entry 3976 (class 1259 OID 116741)
-- Name: django_celery_results_taskresult_task_id_de0d95bf_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_celery_results_taskresult_task_id_de0d95bf_like ON public.django_celery_results_taskresult USING btree (task_id varchar_pattern_ops);


--
-- TOC entry 4023 (class 1259 OID 116919)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 4026 (class 1259 OID 116918)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 4068 (class 1259 OID 134830)
-- Name: favorites_favoriteitem_accessory_id_629b369f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX favorites_favoriteitem_accessory_id_629b369f ON public.favorites_favoriteitem USING btree (accessory_id);


--
-- TOC entry 4069 (class 1259 OID 134833)
-- Name: favorites_favoriteitem_favorites_id_e84bb11d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX favorites_favoriteitem_favorites_id_e84bb11d ON public.favorites_favoriteitem USING btree (favorites_id);


--
-- TOC entry 4072 (class 1259 OID 134831)
-- Name: favorites_favoriteitem_product_id_513dc050; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX favorites_favoriteitem_product_id_513dc050 ON public.favorites_favoriteitem USING btree (product_id);


--
-- TOC entry 4073 (class 1259 OID 134832)
-- Name: favorites_favoriteitem_supply_id_aec73843; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX favorites_favoriteitem_supply_id_aec73843 ON public.favorites_favoriteitem USING btree (supply_id);


--
-- TOC entry 4067 (class 1259 OID 134809)
-- Name: favorites_favorites_user_id_8a569da5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX favorites_favorites_user_id_8a569da5 ON public.favorites_favorites USING btree (user_id);


--
-- TOC entry 4015 (class 1259 OID 116894)
-- Name: order_positions_accessory_id_c093380f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_positions_accessory_id_c093380f ON public.order_positions USING btree (accessory_id);


--
-- TOC entry 4016 (class 1259 OID 116895)
-- Name: order_positions_order_id_0f31ce27; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_positions_order_id_0f31ce27 ON public.order_positions USING btree (order_id);


--
-- TOC entry 4019 (class 1259 OID 116896)
-- Name: order_positions_product_id_ccc66e8c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_positions_product_id_ccc66e8c ON public.order_positions USING btree (product_id);


--
-- TOC entry 4011 (class 1259 OID 116893)
-- Name: orders_customer_id_b7016332; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_customer_id_b7016332 ON public.orders USING btree (customer_id);


--
-- TOC entry 4012 (class 1259 OID 127028)
-- Name: orders_discount_code_id_48b11c35; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_discount_code_id_48b11c35 ON public.orders USING btree (discount_code_id);


--
-- TOC entry 4004 (class 1259 OID 116843)
-- Name: photo_accessory_id_de9e1a37; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX photo_accessory_id_de9e1a37 ON public.photo USING btree (accessory_id);


--
-- TOC entry 4007 (class 1259 OID 116844)
-- Name: photo_product_id_47bb5c8f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX photo_product_id_47bb5c8f ON public.photo USING btree (product_id);


--
-- TOC entry 3998 (class 1259 OID 116832)
-- Name: product_flavor_profiles_flavorprofile_id_918b36f1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_flavor_profiles_flavorprofile_id_918b36f1 ON public.product_flavor_profiles USING btree (flavorprofile_id);


--
-- TOC entry 4001 (class 1259 OID 116831)
-- Name: product_flavor_profiles_product_id_a31500db; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_flavor_profiles_product_id_a31500db ON public.product_flavor_profiles USING btree (product_id);


--
-- TOC entry 3995 (class 1259 OID 116818)
-- Name: product_sku_1e15f61e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_sku_1e15f61e_like ON public.product USING btree (sku varchar_pattern_ops);


--
-- TOC entry 4100 (class 1259 OID 263315)
-- Name: products_accessory_sku_4df0b38f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_accessory_sku_4df0b38f_like ON public.products_accessory USING btree (sku varchar_pattern_ops);


--
-- TOC entry 4010 (class 1259 OID 116850)
-- Name: products_photo_product_id_05315375; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_photo_product_id_05315375 ON public.products_photo USING btree (product_id);


--
-- TOC entry 4020 (class 1259 OID 116910)
-- Name: reviews_customer_id_a074204f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reviews_customer_id_a074204f ON public.reviews USING btree (customer_id);


--
-- TOC entry 4031 (class 1259 OID 116939)
-- Name: supplies_product_id_106569f4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX supplies_product_id_106569f4 ON public.supplies USING btree (product_id);


--
-- TOC entry 4036 (class 1259 OID 116971)
-- Name: token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like ON public.token_blacklist_outstandingtoken USING btree (jti varchar_pattern_ops);


--
-- TOC entry 4041 (class 1259 OID 116968)
-- Name: token_blacklist_outstandingtoken_user_id_83bc629a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX token_blacklist_outstandingtoken_user_id_83bc629a ON public.token_blacklist_outstandingtoken USING btree (user_id);


--
-- TOC entry 3908 (class 1259 OID 17268)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- TOC entry 3912 (class 1259 OID 219080)
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 3911 (class 1259 OID 17168)
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- TOC entry 3828 (class 1259 OID 16558)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 3831 (class 1259 OID 16580)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 3920 (class 1259 OID 219079)
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- TOC entry 3901 (class 1259 OID 17066)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 3832 (class 1259 OID 81989)
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- TOC entry 3833 (class 1259 OID 17031)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 3834 (class 1259 OID 81991)
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- TOC entry 3915 (class 1259 OID 81992)
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- TOC entry 3835 (class 1259 OID 16581)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 3836 (class 1259 OID 81990)
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- TOC entry 4095 (class 1259 OID 219070)
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- TOC entry 4165 (class 2620 OID 17120)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 4160 (class 2620 OID 81999)
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- TOC entry 4161 (class 2620 OID 219042)
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- TOC entry 4162 (class 2620 OID 81985)
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- TOC entry 4163 (class 2620 OID 219041)
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- TOC entry 4166 (class 2620 OID 81995)
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- TOC entry 4167 (class 2620 OID 219043)
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- TOC entry 4164 (class 2620 OID 17019)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 4108 (class 2606 OID 16730)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4113 (class 2606 OID 16819)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4112 (class 2606 OID 16807)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 4111 (class 2606 OID 16794)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4154 (class 2606 OID 137079)
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4155 (class 2606 OID 137084)
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4156 (class 2606 OID 137108)
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4157 (class 2606 OID 137103)
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4118 (class 2606 OID 16985)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4106 (class 2606 OID 16763)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4115 (class 2606 OID 16866)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4116 (class 2606 OID 16939)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 4117 (class 2606 OID 16880)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4109 (class 2606 OID 137122)
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4110 (class 2606 OID 16758)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4114 (class 2606 OID 16847)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4159 (class 2606 OID 263316)
-- Name: accessory_photo accessory_photo_accessory_id_b39a6abb_fk_products_accessory_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accessory_photo
    ADD CONSTRAINT accessory_photo_accessory_id_b39a6abb_fk_products_accessory_id FOREIGN KEY (accessory_id) REFERENCES public.products_accessory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4124 (class 2606 OID 116636)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4125 (class 2606 OID 116631)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4123 (class 2606 OID 116622)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4126 (class 2606 OID 116684)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4127 (class 2606 OID 116679)
-- Name: auth_user_groups auth_user_groups_usermodel_id_eaf3a875_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_usermodel_id_eaf3a875_fk_auth_user_id FOREIGN KEY (usermodel_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4128 (class 2606 OID 116698)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4129 (class 2606 OID 116693)
-- Name: auth_user_user_permissions auth_user_user_permi_usermodel_id_c47d54cf_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_usermodel_id_c47d54cf_fk_auth_user FOREIGN KEY (usermodel_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4145 (class 2606 OID 126987)
-- Name: basket_basket basket_basket_discount_code_id_5dc73014_fk_discount_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket_basket
    ADD CONSTRAINT basket_basket_discount_code_id_5dc73014_fk_discount_ FOREIGN KEY (discount_code_id) REFERENCES public.discount_codes_discountcode(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4146 (class 2606 OID 211187)
-- Name: basket_basket basket_basket_user_id_64ce4265_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket_basket
    ADD CONSTRAINT basket_basket_user_id_64ce4265_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4147 (class 2606 OID 127004)
-- Name: basket_basketitem basket_basketitem_basket_id_54949c86_fk_basket_basket_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket_basketitem
    ADD CONSTRAINT basket_basketitem_basket_id_54949c86_fk_basket_basket_id FOREIGN KEY (basket_id) REFERENCES public.basket_basket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4148 (class 2606 OID 127009)
-- Name: basket_basketitem basket_basketitem_product_id_14a4b24c_fk_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket_basketitem
    ADD CONSTRAINT basket_basketitem_product_id_14a4b24c_fk_product_id FOREIGN KEY (product_id) REFERENCES public.product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4149 (class 2606 OID 127014)
-- Name: basket_basketitem basket_basketitem_supply_id_8cbdede0_fk_supplies_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.basket_basketitem
    ADD CONSTRAINT basket_basketitem_supply_id_8cbdede0_fk_supplies_id FOREIGN KEY (supply_id) REFERENCES public.supplies(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4131 (class 2606 OID 116719)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4132 (class 2606 OID 116724)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4151 (class 2606 OID 134825)
-- Name: favorites_favoriteitem favorites_favoriteit_favorites_id_e84bb11d_fk_favorites; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites_favoriteitem
    ADD CONSTRAINT favorites_favoriteit_favorites_id_e84bb11d_fk_favorites FOREIGN KEY (favorites_id) REFERENCES public.favorites_favorites(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4152 (class 2606 OID 134815)
-- Name: favorites_favoriteitem favorites_favoriteitem_product_id_513dc050_fk_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites_favoriteitem
    ADD CONSTRAINT favorites_favoriteitem_product_id_513dc050_fk_product_id FOREIGN KEY (product_id) REFERENCES public.product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4153 (class 2606 OID 134820)
-- Name: favorites_favoriteitem favorites_favoriteitem_supply_id_aec73843_fk_supplies_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites_favoriteitem
    ADD CONSTRAINT favorites_favoriteitem_supply_id_aec73843_fk_supplies_id FOREIGN KEY (supply_id) REFERENCES public.supplies(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4150 (class 2606 OID 134804)
-- Name: favorites_favorites favorites_favorites_user_id_8a569da5_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites_favorites
    ADD CONSTRAINT favorites_favorites_user_id_8a569da5_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4139 (class 2606 OID 116882)
-- Name: order_positions order_positions_order_id_0f31ce27_fk_orders_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_positions
    ADD CONSTRAINT order_positions_order_id_0f31ce27_fk_orders_id FOREIGN KEY (order_id) REFERENCES public.orders(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4140 (class 2606 OID 116887)
-- Name: order_positions order_positions_product_id_ccc66e8c_fk_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_positions
    ADD CONSTRAINT order_positions_product_id_ccc66e8c_fk_product_id FOREIGN KEY (product_id) REFERENCES public.product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4137 (class 2606 OID 116872)
-- Name: orders orders_customer_id_b7016332_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_b7016332_fk_auth_user_id FOREIGN KEY (customer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4138 (class 2606 OID 127023)
-- Name: orders orders_discount_code_id_48b11c35_fk_discount_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_discount_code_id_48b11c35_fk_discount_ FOREIGN KEY (discount_code_id) REFERENCES public.discount_codes_discountcode(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4135 (class 2606 OID 116838)
-- Name: photo photo_product_id_47bb5c8f_fk_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_product_id_47bb5c8f_fk_product_id FOREIGN KEY (product_id) REFERENCES public.product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4133 (class 2606 OID 116826)
-- Name: product_flavor_profiles product_flavor_profi_flavorprofile_id_918b36f1_fk_flavor_pr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_flavor_profiles
    ADD CONSTRAINT product_flavor_profi_flavorprofile_id_918b36f1_fk_flavor_pr FOREIGN KEY (flavorprofile_id) REFERENCES public.flavor_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4134 (class 2606 OID 116821)
-- Name: product_flavor_profiles product_flavor_profiles_product_id_a31500db_fk_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_flavor_profiles
    ADD CONSTRAINT product_flavor_profiles_product_id_a31500db_fk_product_id FOREIGN KEY (product_id) REFERENCES public.product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4136 (class 2606 OID 116845)
-- Name: products_photo products_photo_product_id_05315375_fk_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_photo
    ADD CONSTRAINT products_photo_product_id_05315375_fk_product_id FOREIGN KEY (product_id) REFERENCES public.product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4141 (class 2606 OID 116905)
-- Name: reviews reviews_customer_id_a074204f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_customer_id_a074204f_fk_auth_user_id FOREIGN KEY (customer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4142 (class 2606 OID 116934)
-- Name: supplies supplies_product_id_106569f4_fk_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplies
    ADD CONSTRAINT supplies_product_id_106569f4_fk_product_id FOREIGN KEY (product_id) REFERENCES public.product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4143 (class 2606 OID 117006)
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk FOREIGN KEY (token_id) REFERENCES public.token_blacklist_outstandingtoken(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4144 (class 2606 OID 116972)
-- Name: token_blacklist_outstandingtoken token_blacklist_outs_user_id_83bc629a_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outs_user_id_83bc629a_fk_auth_user FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4130 (class 2606 OID 116705)
-- Name: user_profile user_profile_user_id_8fdce8e2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_user_id_8fdce8e2_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4107 (class 2606 OID 16570)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4122 (class 2606 OID 81972)
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4119 (class 2606 OID 17041)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4120 (class 2606 OID 17061)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4121 (class 2606 OID 17056)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 4158 (class 2606 OID 219065)
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- TOC entry 4317 (class 0 OID 16523)
-- Dependencies: 296
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4331 (class 0 OID 16925)
-- Dependencies: 313
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4322 (class 0 OID 16723)
-- Dependencies: 304
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4316 (class 0 OID 16516)
-- Dependencies: 295
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4326 (class 0 OID 16812)
-- Dependencies: 308
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4325 (class 0 OID 16800)
-- Dependencies: 307
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4324 (class 0 OID 16787)
-- Dependencies: 306
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4332 (class 0 OID 16975)
-- Dependencies: 314
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4315 (class 0 OID 16505)
-- Dependencies: 294
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4329 (class 0 OID 16854)
-- Dependencies: 311
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4330 (class 0 OID 16872)
-- Dependencies: 312
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4318 (class 0 OID 16531)
-- Dependencies: 297
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4323 (class 0 OID 16753)
-- Dependencies: 305
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4328 (class 0 OID 16839)
-- Dependencies: 310
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4327 (class 0 OID 16830)
-- Dependencies: 309
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4314 (class 0 OID 16493)
-- Dependencies: 292
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4335 (class 0 OID 17253)
-- Dependencies: 323
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4319 (class 0 OID 16544)
-- Dependencies: 298
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4337 (class 0 OID 82006)
-- Dependencies: 325
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4338 (class 0 OID 219045)
-- Dependencies: 391
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4321 (class 0 OID 16586)
-- Dependencies: 300
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4320 (class 0 OID 16559)
-- Dependencies: 299
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4336 (class 0 OID 81962)
-- Dependencies: 324
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4333 (class 0 OID 17032)
-- Dependencies: 315
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4334 (class 0 OID 17046)
-- Dependencies: 316
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4339 (class 0 OID 219055)
-- Dependencies: 392
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4340 (class 6104 OID 16426)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 4444 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- TOC entry 4446 (class 0 OID 0)
-- Dependencies: 9
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- TOC entry 4447 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 4448 (class 0 OID 0)
-- Dependencies: 14
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 4449 (class 0 OID 0)
-- Dependencies: 10
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- TOC entry 4453 (class 0 OID 0)
-- Dependencies: 411
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- TOC entry 4454 (class 0 OID 0)
-- Dependencies: 424
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 4456 (class 0 OID 0)
-- Dependencies: 410
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- TOC entry 4458 (class 0 OID 0)
-- Dependencies: 409
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- TOC entry 4459 (class 0 OID 0)
-- Dependencies: 423
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 4460 (class 0 OID 0)
-- Dependencies: 408
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- TOC entry 4461 (class 0 OID 0)
-- Dependencies: 439
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4462 (class 0 OID 0)
-- Dependencies: 445
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- TOC entry 4463 (class 0 OID 0)
-- Dependencies: 441
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 4464 (class 0 OID 0)
-- Dependencies: 437
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 4465 (class 0 OID 0)
-- Dependencies: 436
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 4466 (class 0 OID 0)
-- Dependencies: 440
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 4467 (class 0 OID 0)
-- Dependencies: 442
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4468 (class 0 OID 0)
-- Dependencies: 435
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 4469 (class 0 OID 0)
-- Dependencies: 444
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- TOC entry 4470 (class 0 OID 0)
-- Dependencies: 434
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 4471 (class 0 OID 0)
-- Dependencies: 438
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 4472 (class 0 OID 0)
-- Dependencies: 443
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- TOC entry 4473 (class 0 OID 0)
-- Dependencies: 413
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- TOC entry 4474 (class 0 OID 0)
-- Dependencies: 415
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4475 (class 0 OID 0)
-- Dependencies: 416
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4477 (class 0 OID 0)
-- Dependencies: 296
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- TOC entry 4479 (class 0 OID 0)
-- Dependencies: 313
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 4482 (class 0 OID 0)
-- Dependencies: 304
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 4484 (class 0 OID 0)
-- Dependencies: 295
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- TOC entry 4486 (class 0 OID 0)
-- Dependencies: 308
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 4488 (class 0 OID 0)
-- Dependencies: 307
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 4491 (class 0 OID 0)
-- Dependencies: 306
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 4492 (class 0 OID 0)
-- Dependencies: 388
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- TOC entry 4494 (class 0 OID 0)
-- Dependencies: 390
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- TOC entry 4495 (class 0 OID 0)
-- Dependencies: 383
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- TOC entry 4496 (class 0 OID 0)
-- Dependencies: 389
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- TOC entry 4497 (class 0 OID 0)
-- Dependencies: 314
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 4499 (class 0 OID 0)
-- Dependencies: 294
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- TOC entry 4501 (class 0 OID 0)
-- Dependencies: 293
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 4503 (class 0 OID 0)
-- Dependencies: 311
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 4505 (class 0 OID 0)
-- Dependencies: 312
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 4507 (class 0 OID 0)
-- Dependencies: 297
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- TOC entry 4512 (class 0 OID 0)
-- Dependencies: 305
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 4514 (class 0 OID 0)
-- Dependencies: 310
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 4517 (class 0 OID 0)
-- Dependencies: 309
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 4520 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- TOC entry 4521 (class 0 OID 0)
-- Dependencies: 323
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- TOC entry 4522 (class 0 OID 0)
-- Dependencies: 317
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 4523 (class 0 OID 0)
-- Dependencies: 320
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 4524 (class 0 OID 0)
-- Dependencies: 319
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 4526 (class 0 OID 0)
-- Dependencies: 298
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.buckets FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.buckets TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- TOC entry 4527 (class 0 OID 0)
-- Dependencies: 325
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- TOC entry 4528 (class 0 OID 0)
-- Dependencies: 391
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- TOC entry 4530 (class 0 OID 0)
-- Dependencies: 299
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

REVOKE ALL ON TABLE storage.objects FROM supabase_storage_admin;
GRANT ALL ON TABLE storage.objects TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- TOC entry 4531 (class 0 OID 0)
-- Dependencies: 324
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.prefixes TO service_role;
GRANT ALL ON TABLE storage.prefixes TO authenticated;
GRANT ALL ON TABLE storage.prefixes TO anon;


--
-- TOC entry 4532 (class 0 OID 0)
-- Dependencies: 315
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- TOC entry 4533 (class 0 OID 0)
-- Dependencies: 316
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- TOC entry 4534 (class 0 OID 0)
-- Dependencies: 392
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- TOC entry 4535 (class 0 OID 0)
-- Dependencies: 301
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- TOC entry 4536 (class 0 OID 0)
-- Dependencies: 302
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- TOC entry 2525 (class 826 OID 16601)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2526 (class 826 OID 16602)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2524 (class 826 OID 16600)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2535 (class 826 OID 16635)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2534 (class 826 OID 16634)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2533 (class 826 OID 16633)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2530 (class 826 OID 16615)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2532 (class 826 OID 16614)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2531 (class 826 OID 16613)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2528 (class 826 OID 16605)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2529 (class 826 OID 16606)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2527 (class 826 OID 16604)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2523 (class 826 OID 16543)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2522 (class 826 OID 16542)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2521 (class 826 OID 16541)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


-- Completed on 2026-02-11 19:42:01 UTC

--
-- PostgreSQL database dump complete
--

\unrestrict aAeDnK4fPtX4VOqdkS14OwMtMVEyqf0neIKUPNeBDUuCtWvQSbaRmgrfbbWERJd

