PGDMP                         {            StoredProducer    15.1    15.1 f    t           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            u           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            v           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            w           1262    17222    StoredProducer    DATABASE     �   CREATE DATABASE "StoredProducer" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
     DROP DATABASE "StoredProducer";
                postgres    false            �            1255    25645    delete_from_table2()    FUNCTION     �   CREATE FUNCTION public.delete_from_table2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM table2 WHERE id = OLD.id;
    RETURN OLD;
END;
$$;
 +   DROP FUNCTION public.delete_from_table2();
       public          postgres    false            �            1255    17299 .   get_customer_orders_by_name(character varying)    FUNCTION     �  CREATE FUNCTION public.get_customer_orders_by_name(customer_name_param character varying) RETURNS TABLE(order_id integer, customer_name character varying, order_date date, total_amount numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        o.id AS order_id,
        c.name AS customer_name,
        o.order_date,
        o.total_amount
    FROM
        orders o
    INNER JOIN
        customers c ON o.customer_id = c.id
    WHERE
        c.name = customer_name_param;
END;
$$;
 Y   DROP FUNCTION public.get_customer_orders_by_name(customer_name_param character varying);
       public          postgres    false                       1255    25655 !   get_movie_info_by_rating(integer)    FUNCTION     �  CREATE FUNCTION public.get_movie_info_by_rating(movie_rate integer) RETURNS TABLE(movie_name character varying, movie_description character varying, movie_releasedate date, movie_rating integer, title character varying, singer character varying, type_song character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        mv.movie_name,
        mv.movie_description,
        mv.movie_releasedate,
        mv.movie_rating,
        sg.title,
        sg.singer,
        st.type_song
    FROM
        movie mv
    LEFT JOIN
        songs sg ON mv.id = sg.movie_id
    LEFT JOIN
        song_type st ON st.id = sg.id
    WHERE
        mv.movie_rating = movie_rate;
END;
$$;
 C   DROP FUNCTION public.get_movie_info_by_rating(movie_rate integer);
       public          postgres    false                       1255    25654 !   get_movie_info_by_rating(numeric)    FUNCTION     �  CREATE FUNCTION public.get_movie_info_by_rating(movie_rate numeric) RETURNS TABLE(movie_name character varying, movie_description character varying, movie_releasedate date, movie_rating numeric, title character varying, singer character varying, type_song character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        mv.movie_name,
        mv.movie_description,
        mv.movie_releasedate,
        mv.movie_rating,
        sg.title,
        sg.singer,
        st.type_song
    FROM
        movie mv
    LEFT JOIN
        songs sg ON mv.id = sg.movie_id
    LEFT JOIN
        song_type st ON st.id = sg.id
    WHERE
        mv.movie_rating = movie_rate;
END;
$$;
 C   DROP FUNCTION public.get_movie_info_by_rating(movie_rate numeric);
       public          postgres    false            �            1255    17278 N   insert_customer_and_order(character varying, character varying, date, numeric) 	   PROCEDURE     R  CREATE PROCEDURE public.insert_customer_and_order(IN customer_name_param character varying, IN customer_email_param character varying, IN order_date_param date, IN order_total_param numeric)
    LANGUAGE plpgsql
    AS $$
DECLARE
    customer_id INTEGER;
BEGIN
    -- Insert into customers table
    INSERT INTO customers (name, email)
    VALUES (customer_name_param, customer_email_param)
    RETURNING id INTO customer_id;

    -- Insert into orders table
    INSERT INTO orders (customer_id, order_date, total_amount)
    VALUES (customer_id, order_date_param, order_total_param);
END;
$$;
 �   DROP PROCEDURE public.insert_customer_and_order(IN customer_name_param character varying, IN customer_email_param character varying, IN order_date_param date, IN order_total_param numeric);
       public          postgres    false            �            1255    25601    insert_into_table2()    FUNCTION     �   CREATE FUNCTION public.insert_into_table2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO table2 (value,email,rollno) values (NEW.value,new.email,new.id);
    RETURN NEW;
END;
$$;
 +   DROP FUNCTION public.insert_into_table2();
       public          postgres    false            �            1255    25656    insert_key_value(jsonb)    FUNCTION     �   CREATE FUNCTION public.insert_key_value(json_data jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO key_value_table (data) VALUES (json_data);
END;
$$;
 8   DROP FUNCTION public.insert_key_value(json_data jsonb);
       public          postgres    false            �            1255    17342 �   insert_movie_and_song(character varying, character varying, date, integer, character varying, character varying, character varying)    FUNCTION     g  CREATE FUNCTION public.insert_movie_and_song(movie_name_param character varying, movie_description_param character varying, movie_releasedate_param date, movie_rating_param integer, song_title_param character varying, singer_param character varying, song_type_param character varying) RETURNS TABLE(movie_id integer, song_id integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    movie_id_val int;
    song_type_id int;
BEGIN
    -- Insert a new movie and retrieve its ID
    INSERT INTO movie(movie_name, movie_description, movie_releasedate, movie_rating)
    VALUES (movie_name_param, movie_description_param, movie_releasedate_param, movie_rating_param)
    RETURNING id INTO movie_id_val;

    -- Insert a new song type and retrieve its ID
    INSERT INTO song_type(type)
    VALUES (song_type_param)
    RETURNING id INTO song_type_id;

    -- Insert a new song with the retrieved IDs
    INSERT INTO songs(title, singer, movie_id, song_type)
    VALUES (song_title_param, singer_param, movie_id_val, song_type_id);

    -- Return the inserted movie and song IDs
    RETURN QUERY SELECT movie_id_val, song_type_id;
END;
$$;
   DROP FUNCTION public.insert_movie_and_song(movie_name_param character varying, movie_description_param character varying, movie_releasedate_param date, movie_rating_param integer, song_title_param character varying, singer_param character varying, song_type_param character varying);
       public          postgres    false                       1255    25651    movie_info(integer)    FUNCTION     �  CREATE FUNCTION public.movie_info(movie_rate integer) RETURNS TABLE(movie_name character varying, movie_description character varying, movie_releasedate date, movie_rating integer, title character varying, singer character varying, movie_id integer, type_song character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
    SELECT
        mv.movie_name,
        mv.movie_description,
        mv.movie_releasedate,
        mv.movie_rating,
        sg.title,
        sg.singer,
        sg.movie_id,
        st.type_song
    FROM
        movie mv
    LEFT JOIN
        songs sg ON mv.id = sg.movie_id
    LEFT JOIN
        song_type st ON st.id = sg.id
    WHERE
        lower(mv.movie_rating) LIKE '%' || lower(movie_rate) || '%';
END;
$$;
 5   DROP FUNCTION public.movie_info(movie_rate integer);
       public          postgres    false                       1255    25652    movie_info(numeric)    FUNCTION     �  CREATE FUNCTION public.movie_info(movie_rate numeric) RETURNS TABLE(movie_name character varying, movie_description character varying, movie_releasedate date, movie_rating integer, title character varying, singer character varying, movie_id integer, type_song character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
    SELECT
        mv.movie_name,
        mv.movie_description,
        mv.movie_releasedate,
        mv.movie_rating,
        sg.title,
        sg.singer,
        sg.movie_id,
        st.type_song
    FROM
        movie mv
    LEFT JOIN
        songs sg ON mv.id = sg.movie_id
    LEFT JOIN
        song_type st ON st.id = sg.id
    WHERE
        lower(mv.movie_rating) LIKE '%' || lower(movie_rate) || '%';
END;
$$;
 5   DROP FUNCTION public.movie_info(movie_rate numeric);
       public          postgres    false                        1255    17367    movie_info(character varying)    FUNCTION     �  CREATE FUNCTION public.movie_info(movie_title character varying) RETURNS TABLE(movie_name character varying, movie_description character varying, movie_releasedate date, movie_rating integer, title character varying, singer character varying, movie_id integer, type_song character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
    SELECT
        mv.movie_name,
        mv.movie_description,
        mv.movie_releasedate,
        mv.movie_rating,
        sg.title,
        sg.singer,
        sg.movie_id,
        st.type_song
    FROM
        movie mv
    LEFT JOIN
        songs sg ON mv.id = sg.movie_id
    LEFT JOIN
        song_type st ON st.id = sg.id
    WHERE
        lower(mv.movie_name) LIKE '%' || lower(movie_title) || '%';
END;
$$;
 @   DROP FUNCTION public.movie_info(movie_title character varying);
       public          postgres    false            �            1255    25649    select_and_insert()    FUNCTION     �   CREATE FUNCTION public.select_and_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO table2 (value)
    SELECT NEW.value; -- Perform the SELECT here based on your needs
    RETURN NEW;
END;
$$;
 *   DROP FUNCTION public.select_and_insert();
       public          postgres    false            �            1255    17237 3   student_entry(character varying, character varying) 	   PROCEDURE     t  CREATE PROCEDURE public.student_entry(IN student_name character varying, IN student_email character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
    ref_id INTEGER;
BEGIN
Insert into student(student_name,student_email) values (student_name,student_email) RETURNING id INTO ref_id;
Insert into test_student(ref_id,student_email ) values(ref_id,student_email );
END;
$$;
 l   DROP PROCEDURE public.student_entry(IN student_name character varying, IN student_email character varying);
       public          postgres    false            �            1255    25619    update_table2()    FUNCTION     �   CREATE FUNCTION public.update_table2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE table2
    SET value = NEW.value,
	email = NEW.email,
    rollno = NEW.id
    WHERE id = NEW.id;
    
    RETURN NEW;
END;
$$;
 &   DROP FUNCTION public.update_table2();
       public          postgres    false            �            1259    17258 	   customers    TABLE     �   CREATE TABLE public.customers (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100) NOT NULL
);
    DROP TABLE public.customers;
       public         heap    postgres    false            �            1259    17257    customers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.customers_id_seq;
       public          postgres    false    215            x           0    0    customers_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;
          public          postgres    false    214            �            1259    17308    movie    TABLE     �   CREATE TABLE public.movie (
    id integer NOT NULL,
    movie_name character varying(100),
    movie_description character varying(100),
    movie_releasedate date,
    movie_rating integer
);
    DROP TABLE public.movie;
       public         heap    postgres    false            �            1259    17307    movie_id_seq    SEQUENCE     �   CREATE SEQUENCE public.movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.movie_id_seq;
       public          postgres    false    223            y           0    0    movie_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.movie_id_seq OWNED BY public.movie.id;
          public          postgres    false    222            �            1259    17301 
   movie_type    TABLE     c   CREATE TABLE public.movie_type (
    id integer NOT NULL,
    movie_type character varying(100)
);
    DROP TABLE public.movie_type;
       public         heap    postgres    false            �            1259    17300    movie_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.movie_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.movie_type_id_seq;
       public          postgres    false    221            z           0    0    movie_type_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.movie_type_id_seq OWNED BY public.movie_type.id;
          public          postgres    false    220            �            1259    25549    orders    TABLE     �   CREATE TABLE public.orders (
    id integer NOT NULL,
    order_number character varying(20) NOT NULL,
    user_id integer,
    email_id character varying(100)
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �            1259    25548    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          postgres    false    231            {           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          postgres    false    230            �            1259    17346 	   song_type    TABLE     a   CREATE TABLE public.song_type (
    id integer NOT NULL,
    type_song character varying(100)
);
    DROP TABLE public.song_type;
       public         heap    postgres    false            �            1259    17345    song_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.song_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.song_type_id_seq;
       public          postgres    false    227            |           0    0    song_type_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.song_type_id_seq OWNED BY public.song_type.id;
          public          postgres    false    226            �            1259    17322    songs    TABLE     �   CREATE TABLE public.songs (
    id integer NOT NULL,
    title character varying(100),
    singer character varying(100),
    movie_id integer,
    song_type character varying(100)
);
    DROP TABLE public.songs;
       public         heap    postgres    false            �            1259    17321    songs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.songs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.songs_id_seq;
       public          postgres    false    225            }           0    0    songs_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.songs_id_seq OWNED BY public.songs.id;
          public          postgres    false    224            �            1259    17280    student    TABLE     �   CREATE TABLE public.student (
    id integer NOT NULL,
    student_name character varying(100),
    student_email character varying(100)
);
    DROP TABLE public.student;
       public         heap    postgres    false            �            1259    17279    student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.student_id_seq;
       public          postgres    false    217            ~           0    0    student_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;
          public          postgres    false    216            �            1259    25637    table1    TABLE     �   CREATE TABLE public.table1 (
    id integer NOT NULL,
    value character varying(50) NOT NULL,
    email character varying(50) NOT NULL
);
    DROP TABLE public.table1;
       public         heap    postgres    false            �            1259    25636    table1_id_seq    SEQUENCE     �   CREATE SEQUENCE public.table1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.table1_id_seq;
       public          postgres    false    235                       0    0    table1_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.table1_id_seq OWNED BY public.table1.id;
          public          postgres    false    234            �            1259    25629    table2    TABLE     �   CREATE TABLE public.table2 (
    id integer NOT NULL,
    value character varying(50) NOT NULL,
    rollno integer,
    email character varying(50) NOT NULL
);
    DROP TABLE public.table2;
       public         heap    postgres    false            �            1259    25628    table2_id_seq    SEQUENCE     �   CREATE SEQUENCE public.table2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.table2_id_seq;
       public          postgres    false    233            �           0    0    table2_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.table2_id_seq OWNED BY public.table2.id;
          public          postgres    false    232            �            1259    17287    test_student    TABLE     |   CREATE TABLE public.test_student (
    id integer NOT NULL,
    ref_id integer,
    student_email character varying(100)
);
     DROP TABLE public.test_student;
       public         heap    postgres    false            �            1259    17286    test_student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.test_student_id_seq;
       public          postgres    false    219            �           0    0    test_student_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.test_student_id_seq OWNED BY public.test_student.id;
          public          postgres    false    218            �            1259    25542    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    25541    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    229            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    228            �           2604    17261    customers id    DEFAULT     l   ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);
 ;   ALTER TABLE public.customers ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            �           2604    17311    movie id    DEFAULT     d   ALTER TABLE ONLY public.movie ALTER COLUMN id SET DEFAULT nextval('public.movie_id_seq'::regclass);
 7   ALTER TABLE public.movie ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    17304    movie_type id    DEFAULT     n   ALTER TABLE ONLY public.movie_type ALTER COLUMN id SET DEFAULT nextval('public.movie_type_id_seq'::regclass);
 <   ALTER TABLE public.movie_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            �           2604    25552 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    231    231            �           2604    17349    song_type id    DEFAULT     l   ALTER TABLE ONLY public.song_type ALTER COLUMN id SET DEFAULT nextval('public.song_type_id_seq'::regclass);
 ;   ALTER TABLE public.song_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226    227            �           2604    17325    songs id    DEFAULT     d   ALTER TABLE ONLY public.songs ALTER COLUMN id SET DEFAULT nextval('public.songs_id_seq'::regclass);
 7   ALTER TABLE public.songs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            �           2604    17283 
   student id    DEFAULT     h   ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);
 9   ALTER TABLE public.student ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217            �           2604    25640 	   table1 id    DEFAULT     f   ALTER TABLE ONLY public.table1 ALTER COLUMN id SET DEFAULT nextval('public.table1_id_seq'::regclass);
 8   ALTER TABLE public.table1 ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    235    235            �           2604    25632 	   table2 id    DEFAULT     f   ALTER TABLE ONLY public.table2 ALTER COLUMN id SET DEFAULT nextval('public.table2_id_seq'::regclass);
 8   ALTER TABLE public.table2 ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    233    233            �           2604    17290    test_student id    DEFAULT     r   ALTER TABLE ONLY public.test_student ALTER COLUMN id SET DEFAULT nextval('public.test_student_id_seq'::regclass);
 >   ALTER TABLE public.test_student ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    25545    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            ]          0    17258 	   customers 
   TABLE DATA                 public          postgres    false    215   ��       e          0    17308    movie 
   TABLE DATA                 public          postgres    false    223   <�       c          0    17301 
   movie_type 
   TABLE DATA                 public          postgres    false    221   U�       m          0    25549    orders 
   TABLE DATA                 public          postgres    false    231   ��       i          0    17346 	   song_type 
   TABLE DATA                 public          postgres    false    227   F�       g          0    17322    songs 
   TABLE DATA                 public          postgres    false    225   ��       _          0    17280    student 
   TABLE DATA                 public          postgres    false    217   ��       q          0    25637    table1 
   TABLE DATA                 public          postgres    false    235   >�       o          0    25629    table2 
   TABLE DATA                 public          postgres    false    233   ؉       a          0    17287    test_student 
   TABLE DATA                 public          postgres    false    219   ��       k          0    25542    users 
   TABLE DATA                 public          postgres    false    229   �       �           0    0    customers_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.customers_id_seq', 5, true);
          public          postgres    false    214            �           0    0    movie_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.movie_id_seq', 14, true);
          public          postgres    false    222            �           0    0    movie_type_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.movie_type_id_seq', 1, true);
          public          postgres    false    220            �           0    0    orders_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.orders_id_seq', 6, true);
          public          postgres    false    230            �           0    0    song_type_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.song_type_id_seq', 5, true);
          public          postgres    false    226            �           0    0    songs_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.songs_id_seq', 8, true);
          public          postgres    false    224            �           0    0    student_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.student_id_seq', 3, true);
          public          postgres    false    216            �           0    0    table1_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.table1_id_seq', 8, true);
          public          postgres    false    234            �           0    0    table2_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.table2_id_seq', 6, true);
          public          postgres    false    232            �           0    0    test_student_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.test_student_id_seq', 2, true);
          public          postgres    false    218            �           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 3, true);
          public          postgres    false    228            �           2606    17265    customers customers_email_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);
 G   ALTER TABLE ONLY public.customers DROP CONSTRAINT customers_email_key;
       public            postgres    false    215            �           2606    17263    customers customers_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.customers DROP CONSTRAINT customers_pkey;
       public            postgres    false    215            �           2606    17313    movie movie_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.movie DROP CONSTRAINT movie_pkey;
       public            postgres    false    223            �           2606    17306    movie_type movie_type_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.movie_type
    ADD CONSTRAINT movie_type_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.movie_type DROP CONSTRAINT movie_type_pkey;
       public            postgres    false    221            �           2606    25554    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    231            �           2606    17351    song_type song_type_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.song_type
    ADD CONSTRAINT song_type_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.song_type DROP CONSTRAINT song_type_pkey;
       public            postgres    false    227            �           2606    17327    songs songs_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.songs
    ADD CONSTRAINT songs_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.songs DROP CONSTRAINT songs_pkey;
       public            postgres    false    225            �           2606    17285    student student_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public            postgres    false    217            �           2606    25642    table1 table1_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.table1
    ADD CONSTRAINT table1_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.table1 DROP CONSTRAINT table1_pkey;
       public            postgres    false    235            �           2606    25634    table2 table2_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.table2
    ADD CONSTRAINT table2_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.table2 DROP CONSTRAINT table2_pkey;
       public            postgres    false    233            �           2606    17292    test_student test_student_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.test_student
    ADD CONSTRAINT test_student_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.test_student DROP CONSTRAINT test_student_pkey;
       public            postgres    false    219            �           2606    25547    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    229            �           2620    25646 !   table1 delete_from_table2_trigger    TRIGGER     �   CREATE TRIGGER delete_from_table2_trigger AFTER DELETE ON public.table1 FOR EACH ROW EXECUTE FUNCTION public.delete_from_table2();
 :   DROP TRIGGER delete_from_table2_trigger ON public.table1;
       public          postgres    false    240    235            �           2620    25648 !   table1 insert_into_table2_trigger    TRIGGER     �   CREATE TRIGGER insert_into_table2_trigger AFTER INSERT ON public.table1 FOR EACH ROW EXECUTE FUNCTION public.insert_into_table2();
 :   DROP TRIGGER insert_into_table2_trigger ON public.table1;
       public          postgres    false    241    235            �           2620    25650     table1 select_and_insert_trigger    TRIGGER     �   CREATE TRIGGER select_and_insert_trigger AFTER INSERT ON public.table1 FOR EACH ROW EXECUTE FUNCTION public.select_and_insert();
 9   DROP TRIGGER select_and_insert_trigger ON public.table1;
       public          postgres    false    235    242            �           2620    25644    table1 update_table2_trigger    TRIGGER     y   CREATE TRIGGER update_table2_trigger AFTER UPDATE ON public.table1 FOR EACH ROW EXECUTE FUNCTION public.update_table2();
 5   DROP TRIGGER update_table2_trigger ON public.table1;
       public          postgres    false    235    239            �           2606    25555    orders orders_user_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 D   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_user_id_fkey;
       public          postgres    false    3265    229    231            �           2606    17293 %   test_student test_student_ref_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.test_student
    ADD CONSTRAINT test_student_ref_id_fkey FOREIGN KEY (ref_id) REFERENCES public.student(id);
 O   ALTER TABLE ONLY public.test_student DROP CONSTRAINT test_student_ref_id_fkey;
       public          postgres    false    3253    217    219            ]   �   x���v
Q���W((M��L�K.-.��M-*V��L�Q�K�M�QH�M���Ts�	uV�0�QP����Sp�OU���l�Ԋ�܂�T���\uMk.O�6WT3���Jƚ �,�H�Zd8��Ph�)ȉ��`CA4�c�� �,m�      e   	  x����K�0�{��w��4]�O't�V��k�X�i2�T��i˔����oB��!?��n��!���ph
%�Ue>%�T�9��]cE�,��V�4�8dI�$��β����m�������aro�7�O[S�v�w9��E�!�}o9�	���b_���v�)��6V�k�K��Z\&+�s�Pw�`�j��#���;B�A������H��Xtjz�F4�-�Rր�g��Fֿt%j����ES;��ME�VΈ��L��9���2��      c   I   x���v
Q���W((M��L���/�L�/�,HU��L�Q@�5�}B]�4uԝ�sr*���S�5���� ��I      m   �   x���v
Q���W((M��L��/JI-*V��L�Q ���Js�R�tJ���pjnbf��������a���nh��������e�;����%��kZsyR�&3���A.�F�@ˌ�����<�Ԋ�܂�T�e\\ }�CS      i   h   x���v
Q���W((M��L�+��K�/�,HU��L�Q ��Ab�
a�>���
�:
�N�ŉy%���\��a4#)?'��<??�lS�A.��S�)�i �\\ �rU�      g   �   x���͊1���}�A���G\�=IԠ-�D��2oo�'�-��NRM�X�����f����S�[s���s�Vx4�2��Ձ��!�wՄ�x�;-�!2HK�.e�~{�9�<m��"+�����eq�OW%]�'j�ȹ����uF9�]u�b9r"�48��A=��� �<Z�맵�Ԑ�������h�/Ȁ"��#�z���D����Q�/��$/a�
      _   }   x���v
Q���W((M��L�+.)MI�+Q��L�Q�r��sS�����M�0G�P�`C����Du ]��A�z�����\�԰�htqFeb�:�AK��f�%fg�%�e�#sP-�� їfh      q   �   x���v
Q���W((M��L�+IL�I5T��L�Q(K�)M�QH�M���Ts�	uV�0�QPΨL�U2�A�t�
���\uMk.Or5�1��*��̬LTp/-(IT��R+srR)2��H�KA&�8�� ��f�      o   �   x���v
Q���W((M��L�+IL�I5R��L�Q(K�)M�Q(������QH�M���Ts�	uV�0�QPΨL�U�Q ��Al�t�"���\uMk.OJ�7�6�*��٦ �3+�KJ�V�R+srR�b���@��A4�ppq KxtN      a   r   x���v
Q���W((M��L�+I-.�/.)MI�+Q��L�Q(JM��P������M�0G�P�`C#����\�t��^r~���5�'Lm4�,1�8#/�,�.. u�>�      k   �   x���v
Q���W((M��L�+-N-*V��L�Q 1�sSuRs3s4�}B]�4uԃ2+Ձt�vH��%��kZsy�g���ҌL��@�*����ȋO�OU��R+srRaFsq ��R     