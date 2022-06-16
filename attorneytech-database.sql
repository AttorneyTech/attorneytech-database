PGDMP     
    #                z            attorneytech    14.3 (Debian 14.3-1.pgdg110+1)    14.3 )    .           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            /           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            0           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            1           1262    16384    attorneytech    DATABASE     `   CREATE DATABASE attorneytech WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE attorneytech;
                postgres    false            �            1259    16449    cases    TABLE     �  CREATE TABLE public.cases (
    id integer NOT NULL,
    category character varying(20) NOT NULL,
    year integer NOT NULL,
    type character varying(50),
    number integer,
    cause_of_action character varying(100),
    event_id integer NOT NULL,
    section_in_charge_id integer,
    court_id integer,
    client_id integer NOT NULL,
    agent_id integer NOT NULL,
    opposite_client_id integer NOT NULL,
    opposite_agent_id integer
);
    DROP TABLE public.cases;
       public         heap    postgres    false            �            1259    16448    cases_id_seq    SEQUENCE     �   ALTER TABLE public.cases ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    222            �            1259    16412    courts    TABLE       CREATE TABLE public.courts (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    phone character varying(50) NOT NULL,
    street_name character varying(100),
    district character varying(20),
    city character varying(20),
    zip_code character varying(10)
);
    DROP TABLE public.courts;
       public         heap    postgres    false            �            1259    16411    courts_id_seq    SEQUENCE     �   ALTER TABLE public.courts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.courts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    216            �            1259    16431    events    TABLE     �   CREATE TABLE public.events (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    client_id integer,
    opposite_client_id integer
);
    DROP TABLE public.events;
       public         heap    postgres    false            �            1259    16430    events_id_seq    SEQUENCE     �   ALTER TABLE public.events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220            �            1259    16406    opposite_agents    TABLE     �  CREATE TABLE public.opposite_agents (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    middle_name character varying(50),
    last_name character varying(50) NOT NULL,
    email character varying(50),
    phone character varying(50),
    street_name character varying(100),
    district character varying(20),
    city character varying(20),
    zip_code character varying(10)
);
 #   DROP TABLE public.opposite_agents;
       public         heap    postgres    false            �            1259    16405    opposite_agents_id_seq    SEQUENCE     �   ALTER TABLE public.opposite_agents ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.opposite_agents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    214            �            1259    16400    opposite_clients    TABLE     w  CREATE TABLE public.opposite_clients (
    id integer NOT NULL,
    name character varying(100),
    first_name character varying(50) NOT NULL,
    middle_name character varying(50),
    last_name character varying(50) NOT NULL,
    street_name character varying(100),
    district character varying(20),
    city character varying(20),
    zip_code character varying(10)
);
 $   DROP TABLE public.opposite_clients;
       public         heap    postgres    false            �            1259    16399    opposite_clients_id_seq    SEQUENCE     �   ALTER TABLE public.opposite_clients ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.opposite_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    212            �            1259    16490    papers    TABLE     �  CREATE TABLE public.papers (
    id integer NOT NULL,
    category character varying(50) NOT NULL,
    title character varying(100) NOT NULL,
    subject character varying(400) NOT NULL,
    sent_date date,
    arrival_date date,
    received_date date,
    deadline_date date,
    court_date timestamp without time zone,
    paper_type character varying(50) NOT NULL,
    case_id integer NOT NULL
);
    DROP TABLE public.papers;
       public         heap    postgres    false            �            1259    16489    papers_id_seq    SEQUENCE     �   ALTER TABLE public.papers ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.papers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    224            �            1259    16420    section_in_charges    TABLE     �   CREATE TABLE public.section_in_charges (
    id integer NOT NULL,
    name character varying(20),
    clerk_first_name character varying(50),
    clerk_last_name character varying(50),
    extension_number character varying(50),
    court_id integer
);
 &   DROP TABLE public.section_in_charges;
       public         heap    postgres    false            �            1259    16419    section_in_charges_id_seq    SEQUENCE     �   ALTER TABLE public.section_in_charges ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.section_in_charges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            �            1259    16392    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    role character varying(50) NOT NULL,
    username character varying(20),
    password character varying(64),
    first_name character varying(50) NOT NULL,
    middle_name character varying(50),
    last_name character varying(50) NOT NULL,
    email character varying(50),
    phone character varying(50),
    street_name character varying(100),
    district character varying(20),
    city character varying(20),
    zip_code character varying(10)
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16391    users_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    210            �           2606    16453    cases cases_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.cases DROP CONSTRAINT cases_pkey;
       public            postgres    false    222            �           2606    16418    courts courts_name_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.courts
    ADD CONSTRAINT courts_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.courts DROP CONSTRAINT courts_name_key;
       public            postgres    false    216            �           2606    16416    courts courts_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.courts
    ADD CONSTRAINT courts_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.courts DROP CONSTRAINT courts_pkey;
       public            postgres    false    216            �           2606    16437    events events_name_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.events DROP CONSTRAINT events_name_key;
       public            postgres    false    220            �           2606    16435    events events_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.events DROP CONSTRAINT events_pkey;
       public            postgres    false    220            �           2606    16410 $   opposite_agents opposite_agents_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.opposite_agents
    ADD CONSTRAINT opposite_agents_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.opposite_agents DROP CONSTRAINT opposite_agents_pkey;
       public            postgres    false    214            �           2606    16404 &   opposite_clients opposite_clients_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.opposite_clients
    ADD CONSTRAINT opposite_clients_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.opposite_clients DROP CONSTRAINT opposite_clients_pkey;
       public            postgres    false    212            �           2606    16496    papers papers_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.papers
    ADD CONSTRAINT papers_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.papers DROP CONSTRAINT papers_pkey;
       public            postgres    false    224            �           2606    16424 *   section_in_charges section_in_charges_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.section_in_charges
    ADD CONSTRAINT section_in_charges_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.section_in_charges DROP CONSTRAINT section_in_charges_pkey;
       public            postgres    false    218            �           2606    16398    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    210            �           2606    16474    cases cases_agent_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.users(id);
 C   ALTER TABLE ONLY public.cases DROP CONSTRAINT cases_agent_id_fkey;
       public          postgres    false    210    222    3203            �           2606    16469    cases cases_client_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.users(id);
 D   ALTER TABLE ONLY public.cases DROP CONSTRAINT cases_client_id_fkey;
       public          postgres    false    222    210    3203            �           2606    16464    cases cases_court_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_court_id_fkey FOREIGN KEY (court_id) REFERENCES public.courts(id);
 C   ALTER TABLE ONLY public.cases DROP CONSTRAINT cases_court_id_fkey;
       public          postgres    false    222    3211    216            �           2606    16454    cases cases_event_id_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id);
 C   ALTER TABLE ONLY public.cases DROP CONSTRAINT cases_event_id_fkey;
       public          postgres    false    220    222    3217            �           2606    16484 "   cases cases_opposite_agent_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_opposite_agent_id_fkey FOREIGN KEY (opposite_agent_id) REFERENCES public.opposite_agents(id);
 L   ALTER TABLE ONLY public.cases DROP CONSTRAINT cases_opposite_agent_id_fkey;
       public          postgres    false    222    214    3207            �           2606    16479 #   cases cases_opposite_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_opposite_client_id_fkey FOREIGN KEY (opposite_client_id) REFERENCES public.opposite_clients(id);
 M   ALTER TABLE ONLY public.cases DROP CONSTRAINT cases_opposite_client_id_fkey;
       public          postgres    false    222    212    3205            �           2606    16459 %   cases cases_section_in_charge_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_section_in_charge_id_fkey FOREIGN KEY (section_in_charge_id) REFERENCES public.section_in_charges(id);
 O   ALTER TABLE ONLY public.cases DROP CONSTRAINT cases_section_in_charge_id_fkey;
       public          postgres    false    3213    222    218            �           2606    16438    events events_client_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.users(id);
 F   ALTER TABLE ONLY public.events DROP CONSTRAINT events_client_id_fkey;
       public          postgres    false    220    210    3203            �           2606    16443 %   events events_opposite_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_opposite_client_id_fkey FOREIGN KEY (opposite_client_id) REFERENCES public.opposite_clients(id);
 O   ALTER TABLE ONLY public.events DROP CONSTRAINT events_opposite_client_id_fkey;
       public          postgres    false    220    212    3205            �           2606    16497    papers papers_case_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.papers
    ADD CONSTRAINT papers_case_id_fkey FOREIGN KEY (case_id) REFERENCES public.cases(id);
 D   ALTER TABLE ONLY public.papers DROP CONSTRAINT papers_case_id_fkey;
       public          postgres    false    3219    224    222            �           2606    16425 3   section_in_charges section_in_charges_court_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.section_in_charges
    ADD CONSTRAINT section_in_charges_court_id_fkey FOREIGN KEY (court_id) REFERENCES public.courts(id);
 ]   ALTER TABLE ONLY public.section_in_charges DROP CONSTRAINT section_in_charges_court_id_fkey;
       public          postgres    false    3211    216    218           