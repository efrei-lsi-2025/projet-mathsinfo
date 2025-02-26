--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.1

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: AdjacentStation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AdjacentStation" (
    "time" integer NOT NULL,
    "station1Num" integer NOT NULL,
    "station2Num" integer NOT NULL
);


ALTER TABLE public."AdjacentStation" OWNER TO postgres;

--
-- Name: Gare; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Gare" (
    nom text NOT NULL,
    "posX" integer NOT NULL,
    "posY" integer NOT NULL
);


ALTER TABLE public."Gare" OWNER TO postgres;

--
-- Name: Intergare; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Intergare" (
    "time" integer NOT NULL,
    "gare1Nom" text NOT NULL,
    "gare2Nom" text NOT NULL,
    "ligneNom" text NOT NULL
);


ALTER TABLE public."Intergare" OWNER TO postgres;

--
-- Name: Ligne; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ligne" (
    nom text NOT NULL,
    couleur text NOT NULL
);


ALTER TABLE public."Ligne" OWNER TO postgres;

--
-- Name: Station; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Station" (
    num integer NOT NULL,
    nom text NOT NULL,
    terminus boolean NOT NULL,
    branchement integer NOT NULL,
    "posX" integer NOT NULL,
    "posY" integer NOT NULL,
    "ligneNom" text NOT NULL
);


ALTER TABLE public."Station" OWNER TO postgres;

--
-- Name: _GareLignes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_GareLignes" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_GareLignes" OWNER TO postgres;

--
-- Data for Name: AdjacentStation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AdjacentStation" ("time", "station1Num", "station2Num") FROM stdin;
41	0	238
46	0	159
36	1	12
44	1	235
69	2	110
50	2	139
33	3	262
41	3	210
43	4	171
35	4	251
67	5	13
54	5	239
56	6	55
46	6	258
39	7	290
79	7	311
38	8	350
58	8	309
28	9	338
62	9	78
42	10	277
36	10	108
32	11	154
41	11	54
42	12	213
57	13	151
46	14	124
28	14	64
37	15	318
73	15	319
98	16	119
62	16	331
89	17	288
41	17	40
32	18	163
56	18	61
31	19	236
33	19	93
48	20	129
38	20	283
46	21	86
51	21	75
39	22	84
81	22	120
35	23	97
57	23	287
51	24	84
42	25	193
35	25	253
31	26	98
64	26	230
64	27	239
59	27	246
79	28	29
46	29	374
24	30	354
44	30	150
28	31	41
36	31	144
54	32	343
41	32	303
52	33	344
41	33	304
36	34	248
57	34	41
34	35	111
40	35	172
105	36	198
39	36	37
35	38	336
38	38	289
38	39	153
46	39	267
37	40	297
42	42	190
35	42	215
41	43	66
57	43	328
54	44	162
64	44	250
43	45	348
35	45	155
63	46	242
46	46	329
46	47	148
41	47	195
66	48	182
60	48	318
42	49	164
40	49	241
54	50	77
62	50	109
62	51	137
69	51	202
20	52	201
47	53	372
33	53	167
51	54	145
60	55	127
59	56	351
75	56	362
35	57	150
31	58	307
31	58	369
72	59	224
53	59	162
63	60	299
45	60	133
28	61	335
53	62	287
48	62	216
44	63	123
57	63	169
57	64	192
41	65	342
57	65	121
87	67	135
51	67	173
85	68	136
287	69	120
131	69	281
45	70	73
66	70	165
73	71	254
37	71	255
52	72	188
46	73	330
44	74	195
52	74	221
93	75	142
59	76	156
30	76	111
57	77	356
41	78	175
41	79	177
71	79	138
41	80	274
49	80	360
43	81	178
43	81	274
32	82	87
47	82	277
36	83	243
49	83	128
47	85	204
46	85	351
37	86	211
43	87	300
44	88	181
47	88	301
29	89	90
26	90	91
27	91	185
37	92	34
45	93	97
27	94	200
39	94	205
48	95	210
37	95	292
52	96	324
42	96	293
69	98	155
31	99	358
54	99	349
113	100	207
59	100	321
43	101	293
36	101	209
35	102	252
37	102	130
44	103	327
30	103	367
62	104	199
40	104	271
42	105	296
47	105	163
29	106	231
36	106	206
49	107	335
49	107	314
29	108	152
59	109	127
37	110	332
71	112	180
36	113	234
47	113	207
72	114	263
39	115	263
70	115	285
50	116	233
59	117	148
60	118	329
30	118	288
41	119	295
67	121	124
103	122	140
59	122	125
51	123	250
107	125	340
37	126	272
42	126	182
42	128	324
49	129	311
72	131	153
63	131	272
68	132	223
40	132	327
49	133	317
47	134	270
53	134	374
65	135	331
73	136	290
54	137	359
57	138	158
46	139	355
47	140	313
37	141	291
49	141	197
27	142	339
29	143	340
44	143	160
46	144	170
55	145	373
33	146	283
50	146	247
44	147	159
49	147	191
57	149	241
79	149	345
93	151	339
64	153	245
33	154	349
46	156	371
36	157	306
49	157	291
66	158	371
40	160	226
28	161	364
39	161	184
60	164	244
33	165	375
38	166	258
37	166	252
31	167	265
49	168	326
28	168	245
54	169	341
49	171	264
35	172	240
34	173	227
31	174	221
72	174	346
144	175	325
71	176	281
88	177	225
37	179	237
91	180	267
51	183	278
31	184	260
36	184	352
26	185	186
33	186	372
34	187	188
46	187	273
49	189	367
35	189	370
27	190	269
67	191	194
36	192	337
38	193	271
67	194	276
47	196	259
28	197	199
42	198	52
51	200	257
46	201	145
112	202	326
53	203	317
40	203	332
51	204	366
38	205	296
45	206	218
42	208	361
48	208	333
54	209	232
49	211	284
86	212	275
64	212	295
42	214	236
60	215	307
55	216	243
29	217	353
37	217	322
38	218	294
50	219	297
81	219	313
35	220	316
80	220	315
42	222	323
31	222	330
43	223	289
80	224	282
75	225	298
39	226	270
38	227	356
53	228	255
49	228	282
43	229	305
64	229	312
62	230	354
40	231	368
46	232	348
33	233	320
38	234	249
44	235	284
37	237	261
27	238	322
37	244	352
37	246	302
23	247	357
57	248	280
35	249	273
75	254	345
37	256	362
26	257	265
47	259	198
84	259	36
37	260	266
46	261	266
41	264	286
39	268	337
35	269	301
41	275	328
59	278	357
37	279	320
43	280	92
61	285	305
35	286	370
38	292	361
46	294	347
46	298	303
48	299	304
46	300	341
53	302	366
33	306	355
29	308	347
33	308	338
65	309	336
28	310	375
67	310	342
37	312	350
98	314	343
107	315	344
27	316	369
23	321	359
47	323	334
69	325	353
32	333	334
33	346	358
47	360	368
28	363	365
28	364	365
37	373	196
180	7	8
180	13	14
240	16	18
240	16	17
240	17	18
180	20	21
180	22	23
180	32	33
180	50	51
240	55	57
240	55	56
240	56	57
180	59	60
300	67	69
300	67	68
300	67	70
300	67	71
300	68	69
300	68	70
300	68	71
300	69	70
300	69	71
300	70	71
240	77	79
240	77	78
240	78	79
180	93	94
180	95	96
180	99	100
180	109	110
180	115	116
180	117	118
180	119	120
240	121	123
240	121	122
240	122	123
180	124	125
180	132	133
180	135	136
180	137	138
240	142	144
240	142	143
240	143	144
180	148	149
240	154	156
240	154	155
240	155	156
180	169	170
240	175	177
240	175	176
240	176	177
180	191	192
180	196	197
180	198	199
180	202	203
300	206	208
300	206	207
300	206	209
300	207	208
300	207	209
300	208	209
300	212	214
300	212	213
300	212	215
300	213	214
300	213	215
300	214	215
180	219	220
180	221	222
240	223	225
240	223	224
240	224	225
180	227	228
180	231	232
180	238	239
240	242	244
240	242	243
240	243	244
180	245	246
180	247	248
180	278	279
180	281	282
180	284	285
180	292	293
180	295	296
180	298	299
180	303	304
180	309	310
300	311	313
300	311	312
300	311	314
300	311	315
300	312	313
300	312	314
300	312	315
300	313	314
300	313	315
300	314	315
240	325	327
240	325	326
240	326	327
240	339	341
240	339	340
240	340	341
240	342	344
240	342	343
240	343	344
180	346	347
180	354	355
180	366	367
\.


--
-- Data for Name: Gare; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Gare" (nom, "posX", "posY") FROM stdin;
Abbesses	488	289
Alexandre Dumas	788	556
Alma Marceau	258	530
Alésia	497	833
Anatole France	243	258
Anvers	527	308
Argentine	208	413
Arts et Métiers	624	495
Assemblée Nationale	335	587
Aubervilliers-Pantin, Quatre Chemins	766	212
Avenue Émile Zola	237	693
Avron	791	593
Barbès Rochechouart	574	313
Basilique de Saint-Denis	582	115
Bastille	650	600
Bel Air	813	687
Belleville	711	405
Bercy	746	753
Bibliothèque François Mitterand	744	811
Billancourt	85	832
Bir-Hakeim	201	631
Blanche	435	310
Bobigny, Pablo Picasso	902	237
Bobigny-Pantin, Raymond Queneau	877	262
Boissière	171	505
Bolivar	731	354
Bonne Nouvelle	559	447
Botzaris	791	360
Boucicaut	252	779
Boulogne, Jean Jaurès	68	749
Boulogne, Pont de Saint-Cloud, Rond Point Rhin et Danube	48	768
Bourse	478	500
Brochant	362	255
Bréguet-Sabin	672	562
Buttes Chaumont	770	359
Buzenval	834	602
Bérault	892	669
Cadet	504	380
Cambronne	311	698
Campo-Formio	633	763
Cardinal Lemoine	560	678
Carrefour Pleyel	458	144
Censier Daubenton	570	742
Champs Élysées, Clémenceau	313	516
Chardon Lagâche	134	742
Charenton-Écoles	841	818
Charles Michels	221	706
Charles de Gaulle, Étoile	231	438
Charonne	762	571
Chaussée d'Antin, La Fayette	442	443
Chemin Vert	644	563
Chevaleret	677	802
Château Landon	659	359
Château Rouge	544	282
Château d'Eau	598	400
Château de Vincennes	907	682
Châtelet	528	558
Châtillon-Montrouge	351	934
Cité	511	582
Cluny, La Sorbonne	516	641
Colonel Fabien	712	369
Commerce	262	720
Concorde	328	532
Convention	296	816
Corentin Celton	246	866
Corentin-Cariou	723	256
Corvisart	585	802
Cour Saint-Émilion	765	788
Courcelles	283	386
Couronnes	735	435
Crimée	708	272
Croix de Chavaux	892	545
Créteil-Préfecture	883	934
Créteil-Université	882	915
Créteil-l'Echat, Hôpital Henri Mondor	883	897
Danube	821	334
Daumesnil	791	706
Denfert Rochereau	512	773
Dugommier	767	731
Dupleix	227	657
Duroc	362	698
Edgar Quinet	446	740
Esplanade de la Défense	115	320
Europe	353	367
Exelmans	118	770
Faidherbe-Chaligny	719	633
Falguière	385	729
Filles du Calvaire	644	508
Fort d'Aubervilliers	789	192
Franklin D. Roosevelt	291	496
Félix Faure	263	748
Gabriel Péri, Asnières-Gennevilliers	270	163
Gaité	429	773
Galliéni	904	496
Gambetta	830	493
Gare d'Austerlitz	646	720
Gare de Lyon	676	679
Gare de l'Est	623	372
Gare du Nord	635	338
Garibaldi	408	193
George V	262	467
Glacière	554	803
Goncourt	686	432
Grande Arche de la Défense	98	299
Guy Môquet	384	253
Havre Caumartin	397	443
Hoche	832	295
Hôtel de Ville	569	549
Invalides	312	576
Iéna	212	549
Jacques Bonsergent	638	421
Jasmin	116	674
Jaurès	707	337
Javel	192	715
Jourdain	786	389
Jules Joffrin	514	262
Jussieu	589	692
Kléber	204	474
La Chapelle	625	310
La Courneuve, 8 Mai 1945	791	158
La Fourche	383	283
La Motte Picquet, Grenelle	262	685
La Muette	116	593
La Tour-Maubourg	287	600
Lamarck Caulaincourt	486	264
Laumière	731	313
Le Kremlin-Bicêtre	604	866
Le Peletier	485	400
Ledru Rollin	673	615
Les Gobelins	588	769
Les Halles	527	531
Les Sablons	154	359
Liberté	818	795
Liège	386	346
Louis Blanc	682	347
Louise Michel	255	269
Lourmel	230	799
Louvre, Rivoli	453	549
Mabillon	456	643
Madeleine	334	498
Mairie d'Issy	220	893
Mairie d'Ivry	742	888
Mairie de Clichy	303	196
Mairie de Montreuil	906	530
Mairie de Saint-Ouen	433	169
Mairie des Lilas	906	358
Maison Blanche	606	843
Maisons-Alfort les Juilliottes	883	878
Maisons-Alfort, Stade	882	860
Malakoff-Plateau de Vanves	352	875
Malakoff-Rue Étienne Dolet	352	903
Malesherbes	313	326
Maraîchers	849	588
Marcadet Poissonniers	545	263
Marcel Sembat	100	815
Marx Dormoy	629	251
Maubert Mutualité	541	658
Michel Ange Auteuil	116	715
Michel Ange Molitor	117	741
Michel Bizot	808	722
Mirabeau	160	732
Miromesnil	346	449
Monceau	304	364
Montgallet	766	681
Montparnasse Bienvenue	435	729
Mouton-Duvernet	505	798
Ménilmontant	762	462
Nation	798	628
Nationale	645	802
Notre Dame de Lorette	478	385
Notre-Dame-des-Champs	450	710
Oberkampf	677	481
Odéon	489	637
Opéra	421	465
Ourcq	758	295
Palais Royal, Musée du Louvre	417	549
Parmentier	737	481
Passy	172	601
Pasteur	375	740
Pelleport	856	458
Pernety	416	797
Philippe-Auguste	788	522
Picpus	831	667
Pierre Curie	725	872
Pigalle	488	311
Place Balard	209	823
Place Monge	569	713
Place d'Italie	614	801
Place de Clichy	385	310
Place des Fêtes	820	384
Plaisance	393	820
Poissonnière	553	373
Pont de Levallois, Bécon	231	245
Pont de Neuilly	135	339
Pont de Sèvres	66	849
Pont-Marie	581	593
Pont-Neuf	480	550
Porte Dauphine	148	441
Porte Dorée	820	743
Porte Maillot	178	381
Porte d'Auteuil	87	731
Porte d'Italie	634	859
Porte d'Ivry	703	859
Porte d'Orléans	473	854
Porte de Bagnolet	872	496
Porte de Champerret	268	281
Porte de Charenton	799	764
Porte de Choisy	669	858
Porte de Clichy	341	234
Porte de Clignancourt	515	222
Porte de Montreuil	864	574
Porte de Pantin	794	295
Porte de Saint-Cloud	118	794
Porte de Saint-Ouen	384	223
Porte de Vanves	370	843
Porte de Versailles	272	841
Porte de Vincennes	845	634
Porte de la Chapelle	628	225
Porte de la Villette	740	240
Porte des Lilas	879	382
Pré-Saint-Gervais	845	354
Pyramides	417	504
Pyrénées	747	391
Père Lachaise	788	495
Péreire	287	300
Quai de la Gare	711	788
Quai de la Rapée	649	667
Quatre Septembre	442	489
Rambuteau	595	523
Ranelagh	116	634
Raspail	490	749
Rennes	427	677
Reuilly Diderot	741	656
Richard Lenoir	694	538
Richelieu Drouot	472	447
Riquet	693	286
Robespierre	878	559
Rome	353	316
Rue Montmartre, Grands Boulevards	508	448
Rue Saint-Maur	759	496
Rue de la Pompe	126	547
Rue des Boulets	780	588
Rue du Bac	382	632
Réaumur Sébastopol	565	502
République	665	455
Saint-Ambroise	724	533
Saint-Augustin	359	428
Saint-Denis-Porte de Paris	517	131
Saint-Denis-Université	611	88
Saint-Fargeau	881	424
Saint-Francois Xavier	329	663
Saint-Georges	488	348
Saint-Germain-des-Prés	448	637
Saint-Jacques	527	787
Saint-Lazare	366	391
Saint-Mandé, Tourelle	876	652
Saint-Marcel	650	743
Saint-Michel	505	613
Saint-Paul, Le Marais	603	584
Saint-Philippe du Roule	324	464
Saint-Placide	435	698
Saint-Sulpice	434	663
Saint-Sébastien-Froissart	644	535
Sentier	515	500
Simplon	530	237
Solférino	358	609
Stalingrad	684	321
Strasbourg Saint-Denis	587	447
Sully Morland	603	616
Sèvres Babylone	403	654
Sèvres Lecourbe	337	725
Ségur	326	707
Temple	639	473
Ternes	259	410
Tolbiac	606	822
Trinité d'Estienne d'Orves	424	385
Trocadéro	168	548
Tuileries	376	548
Télégraphe	855	390
Vaneau	382	676
Varenne	314	616
Vaugirard	322	793
Vavin	465	734
Victor Hugo	181	476
Villejuif, Louis Aragon	607	933
Villejuif, Léo Lagrange	607	892
Villejuif, P. Vaillant Couturier	606	913
Villiers	328	342
Volontaires	345	768
Voltaire	743	551
Wagram	298	312
École Militaire	261	636
École Vétérinaire de Maisons-Alfort	865	841
Église d'Auteuil	147	715
Église de Pantin	858	281
Étienne Marcel	527	511
\.


--
-- Data for Name: Intergare; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Intergare" ("time", "gare1Nom", "gare2Nom", "ligneNom") FROM stdin;
41	Abbesses	Pigalle	12
46	Abbesses	Lamarck Caulaincourt	12
36	Alexandre Dumas	Avron	2
44	Alexandre Dumas	Philippe-Auguste	2
69	Alma Marceau	Franklin D. Roosevelt	9
50	Alma Marceau	Iéna	9
33	Alésia	Porte d'Orléans	4
41	Alésia	Mouton-Duvernet	4
43	Anatole France	Louise Michel	3
35	Anatole France	Pont de Levallois, Bécon	3
67	Anvers	Barbès Rochechouart	2
54	Anvers	Pigalle	2
56	Argentine	Charles de Gaulle, Étoile	1
46	Argentine	Porte Maillot	1
39	Arts et Métiers	Rambuteau	11
79	Arts et Métiers	République	11
38	Arts et Métiers	Temple	3
58	Arts et Métiers	Réaumur Sébastopol	3
28	Assemblée Nationale	Solférino	12
62	Assemblée Nationale	Concorde	12
42	Aubervilliers-Pantin, Quatre Chemins	Porte de la Villette	7
36	Aubervilliers-Pantin, Quatre Chemins	Fort d'Aubervilliers	7
32	Avenue Émile Zola	La Motte Picquet, Grenelle	10
41	Avenue Émile Zola	Charles Michels	10
42	Avron	Nation	2
57	Barbès Rochechouart	La Chapelle	2
46	Barbès Rochechouart	Gare du Nord	4
28	Barbès Rochechouart	Château Rouge	4
37	Basilique de Saint-Denis	Saint-Denis-Porte de Paris	13
73	Basilique de Saint-Denis	Saint-Denis-Université	13
98	Bastille	Gare de Lyon	1
62	Bastille	Saint-Paul, Le Marais	1
89	Bastille	Quai de la Rapée	5
41	Bastille	Bréguet-Sabin	5
32	Bastille	Ledru Rollin	8
56	Bastille	Chemin Vert	8
31	Bel Air	Picpus	6
33	Bel Air	Daumesnil	6
48	Belleville	Goncourt	11
38	Belleville	Pyrénées	11
46	Belleville	Couronnes	2
51	Belleville	Colonel Fabien	2
39	Bercy	Cour Saint-Émilion	14
81	Bercy	Gare de Lyon	14
35	Bercy	Dugommier	6
57	Bercy	Quai de la Gare	6
51	Bibliothèque François Mitterand	Cour Saint-Émilion	14
42	Billancourt	Marcel Sembat	9
35	Billancourt	Pont de Sèvres	9
31	Bir-Hakeim	Dupleix	6
64	Bir-Hakeim	Passy	6
64	Blanche	Pigalle	2
59	Blanche	Place de Clichy	2
79	Bobigny, Pablo Picasso	Bobigny-Pantin, Raymond Queneau	5
46	Bobigny-Pantin, Raymond Queneau	Église de Pantin	5
24	Boissière	Trocadéro	6
44	Boissière	Kléber	6
28	Bolivar	Buttes Chaumont	7bis
36	Bolivar	Jaurès	7bis
54	Bonne Nouvelle	Strasbourg Saint-Denis	8
41	Bonne Nouvelle	Rue Montmartre, Grands Boulevards	8
52	Bonne Nouvelle	Strasbourg Saint-Denis	9
41	Bonne Nouvelle	Rue Montmartre, Grands Boulevards	9
36	Botzaris	Place des Fêtes	7bis
57	Botzaris	Buttes Chaumont	7bis
34	Boucicaut	Félix Faure	8
40	Boucicaut	Lourmel	8
105	Boulogne, Jean Jaurès	Michel Ange Molitor	10
39	Boulogne, Jean Jaurès	Boulogne, Pont de Saint-Cloud, Rond Point Rhin et Danube	10
35	Bourse	Sentier	3
38	Bourse	Quatre Septembre	3
38	Brochant	La Fourche	13
46	Brochant	Porte de Clichy	13
37	Bréguet-Sabin	Richard Lenoir	5
42	Buzenval	Maraîchers	9
35	Buzenval	Nation	9
41	Bérault	Château de Vincennes	1
57	Bérault	Saint-Mandé, Tourelle	1
54	Cadet	Le Peletier	7
64	Cadet	Poissonnière	7
43	Cambronne	Sèvres Lecourbe	6
35	Cambronne	La Motte Picquet, Grenelle	6
63	Campo-Formio	Place d'Italie	5
46	Campo-Formio	Saint-Marcel	5
46	Cardinal Lemoine	Jussieu	10
41	Cardinal Lemoine	Maubert Mutualité	10
66	Carrefour Pleyel	Mairie de Saint-Ouen	13
60	Carrefour Pleyel	Saint-Denis-Porte de Paris	13
42	Censier Daubenton	Les Gobelins	7
40	Censier Daubenton	Place Monge	7
54	Champs Élysées, Clémenceau	Concorde	1
62	Champs Élysées, Clémenceau	Franklin D. Roosevelt	1
62	Champs Élysées, Clémenceau	Invalides	13
69	Champs Élysées, Clémenceau	Miromesnil	13
20	Chardon Lagâche	Mirabeau	10
47	Charenton-Écoles	École Vétérinaire de Maisons-Alfort	8
33	Charenton-Écoles	Liberté	8
51	Charles Michels	Javel	10
60	Charles de Gaulle, Étoile	George V	1
59	Charles de Gaulle, Étoile	Ternes	2
75	Charles de Gaulle, Étoile	Victor Hugo	2
35	Charles de Gaulle, Étoile	Kléber	6
31	Charonne	Rue des Boulets	9
31	Charonne	Voltaire	9
72	Chaussée d'Antin, La Fayette	Opéra	7
53	Chaussée d'Antin, La Fayette	Le Peletier	7
63	Chaussée d'Antin, La Fayette	Richelieu Drouot	9
45	Chaussée d'Antin, La Fayette	Havre Caumartin	9
28	Chemin Vert	Saint-Sébastien-Froissart	8
53	Chevaleret	Quai de la Gare	6
48	Chevaleret	Nationale	6
44	Château Landon	Gare de l'Est	7
57	Château Landon	Louis Blanc	7
57	Château Rouge	Marcadet Poissonniers	4
41	Château d'Eau	Strasbourg Saint-Denis	4
57	Château d'Eau	Gare de l'Est	4
87	Châtelet	Hôtel de Ville	1
51	Châtelet	Louvre, Rivoli	1
85	Châtelet	Hôtel de Ville	11
287	Châtelet	Gare de Lyon	14
131	Châtelet	Pyramides	14
45	Châtelet	Cité	4
66	Châtelet	Les Halles	4
73	Châtelet	Pont-Marie	7
37	Châtelet	Pont-Neuf	7
52	Châtillon-Montrouge	Malakoff-Rue Étienne Dolet	13
46	Cité	Saint-Michel	4
44	Cluny, La Sorbonne	Maubert Mutualité	10
52	Cluny, La Sorbonne	Odéon	10
93	Colonel Fabien	Jaurès	2
59	Commerce	La Motte Picquet, Grenelle	8
30	Commerce	Félix Faure	8
57	Concorde	Tuileries	1
41	Concorde	Madeleine	12
41	Concorde	Madeleine	8
71	Concorde	Invalides	8
41	Convention	Porte de Versailles	12
49	Convention	Vaugirard	12
43	Corentin Celton	Mairie d'Issy	12
43	Corentin Celton	Porte de Versailles	12
32	Corentin-Cariou	Crimée	7
47	Corentin-Cariou	Porte de la Villette	7
36	Corvisart	Place d'Italie	6
49	Corvisart	Glacière	6
47	Courcelles	Monceau	2
46	Courcelles	Ternes	2
37	Couronnes	Ménilmontant	2
43	Crimée	Riquet	7
44	Croix de Chavaux	Mairie de Montreuil	9
47	Croix de Chavaux	Robespierre	9
29	Créteil-Préfecture	Créteil-Université	8
26	Créteil-Université	Créteil-l'Echat, Hôpital Henri Mondor	8
27	Créteil-l'Echat, Hôpital Henri Mondor	Maisons-Alfort les Juilliottes	8
37	Danube	Botzaris	7bis
45	Daumesnil	Dugommier	6
27	Daumesnil	Michel Bizot	8
39	Daumesnil	Montgallet	8
48	Denfert Rochereau	Mouton-Duvernet	4
37	Denfert Rochereau	Raspail	4
52	Denfert Rochereau	Saint-Jacques	6
42	Denfert Rochereau	Raspail	6
69	Dupleix	La Motte Picquet, Grenelle	6
31	Duroc	Vaneau	10
54	Duroc	Ségur	10
113	Duroc	Montparnasse Bienvenue	13
59	Duroc	Saint-Francois Xavier	13
43	Edgar Quinet	Raspail	6
36	Edgar Quinet	Montparnasse Bienvenue	6
35	Esplanade de la Défense	Pont de Neuilly	1
37	Esplanade de la Défense	Grande Arche de la Défense	1
44	Europe	Saint-Lazare	3
30	Europe	Villiers	3
62	Exelmans	Michel Ange Molitor	9
40	Exelmans	Porte de Saint-Cloud	9
42	Faidherbe-Chaligny	Reuilly Diderot	8
47	Faidherbe-Chaligny	Ledru Rollin	8
29	Falguière	Pasteur	12
36	Falguière	Montparnasse Bienvenue	12
49	Filles du Calvaire	Saint-Sébastien-Froissart	8
49	Filles du Calvaire	République	8
29	Fort d'Aubervilliers	La Courneuve, 8 Mai 1945	7
59	Franklin D. Roosevelt	George V	1
37	Franklin D. Roosevelt	Saint-Philippe du Roule	9
71	Gabriel Péri, Asnières-Gennevilliers	Mairie de Clichy	13
36	Gaité	Pernety	13
47	Gaité	Montparnasse Bienvenue	13
72	Galliéni	Porte de Bagnolet	3
39	Gambetta	Porte de Bagnolet	3
70	Gambetta	Père Lachaise	3
50	Gambetta	Pelleport	3bis
59	Gare d'Austerlitz	Jussieu	10
60	Gare d'Austerlitz	Saint-Marcel	5
30	Gare d'Austerlitz	Quai de la Rapée	5
41	Gare de Lyon	Reuilly Diderot	1
67	Gare de l'Est	Gare du Nord	4
103	Gare de l'Est	Jacques Bonsergent	5
59	Gare de l'Est	Gare du Nord	5
51	Gare de l'Est	Poissonnière	7
107	Gare du Nord	Stalingrad	5
37	Garibaldi	Porte de Saint-Ouen	13
42	Garibaldi	Mairie de Saint-Ouen	13
42	Glacière	Saint-Jacques	6
49	Goncourt	République	11
72	Guy Môquet	La Fourche	13
63	Guy Môquet	Porte de Saint-Ouen	13
68	Havre Caumartin	Opéra	3
40	Havre Caumartin	Saint-Lazare	3
49	Havre Caumartin	Saint-Augustin	9
47	Hoche	Porte de Pantin	5
53	Hoche	Église de Pantin	5
65	Hôtel de Ville	Saint-Paul, Le Marais	1
73	Hôtel de Ville	Rambuteau	11
54	Invalides	Varenne	13
57	Invalides	La Tour-Maubourg	8
46	Iéna	Trocadéro	9
47	Jacques Bonsergent	République	5
37	Jasmin	Ranelagh	9
49	Jasmin	Michel Ange Auteuil	9
27	Jaurès	Stalingrad	2
29	Jaurès	Stalingrad	5
44	Jaurès	Laumière	5
46	Jaurès	Louis Blanc	7bis
55	Javel	Église d'Auteuil	10
33	Jourdain	Pyrénées	11
50	Jourdain	Place des Fêtes	11
44	Jules Joffrin	Lamarck Caulaincourt	12
49	Jules Joffrin	Marcadet Poissonniers	12
57	Jussieu	Place Monge	7
79	Jussieu	Sully Morland	7
93	La Chapelle	Stalingrad	2
64	La Fourche	Place de Clichy	13
33	La Motte Picquet, Grenelle	Ségur	10
46	La Motte Picquet, Grenelle	École Militaire	8
36	La Muette	Rue de la Pompe	9
49	La Muette	Ranelagh	9
66	La Tour-Maubourg	École Militaire	8
40	Laumière	Ourcq	5
28	Le Kremlin-Bicêtre	Villejuif, Léo Lagrange	7
39	Le Kremlin-Bicêtre	Maison Blanche	7
60	Les Gobelins	Place d'Italie	7
33	Les Halles	Étienne Marcel	4
38	Les Sablons	Porte Maillot	1
37	Les Sablons	Pont de Neuilly	1
31	Liberté	Porte de Charenton	8
49	Liège	Saint-Lazare	13
28	Liège	Place de Clichy	13
54	Louis Blanc	Stalingrad	7
49	Louise Michel	Porte de Champerret	3
35	Lourmel	Place Balard	8
34	Louvre, Rivoli	Palais Royal, Musée du Louvre	1
31	Mabillon	Odéon	10
72	Mabillon	Sèvres Babylone	10
144	Madeleine	Saint-Lazare	12
71	Madeleine	Pyramides	14
88	Madeleine	Opéra	8
37	Mairie d'Ivry	Pierre Curie	7
91	Mairie de Clichy	Porte de Clichy	13
51	Mairie des Lilas	Porte des Lilas	11
31	Maison Blanche	Porte d'Italie	7
36	Maison Blanche	Tolbiac	7
26	Maisons-Alfort les Juilliottes	Maisons-Alfort, Stade	8
33	Maisons-Alfort, Stade	École Vétérinaire de Maisons-Alfort	8
34	Malakoff-Plateau de Vanves	Malakoff-Rue Étienne Dolet	13
46	Malakoff-Plateau de Vanves	Porte de Vanves	13
49	Malesherbes	Villiers	3
35	Malesherbes	Wagram	3
27	Maraîchers	Porte de Montreuil	9
67	Marcadet Poissonniers	Marx Dormoy	12
36	Marcadet Poissonniers	Simplon	4
38	Marcel Sembat	Porte de Saint-Cloud	9
67	Marx Dormoy	Porte de la Chapelle	12
47	Michel Ange Auteuil	Porte d'Auteuil	10
28	Michel Ange Auteuil	Michel Ange Molitor	9
42	Michel Ange Molitor	Chardon Lagâche	10
51	Michel Bizot	Porte Dorée	8
46	Mirabeau	Javel	10
112	Miromesnil	Saint-Lazare	13
53	Miromesnil	Saint-Augustin	9
40	Miromesnil	Saint-Philippe du Roule	9
51	Monceau	Villiers	2
38	Montgallet	Reuilly Diderot	8
45	Montparnasse Bienvenue	Notre-Dame-des-Champs	12
42	Montparnasse Bienvenue	Vavin	4
48	Montparnasse Bienvenue	Saint-Placide	4
54	Montparnasse Bienvenue	Pasteur	6
49	Ménilmontant	Père Lachaise	2
86	Nation	Porte de Vincennes	1
64	Nation	Reuilly Diderot	1
42	Nation	Picpus	6
60	Nation	Rue des Boulets	9
55	Nationale	Place d'Italie	6
29	Notre Dame de Lorette	Trinité d'Estienne d'Orves	12
37	Notre Dame de Lorette	Saint-Georges	12
38	Notre-Dame-des-Champs	Rennes	12
50	Oberkampf	Richard Lenoir	5
81	Oberkampf	République	5
35	Oberkampf	Saint-Ambroise	9
80	Oberkampf	République	9
42	Odéon	Saint-Germain-des-Prés	4
31	Odéon	Saint-Michel	4
43	Opéra	Quatre Septembre	3
80	Opéra	Pyramides	7
75	Opéra	Richelieu Drouot	8
39	Ourcq	Porte de Pantin	5
38	Palais Royal, Musée du Louvre	Tuileries	1
53	Palais Royal, Musée du Louvre	Pont-Neuf	7
49	Palais Royal, Musée du Louvre	Pyramides	7
43	Parmentier	Rue Saint-Maur	3
64	Parmentier	République	3
62	Passy	Trocadéro	6
40	Pasteur	Volontaires	12
46	Pasteur	Sèvres Lecourbe	6
33	Pelleport	Saint-Fargeau	3bis
38	Pernety	Plaisance	13
44	Philippe-Auguste	Père Lachaise	2
37	Pierre Curie	Porte d'Ivry	7
27	Pigalle	Saint-Georges	12
37	Place d'Italie	Tolbiac	7
37	Place de Clichy	Rome	2
23	Place des Fêtes	Télégraphe	11
57	Place des Fêtes	Pré-Saint-Gervais	7bis
35	Plaisance	Porte de Vanves	13
75	Pont-Marie	Sully Morland	7
37	Porte Dauphine	Victor Hugo	2
26	Porte Dorée	Porte de Charenton	8
47	Porte d'Auteuil	Michel Ange Molitor	10
84	Porte d'Auteuil	Boulogne, Jean Jaurès	10
37	Porte d'Italie	Porte de Choisy	7
46	Porte d'Ivry	Porte de Choisy	7
41	Porte de Champerret	Péreire	3
39	Porte de Clignancourt	Simplon	4
35	Porte de Montreuil	Robespierre	9
41	Porte de Vincennes	Saint-Mandé, Tourelle	1
59	Porte des Lilas	Télégraphe	11
37	Porte des Lilas	Saint-Fargeau	3bis
43	Pré-Saint-Gervais	Danube	7bis
61	Père Lachaise	Rue Saint-Maur	3
35	Péreire	Wagram	3
38	Raspail	Vavin	4
46	Rennes	Sèvres Babylone	12
46	Richelieu Drouot	Rue Montmartre, Grands Boulevards	8
48	Richelieu Drouot	Rue Montmartre, Grands Boulevards	9
46	Riquet	Stalingrad	7
53	Rome	Villiers	2
33	Rue de la Pompe	Trocadéro	9
29	Rue du Bac	Sèvres Babylone	12
33	Rue du Bac	Solférino	12
65	Réaumur Sébastopol	Sentier	3
28	Réaumur Sébastopol	Étienne Marcel	4
67	Réaumur Sébastopol	Strasbourg Saint-Denis	4
37	République	Temple	3
98	République	Strasbourg Saint-Denis	8
107	République	Strasbourg Saint-Denis	9
27	Saint-Ambroise	Voltaire	9
23	Saint-Francois Xavier	Varenne	13
47	Saint-Germain-des-Prés	Saint-Sulpice	4
69	Saint-Lazare	Trinité d'Estienne d'Orves	12
32	Saint-Placide	Saint-Sulpice	4
33	Sèvres Babylone	Vaneau	10
47	Vaugirard	Volontaires	12
28	Villejuif, Louis Aragon	Villejuif, P. Vaillant Couturier	7
28	Villejuif, Léo Lagrange	Villejuif, P. Vaillant Couturier	7
37	Église d'Auteuil	Michel Ange Auteuil	10
180	Arts et Métiers	Arts et Métiers	11
180	Barbès Rochechouart	Barbès Rochechouart	2
240	Bastille	Bastille	1
240	Bastille	Bastille	5
180	Belleville	Belleville	11
180	Bercy	Bercy	14
180	Bonne Nouvelle	Bonne Nouvelle	8
180	Champs Élysées, Clémenceau	Champs Élysées, Clémenceau	1
240	Charles de Gaulle, Étoile	Charles de Gaulle, Étoile	1
240	Charles de Gaulle, Étoile	Charles de Gaulle, Étoile	2
180	Chaussée d'Antin, La Fayette	Chaussée d'Antin, La Fayette	7
300	Châtelet	Châtelet	1
300	Châtelet	Châtelet	11
300	Châtelet	Châtelet	14
300	Châtelet	Châtelet	4
240	Concorde	Concorde	1
240	Concorde	Concorde	12
180	Daumesnil	Daumesnil	6
180	Denfert Rochereau	Denfert Rochereau	4
180	Duroc	Duroc	10
180	Franklin D. Roosevelt	Franklin D. Roosevelt	1
180	Gambetta	Gambetta	3
180	Gare d'Austerlitz	Gare d'Austerlitz	10
180	Gare de Lyon	Gare de Lyon	1
240	Gare de l'Est	Gare de l'Est	4
240	Gare de l'Est	Gare de l'Est	5
180	Gare du Nord	Gare du Nord	4
180	Havre Caumartin	Havre Caumartin	3
180	Hôtel de Ville	Hôtel de Ville	1
180	Invalides	Invalides	13
240	Jaurès	Jaurès	2
240	Jaurès	Jaurès	5
180	Jussieu	Jussieu	10
240	La Motte Picquet, Grenelle	La Motte Picquet, Grenelle	10
240	La Motte Picquet, Grenelle	La Motte Picquet, Grenelle	6
180	Louis Blanc	Louis Blanc	7
240	Madeleine	Madeleine	12
240	Madeleine	Madeleine	14
180	Marcadet Poissonniers	Marcadet Poissonniers	12
180	Michel Ange Auteuil	Michel Ange Auteuil	10
180	Michel Ange Molitor	Michel Ange Molitor	10
180	Miromesnil	Miromesnil	13
300	Montparnasse Bienvenue	Montparnasse Bienvenue	12
300	Montparnasse Bienvenue	Montparnasse Bienvenue	13
300	Montparnasse Bienvenue	Montparnasse Bienvenue	4
300	Nation	Nation	1
300	Nation	Nation	2
300	Nation	Nation	6
180	Oberkampf	Oberkampf	5
180	Odéon	Odéon	10
240	Opéra	Opéra	3
240	Opéra	Opéra	7
180	Palais Royal, Musée du Louvre	Palais Royal, Musée du Louvre	1
180	Pasteur	Pasteur	12
180	Pigalle	Pigalle	12
240	Place d'Italie	Place d'Italie	5
240	Place d'Italie	Place d'Italie	6
180	Place de Clichy	Place de Clichy	13
180	Place des Fêtes	Place des Fêtes	11
180	Porte des Lilas	Porte des Lilas	11
180	Pyramides	Pyramides	14
180	Père Lachaise	Père Lachaise	2
180	Raspail	Raspail	4
180	Reuilly Diderot	Reuilly Diderot	1
180	Richelieu Drouot	Richelieu Drouot	8
180	Rue Montmartre, Grands Boulevards	Rue Montmartre, Grands Boulevards	8
180	Réaumur Sébastopol	Réaumur Sébastopol	3
300	République	République	11
300	République	République	3
300	République	République	5
300	République	République	8
240	Saint-Lazare	Saint-Lazare	12
240	Saint-Lazare	Saint-Lazare	13
240	Stalingrad	Stalingrad	2
240	Stalingrad	Stalingrad	5
240	Strasbourg Saint-Denis	Strasbourg Saint-Denis	4
240	Strasbourg Saint-Denis	Strasbourg Saint-Denis	8
180	Sèvres Babylone	Sèvres Babylone	10
180	Trocadéro	Trocadéro	6
180	Villiers	Villiers	2
\.


--
-- Data for Name: Ligne; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Ligne" (nom, couleur) FROM stdin;
1	#ffcd00
2	#003df5
3	#827a04
3bis	#71c5e8
4	#c800a1
5	#ff7f32
6	#71cc98
7	#f59bbb
7bis	#71cc98
8	#dd9cdf
9	#b5bd00
10	#c69214
11	#6e4c1e
12	#007a53
13	#71c5e8
14	#5f259f
15	#a50034
16	#f59bbb
17	#b5bd00
18	#00ab8e
\.


--
-- Data for Name: Station; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Station" (num, nom, terminus, branchement, "posX", "posY", "ligneNom") FROM stdin;
0	Abbesses	f	0	488	289	12
1	Alexandre Dumas	f	0	788	556	2
2	Alma Marceau	f	0	258	530	9
3	Alésia	f	0	497	833	4
4	Anatole France	f	0	243	258	3
5	Anvers	f	0	527	308	2
6	Argentine	f	0	208	413	1
7	Arts et Métiers	f	0	624	495	11
8	Arts et Métiers	f	0	624	495	3
9	Assemblée Nationale	f	0	335	587	12
10	Aubervilliers-Pantin, Quatre Chemins	f	0	766	212	7
11	Avenue Émile Zola	f	0	237	693	10
12	Avron	f	0	791	593	2
13	Barbès Rochechouart	f	0	574	313	2
14	Barbès Rochechouart	f	0	574	313	4
15	Basilique de Saint-Denis	f	1	582	115	13
16	Bastille	f	0	650	600	1
17	Bastille	f	0	650	600	5
18	Bastille	f	0	650	600	8
19	Bel Air	f	0	813	687	6
20	Belleville	f	0	711	405	11
21	Belleville	f	0	711	405	2
22	Bercy	f	0	746	753	14
23	Bercy	f	0	746	753	6
24	Bibliothèque François Mitterand	t	0	744	811	14
25	Billancourt	f	0	85	832	9
26	Bir-Hakeim	f	0	201	631	6
27	Blanche	f	0	435	310	2
28	Bobigny, Pablo Picasso	t	0	902	237	5
29	Bobigny-Pantin, Raymond Queneau	f	0	877	262	5
30	Boissière	f	0	171	505	6
31	Bolivar	f	0	731	354	7bis
32	Bonne Nouvelle	f	0	559	447	8
33	Bonne Nouvelle	f	0	559	447	9
34	Botzaris	f	0	791	360	7bis
35	Boucicaut	f	0	252	779	8
36	Boulogne, Jean Jaurès	f	0	68	749	10
37	Boulogne, Pont de Saint-Cloud, Rond Point Rhin et Danube	t	0	48	768	10
38	Bourse	f	0	478	500	3
39	Brochant	f	2	362	255	13
40	Bréguet-Sabin	f	0	672	562	5
41	Buttes Chaumont	f	0	770	359	7bis
42	Buzenval	f	0	834	602	9
43	Bérault	f	0	892	669	1
44	Cadet	f	0	504	380	7
45	Cambronne	f	0	311	698	6
46	Campo-Formio	f	0	633	763	5
47	Cardinal Lemoine	f	0	560	678	10
48	Carrefour Pleyel	f	1	458	144	13
49	Censier Daubenton	f	0	570	742	7
50	Champs Élysées, Clémenceau	f	0	313	516	1
51	Champs Élysées, Clémenceau	f	0	313	516	13
52	Chardon Lagâche	f	0	134	742	10
53	Charenton-Écoles	f	0	841	818	8
54	Charles Michels	f	0	221	706	10
55	Charles de Gaulle, Étoile	f	0	231	438	1
56	Charles de Gaulle, Étoile	f	0	231	438	2
57	Charles de Gaulle, Étoile	t	0	231	438	6
58	Charonne	f	0	762	571	9
59	Chaussée d'Antin, La Fayette	f	0	442	443	7
60	Chaussée d'Antin, La Fayette	f	0	442	443	9
61	Chemin Vert	f	0	644	563	8
62	Chevaleret	f	0	677	802	6
63	Château Landon	f	0	659	359	7
64	Château Rouge	f	0	544	282	4
65	Château d'Eau	f	0	598	400	4
66	Château de Vincennes	t	0	907	682	1
67	Châtelet	f	0	528	558	1
68	Châtelet	t	0	528	558	11
69	Châtelet	f	0	528	558	14
70	Châtelet	f	0	528	558	4
71	Châtelet	f	0	528	558	7
72	Châtillon-Montrouge	t	0	351	934	13
73	Cité	f	0	511	582	4
74	Cluny, La Sorbonne	f	0	516	641	10
75	Colonel Fabien	f	0	712	369	2
76	Commerce	f	0	262	720	8
77	Concorde	f	0	328	532	1
78	Concorde	f	0	328	532	12
79	Concorde	f	0	328	532	8
80	Convention	f	0	296	816	12
81	Corentin Celton	f	0	246	866	12
82	Corentin-Cariou	f	0	723	256	7
83	Corvisart	f	0	585	802	6
84	Cour Saint-Émilion	f	0	765	788	14
85	Courcelles	f	0	283	386	2
86	Couronnes	f	0	735	435	2
87	Crimée	f	0	708	272	7
88	Croix de Chavaux	f	0	892	545	9
89	Créteil-Préfecture	t	0	883	934	8
90	Créteil-Université	f	0	882	915	8
91	Créteil-l'Echat, Hôpital Henri Mondor	f	0	883	897	8
92	Danube	f	0	821	334	7bis
93	Daumesnil	f	0	791	706	6
94	Daumesnil	f	0	791	706	8
95	Denfert Rochereau	f	0	512	773	4
96	Denfert Rochereau	f	0	512	773	6
97	Dugommier	f	0	767	731	6
98	Dupleix	f	0	227	657	6
99	Duroc	f	0	362	698	10
100	Duroc	f	0	362	698	13
101	Edgar Quinet	f	0	446	740	6
102	Esplanade de la Défense	f	0	115	320	1
103	Europe	f	0	353	367	3
104	Exelmans	f	0	118	770	9
105	Faidherbe-Chaligny	f	0	719	633	8
106	Falguière	f	0	385	729	12
107	Filles du Calvaire	f	0	644	508	8
108	Fort d'Aubervilliers	f	0	789	192	7
109	Franklin D. Roosevelt	f	0	291	496	1
110	Franklin D. Roosevelt	f	0	291	496	9
111	Félix Faure	f	0	263	748	8
112	Gabriel Péri, Asnières-Gennevilliers	t	2	270	163	13
113	Gaité	f	0	429	773	13
114	Galliéni	t	0	904	496	3
115	Gambetta	f	0	830	493	3
116	Gambetta	t	0	830	493	3bis
117	Gare d'Austerlitz	t	0	646	720	10
118	Gare d'Austerlitz	f	0	646	720	5
119	Gare de Lyon	f	0	676	679	1
120	Gare de Lyon	f	0	676	679	14
121	Gare de l'Est	f	0	623	372	4
122	Gare de l'Est	f	0	623	372	5
123	Gare de l'Est	f	0	623	372	7
124	Gare du Nord	f	0	635	338	4
125	Gare du Nord	f	0	635	338	5
126	Garibaldi	f	1	408	193	13
127	George V	f	0	262	467	1
128	Glacière	f	0	554	803	6
129	Goncourt	f	0	686	432	11
130	Grande Arche de la Défense	t	0	98	299	1
131	Guy Môquet	f	1	384	253	13
132	Havre Caumartin	f	0	397	443	3
133	Havre Caumartin	f	0	397	443	9
134	Hoche	f	0	832	295	5
135	Hôtel de Ville	f	0	569	549	1
136	Hôtel de Ville	f	0	569	549	11
137	Invalides	f	0	312	576	13
138	Invalides	f	0	312	576	8
139	Iéna	f	0	212	549	9
140	Jacques Bonsergent	f	0	638	421	5
141	Jasmin	f	0	116	674	9
142	Jaurès	f	0	707	337	2
143	Jaurès	f	0	707	337	5
144	Jaurès	f	0	707	337	7bis
145	Javel	f	0	192	715	10
146	Jourdain	f	0	786	389	11
147	Jules Joffrin	f	0	514	262	12
148	Jussieu	f	0	589	692	10
149	Jussieu	f	0	589	692	7
150	Kléber	f	0	204	474	6
151	La Chapelle	f	0	625	310	2
152	La Courneuve, 8 Mai 1945	t	0	791	158	7
153	La Fourche	f	0	383	283	13
154	La Motte Picquet, Grenelle	f	0	262	685	10
155	La Motte Picquet, Grenelle	f	0	262	685	6
156	La Motte Picquet, Grenelle	f	0	262	685	8
157	La Muette	f	0	116	593	9
158	La Tour-Maubourg	f	0	287	600	8
159	Lamarck Caulaincourt	f	0	486	264	12
160	Laumière	f	0	731	313	5
161	Le Kremlin-Bicêtre	f	2	604	866	7
162	Le Peletier	f	0	485	400	7
163	Ledru Rollin	f	0	673	615	8
164	Les Gobelins	f	0	588	769	7
165	Les Halles	f	0	527	531	4
166	Les Sablons	f	0	154	359	1
167	Liberté	f	0	818	795	8
168	Liège	f	0	386	346	13
169	Louis Blanc	f	0	682	347	7
170	Louis Blanc	t	0	682	347	7bis
171	Louise Michel	f	0	255	269	3
172	Lourmel	f	0	230	799	8
173	Louvre, Rivoli	f	0	453	549	1
174	Mabillon	f	0	456	643	10
175	Madeleine	f	0	334	498	12
176	Madeleine	t	0	334	498	14
177	Madeleine	f	0	334	498	8
178	Mairie d'Issy	t	0	220	893	12
179	Mairie d'Ivry	t	1	742	888	7
180	Mairie de Clichy	f	2	303	196	13
181	Mairie de Montreuil	t	0	906	530	9
182	Mairie de Saint-Ouen	f	1	433	169	13
183	Mairie des Lilas	t	0	906	358	11
184	Maison Blanche	f	0	606	843	7
185	Maisons-Alfort les Juilliottes	f	0	883	878	8
186	Maisons-Alfort, Stade	f	0	882	860	8
187	Malakoff-Plateau de Vanves	f	0	352	875	13
188	Malakoff-Rue Étienne Dolet	f	0	352	903	13
189	Malesherbes	f	0	313	326	3
190	Maraîchers	f	0	849	588	9
191	Marcadet Poissonniers	f	0	545	263	12
192	Marcadet Poissonniers	f	0	545	263	4
193	Marcel Sembat	f	0	100	815	9
194	Marx Dormoy	f	0	629	251	12
195	Maubert Mutualité	f	0	541	658	10
196	Michel Ange Auteuil	f	0	116	715	10
197	Michel Ange Auteuil	f	0	116	715	9
198	Michel Ange Molitor	f	0	117	741	10
199	Michel Ange Molitor	f	0	117	741	9
200	Michel Bizot	f	0	808	722	8
201	Mirabeau	f	0	160	732	10
202	Miromesnil	f	0	346	449	13
203	Miromesnil	f	0	346	449	9
204	Monceau	f	0	304	364	2
205	Montgallet	f	0	766	681	8
206	Montparnasse Bienvenue	f	0	435	729	12
207	Montparnasse Bienvenue	f	0	435	729	13
208	Montparnasse Bienvenue	f	0	435	729	4
209	Montparnasse Bienvenue	f	0	435	729	6
210	Mouton-Duvernet	f	0	505	798	4
211	Ménilmontant	f	0	762	462	2
212	Nation	f	0	798	628	1
213	Nation	t	0	798	628	2
214	Nation	t	0	798	628	6
215	Nation	f	0	798	628	9
216	Nationale	f	0	645	802	6
217	Notre Dame de Lorette	f	0	478	385	12
218	Notre-Dame-des-Champs	f	0	450	710	12
219	Oberkampf	f	0	677	481	5
220	Oberkampf	f	0	677	481	9
221	Odéon	f	0	489	637	10
222	Odéon	f	0	489	637	4
223	Opéra	f	0	421	465	3
224	Opéra	f	0	421	465	7
225	Opéra	f	0	421	465	8
226	Ourcq	f	0	758	295	5
227	Palais Royal, Musée du Louvre	f	0	417	549	1
228	Palais Royal, Musée du Louvre	f	0	417	549	7
229	Parmentier	f	0	737	481	3
230	Passy	f	0	172	601	6
231	Pasteur	f	0	375	740	12
232	Pasteur	f	0	375	740	6
233	Pelleport	f	0	856	458	3bis
234	Pernety	f	0	416	797	13
235	Philippe-Auguste	f	0	788	522	2
236	Picpus	f	0	831	667	6
237	Pierre Curie	f	1	725	872	7
238	Pigalle	f	0	488	311	12
239	Pigalle	f	0	488	311	2
240	Place Balard	t	0	209	823	8
241	Place Monge	f	0	569	713	7
242	Place d'Italie	t	0	614	801	5
243	Place d'Italie	f	0	614	801	6
244	Place d'Italie	f	0	614	801	7
245	Place de Clichy	f	0	385	310	13
246	Place de Clichy	f	0	385	310	2
247	Place des Fêtes	f	0	820	384	11
248	Place des Fêtes	f	0	820	384	7bis
249	Plaisance	f	0	393	820	13
250	Poissonnière	f	0	553	373	7
251	Pont de Levallois, Bécon	t	0	231	245	3
252	Pont de Neuilly	f	0	135	339	1
253	Pont de Sèvres	t	0	66	849	9
254	Pont-Marie	f	0	581	593	7
255	Pont-Neuf	f	0	480	550	7
256	Porte Dauphine	t	0	148	441	2
257	Porte Dorée	f	0	820	743	8
258	Porte Maillot	f	0	178	381	1
259	Porte d'Auteuil	f	0	87	731	10
260	Porte d'Italie	f	1	634	859	7
261	Porte d'Ivry	f	1	703	859	7
262	Porte d'Orléans	t	0	473	854	4
263	Porte de Bagnolet	f	0	872	496	3
264	Porte de Champerret	f	0	268	281	3
265	Porte de Charenton	f	0	799	764	8
266	Porte de Choisy	f	1	669	858	7
267	Porte de Clichy	f	2	341	234	13
268	Porte de Clignancourt	t	0	515	222	4
269	Porte de Montreuil	f	0	864	574	9
270	Porte de Pantin	f	0	794	295	5
271	Porte de Saint-Cloud	f	0	118	794	9
272	Porte de Saint-Ouen	f	1	384	223	13
273	Porte de Vanves	f	0	370	843	13
274	Porte de Versailles	f	0	272	841	12
275	Porte de Vincennes	f	0	845	634	1
276	Porte de la Chapelle	t	0	628	225	12
277	Porte de la Villette	f	0	740	240	7
278	Porte des Lilas	f	0	879	382	11
279	Porte des Lilas	t	0	879	382	3bis
280	Pré-Saint-Gervais	t	0	845	354	7bis
281	Pyramides	f	0	417	504	14
282	Pyramides	f	0	417	504	7
283	Pyrénées	f	0	747	391	11
284	Père Lachaise	f	0	788	495	2
285	Père Lachaise	f	0	788	495	3
286	Péreire	f	0	287	300	3
287	Quai de la Gare	f	0	711	788	6
288	Quai de la Rapée	f	0	649	667	5
289	Quatre Septembre	f	0	442	489	3
290	Rambuteau	f	0	595	523	11
291	Ranelagh	f	0	116	634	9
292	Raspail	f	0	490	749	4
293	Raspail	f	0	490	749	6
294	Rennes	f	0	427	677	12
295	Reuilly Diderot	f	0	741	656	1
296	Reuilly Diderot	f	0	741	656	8
297	Richard Lenoir	f	0	694	538	5
298	Richelieu Drouot	f	0	472	447	8
299	Richelieu Drouot	f	0	472	447	9
300	Riquet	f	0	693	286	7
301	Robespierre	f	0	878	559	9
302	Rome	f	0	353	316	2
303	Rue Montmartre, Grands Boulevards	f	0	508	448	8
304	Rue Montmartre, Grands Boulevards	f	0	508	448	9
305	Rue Saint-Maur	f	0	759	496	3
306	Rue de la Pompe	f	0	126	547	9
307	Rue des Boulets	f	0	780	588	9
308	Rue du Bac	f	0	382	632	12
309	Réaumur Sébastopol	f	0	565	502	3
310	Réaumur Sébastopol	f	0	565	502	4
311	République	f	0	665	455	11
312	République	f	0	665	455	3
313	République	f	0	665	455	5
314	République	f	0	665	455	8
315	République	f	0	665	455	9
316	Saint-Ambroise	f	0	724	533	9
317	Saint-Augustin	f	0	359	428	9
318	Saint-Denis-Porte de Paris	f	1	517	131	13
319	Saint-Denis-Université	t	1	611	88	13
320	Saint-Fargeau	f	0	881	424	3bis
321	Saint-Francois Xavier	f	0	329	663	13
322	Saint-Georges	f	0	488	348	12
323	Saint-Germain-des-Prés	f	0	448	637	4
324	Saint-Jacques	f	0	527	787	6
325	Saint-Lazare	f	0	366	391	12
326	Saint-Lazare	f	0	366	391	13
327	Saint-Lazare	f	0	366	391	3
328	Saint-Mandé, Tourelle	f	0	876	652	1
329	Saint-Marcel	f	0	650	743	5
330	Saint-Michel	f	0	505	613	4
331	Saint-Paul, Le Marais	f	0	603	584	1
332	Saint-Philippe du Roule	f	0	324	464	9
333	Saint-Placide	f	0	435	698	4
334	Saint-Sulpice	f	0	434	663	4
335	Saint-Sébastien-Froissart	f	0	644	535	8
336	Sentier	f	0	515	500	3
337	Simplon	f	0	530	237	4
338	Solférino	f	0	358	609	12
339	Stalingrad	f	0	684	321	2
340	Stalingrad	f	0	684	321	5
341	Stalingrad	f	0	684	321	7
342	Strasbourg Saint-Denis	f	0	587	447	4
343	Strasbourg Saint-Denis	f	0	587	447	8
344	Strasbourg Saint-Denis	f	0	587	447	9
345	Sully Morland	f	0	603	616	7
346	Sèvres Babylone	f	0	403	654	10
347	Sèvres Babylone	f	0	403	654	12
348	Sèvres Lecourbe	f	0	337	725	6
349	Ségur	f	0	326	707	10
350	Temple	f	0	639	473	3
351	Ternes	f	0	259	410	2
352	Tolbiac	f	0	606	822	7
353	Trinité d'Estienne d'Orves	f	0	424	385	12
354	Trocadéro	f	0	168	548	6
355	Trocadéro	f	0	168	548	9
356	Tuileries	f	0	376	548	1
357	Télégraphe	f	0	855	390	11
358	Vaneau	f	0	382	676	10
359	Varenne	f	0	314	616	13
360	Vaugirard	f	0	322	793	12
361	Vavin	f	0	465	734	4
362	Victor Hugo	f	0	181	476	2
363	Villejuif, Louis Aragon	t	2	607	933	7
364	Villejuif, Léo Lagrange	f	2	607	892	7
365	Villejuif, P. Vaillant Couturier	f	2	606	913	7
366	Villiers	f	0	328	342	2
367	Villiers	f	0	328	342	3
368	Volontaires	f	0	345	768	12
369	Voltaire	f	0	743	551	9
370	Wagram	f	0	298	312	3
371	École Militaire	f	0	261	636	8
372	École Vétérinaire de Maisons-Alfort	f	0	865	841	8
373	Église d'Auteuil	f	0	147	715	10
374	Église de Pantin	f	0	858	281	5
375	Étienne Marcel	f	0	527	511	4
\.


--
-- Data for Name: _GareLignes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_GareLignes" ("A", "B") FROM stdin;
Argentine	1
Bastille	1
Bérault	1
Champs Élysées, Clémenceau	1
Charles de Gaulle, Étoile	1
Château de Vincennes	1
Châtelet	1
Concorde	1
Esplanade de la Défense	1
Franklin D. Roosevelt	1
Gare de Lyon	1
George V	1
Grande Arche de la Défense	1
Hôtel de Ville	1
Les Sablons	1
Louvre, Rivoli	1
Nation	1
Palais Royal, Musée du Louvre	1
Pont de Neuilly	1
Porte Maillot	1
Porte de Vincennes	1
Reuilly Diderot	1
Saint-Mandé, Tourelle	1
Saint-Paul, Le Marais	1
Tuileries	1
Alexandre Dumas	2
Anvers	2
Avron	2
Barbès Rochechouart	2
Belleville	2
Blanche	2
Charles de Gaulle, Étoile	2
Colonel Fabien	2
Courcelles	2
Couronnes	2
Jaurès	2
La Chapelle	2
Monceau	2
Ménilmontant	2
Nation	2
Philippe-Auguste	2
Pigalle	2
Place de Clichy	2
Porte Dauphine	2
Père Lachaise	2
Rome	2
Stalingrad	2
Ternes	2
Victor Hugo	2
Villiers	2
Anatole France	3
Arts et Métiers	3
Bourse	3
Europe	3
Galliéni	3
Gambetta	3
Havre Caumartin	3
Louise Michel	3
Malesherbes	3
Opéra	3
Parmentier	3
Pont de Levallois, Bécon	3
Porte de Bagnolet	3
Porte de Champerret	3
Père Lachaise	3
Péreire	3
Quatre Septembre	3
Rue Saint-Maur	3
Réaumur Sébastopol	3
République	3
Saint-Lazare	3
Sentier	3
Temple	3
Villiers	3
Wagram	3
Gambetta	3bis
Pelleport	3bis
Porte des Lilas	3bis
Saint-Fargeau	3bis
Alésia	4
Barbès Rochechouart	4
Château Rouge	4
Château d'Eau	4
Châtelet	4
Cité	4
Denfert Rochereau	4
Gare de l'Est	4
Gare du Nord	4
Les Halles	4
Marcadet Poissonniers	4
Montparnasse Bienvenue	4
Mouton-Duvernet	4
Odéon	4
Porte d'Orléans	4
Porte de Clignancourt	4
Raspail	4
Réaumur Sébastopol	4
Saint-Germain-des-Prés	4
Saint-Michel	4
Saint-Placide	4
Saint-Sulpice	4
Simplon	4
Strasbourg Saint-Denis	4
Vavin	4
Étienne Marcel	4
Bastille	5
Bobigny, Pablo Picasso	5
Bobigny-Pantin, Raymond Queneau	5
Bréguet-Sabin	5
Campo-Formio	5
Gare d'Austerlitz	5
Gare de l'Est	5
Gare du Nord	5
Hoche	5
Jacques Bonsergent	5
Jaurès	5
Laumière	5
Oberkampf	5
Ourcq	5
Place d'Italie	5
Porte de Pantin	5
Quai de la Rapée	5
Richard Lenoir	5
République	5
Saint-Marcel	5
Stalingrad	5
Église de Pantin	5
Bel Air	6
Bercy	6
Bir-Hakeim	6
Boissière	6
Cambronne	6
Charles de Gaulle, Étoile	6
Chevaleret	6
Corvisart	6
Daumesnil	6
Denfert Rochereau	6
Dugommier	6
Dupleix	6
Edgar Quinet	6
Glacière	6
Kléber	6
La Motte Picquet, Grenelle	6
Montparnasse Bienvenue	6
Nation	6
Nationale	6
Passy	6
Pasteur	6
Picpus	6
Place d'Italie	6
Quai de la Gare	6
Raspail	6
Saint-Jacques	6
Sèvres Lecourbe	6
Trocadéro	6
Aubervilliers-Pantin, Quatre Chemins	7
Cadet	7
Censier Daubenton	7
Chaussée d'Antin, La Fayette	7
Château Landon	7
Châtelet	7
Corentin-Cariou	7
Crimée	7
Fort d'Aubervilliers	7
Gare de l'Est	7
Jussieu	7
La Courneuve, 8 Mai 1945	7
Le Kremlin-Bicêtre	7
Le Peletier	7
Les Gobelins	7
Louis Blanc	7
Mairie d'Ivry	7
Maison Blanche	7
Opéra	7
Palais Royal, Musée du Louvre	7
Pierre Curie	7
Place Monge	7
Place d'Italie	7
Poissonnière	7
Pont-Marie	7
Pont-Neuf	7
Porte d'Italie	7
Porte d'Ivry	7
Porte de Choisy	7
Porte de la Villette	7
Pyramides	7
Riquet	7
Stalingrad	7
Sully Morland	7
Tolbiac	7
Villejuif, Louis Aragon	7
Villejuif, Léo Lagrange	7
Villejuif, P. Vaillant Couturier	7
Bolivar	7bis
Botzaris	7bis
Buttes Chaumont	7bis
Danube	7bis
Jaurès	7bis
Louis Blanc	7bis
Place des Fêtes	7bis
Pré-Saint-Gervais	7bis
Bastille	8
Bonne Nouvelle	8
Boucicaut	8
Charenton-Écoles	8
Chemin Vert	8
Commerce	8
Concorde	8
Créteil-Préfecture	8
Créteil-Université	8
Créteil-l'Echat, Hôpital Henri Mondor	8
Daumesnil	8
Faidherbe-Chaligny	8
Filles du Calvaire	8
Félix Faure	8
Invalides	8
La Motte Picquet, Grenelle	8
La Tour-Maubourg	8
Ledru Rollin	8
Liberté	8
Lourmel	8
Madeleine	8
Maisons-Alfort les Juilliottes	8
Maisons-Alfort, Stade	8
Michel Bizot	8
Montgallet	8
Opéra	8
Place Balard	8
Porte Dorée	8
Porte de Charenton	8
Reuilly Diderot	8
Richelieu Drouot	8
Rue Montmartre, Grands Boulevards	8
République	8
Saint-Sébastien-Froissart	8
Strasbourg Saint-Denis	8
École Militaire	8
École Vétérinaire de Maisons-Alfort	8
Alma Marceau	9
Billancourt	9
Bonne Nouvelle	9
Buzenval	9
Charonne	9
Chaussée d'Antin, La Fayette	9
Croix de Chavaux	9
Exelmans	9
Franklin D. Roosevelt	9
Havre Caumartin	9
Iéna	9
Jasmin	9
La Muette	9
Mairie de Montreuil	9
Maraîchers	9
Marcel Sembat	9
Michel Ange Auteuil	9
Michel Ange Molitor	9
Miromesnil	9
Nation	9
Oberkampf	9
Pont de Sèvres	9
Porte de Montreuil	9
Porte de Saint-Cloud	9
Ranelagh	9
Richelieu Drouot	9
Robespierre	9
Rue Montmartre, Grands Boulevards	9
Rue de la Pompe	9
Rue des Boulets	9
République	9
Saint-Ambroise	9
Saint-Augustin	9
Saint-Philippe du Roule	9
Strasbourg Saint-Denis	9
Trocadéro	9
Voltaire	9
Avenue Émile Zola	10
Boulogne, Jean Jaurès	10
Boulogne, Pont de Saint-Cloud, Rond Point Rhin et Danube	10
Cardinal Lemoine	10
Chardon Lagâche	10
Charles Michels	10
Cluny, La Sorbonne	10
Duroc	10
Gare d'Austerlitz	10
Javel	10
Jussieu	10
La Motte Picquet, Grenelle	10
Mabillon	10
Maubert Mutualité	10
Michel Ange Auteuil	10
Michel Ange Molitor	10
Mirabeau	10
Odéon	10
Porte d'Auteuil	10
Sèvres Babylone	10
Ségur	10
Vaneau	10
Église d'Auteuil	10
Arts et Métiers	11
Belleville	11
Châtelet	11
Goncourt	11
Hôtel de Ville	11
Jourdain	11
Mairie des Lilas	11
Place des Fêtes	11
Porte des Lilas	11
Pyrénées	11
Rambuteau	11
République	11
Télégraphe	11
Abbesses	12
Assemblée Nationale	12
Concorde	12
Convention	12
Corentin Celton	12
Falguière	12
Jules Joffrin	12
Lamarck Caulaincourt	12
Madeleine	12
Mairie d'Issy	12
Marcadet Poissonniers	12
Marx Dormoy	12
Montparnasse Bienvenue	12
Notre Dame de Lorette	12
Notre-Dame-des-Champs	12
Pasteur	12
Pigalle	12
Porte de Versailles	12
Porte de la Chapelle	12
Rennes	12
Rue du Bac	12
Saint-Georges	12
Saint-Lazare	12
Solférino	12
Sèvres Babylone	12
Trinité d'Estienne d'Orves	12
Vaugirard	12
Volontaires	12
Basilique de Saint-Denis	13
Brochant	13
Carrefour Pleyel	13
Champs Élysées, Clémenceau	13
Châtillon-Montrouge	13
Duroc	13
Gabriel Péri, Asnières-Gennevilliers	13
Gaité	13
Garibaldi	13
Guy Môquet	13
Invalides	13
La Fourche	13
Liège	13
Mairie de Clichy	13
Mairie de Saint-Ouen	13
Malakoff-Plateau de Vanves	13
Malakoff-Rue Étienne Dolet	13
Miromesnil	13
Montparnasse Bienvenue	13
Pernety	13
Place de Clichy	13
Plaisance	13
Porte de Clichy	13
Porte de Saint-Ouen	13
Porte de Vanves	13
Saint-Denis-Porte de Paris	13
Saint-Denis-Université	13
Saint-Francois Xavier	13
Saint-Lazare	13
Varenne	13
Bercy	14
Bibliothèque François Mitterand	14
Châtelet	14
Cour Saint-Émilion	14
Gare de Lyon	14
Madeleine	14
Pyramides	14
\.


--
-- Name: AdjacentStation AdjacentStation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AdjacentStation"
    ADD CONSTRAINT "AdjacentStation_pkey" PRIMARY KEY ("station1Num", "station2Num");


--
-- Name: Gare Gare_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Gare"
    ADD CONSTRAINT "Gare_pkey" PRIMARY KEY (nom);


--
-- Name: Intergare Intergare_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Intergare"
    ADD CONSTRAINT "Intergare_pkey" PRIMARY KEY ("gare1Nom", "gare2Nom", "ligneNom");


--
-- Name: Ligne Ligne_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ligne"
    ADD CONSTRAINT "Ligne_pkey" PRIMARY KEY (nom);


--
-- Name: Station Station_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Station"
    ADD CONSTRAINT "Station_pkey" PRIMARY KEY (num);


--
-- Name: _GareLignes _GareLignes_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_GareLignes"
    ADD CONSTRAINT "_GareLignes_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: _GareLignes_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_GareLignes_B_index" ON public."_GareLignes" USING btree ("B");


--
-- Name: AdjacentStation AdjacentStation_station1Num_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AdjacentStation"
    ADD CONSTRAINT "AdjacentStation_station1Num_fkey" FOREIGN KEY ("station1Num") REFERENCES public."Station"(num) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AdjacentStation AdjacentStation_station2Num_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AdjacentStation"
    ADD CONSTRAINT "AdjacentStation_station2Num_fkey" FOREIGN KEY ("station2Num") REFERENCES public."Station"(num) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Intergare Intergare_gare1Nom_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Intergare"
    ADD CONSTRAINT "Intergare_gare1Nom_fkey" FOREIGN KEY ("gare1Nom") REFERENCES public."Gare"(nom) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Intergare Intergare_gare2Nom_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Intergare"
    ADD CONSTRAINT "Intergare_gare2Nom_fkey" FOREIGN KEY ("gare2Nom") REFERENCES public."Gare"(nom) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Intergare Intergare_ligneNom_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Intergare"
    ADD CONSTRAINT "Intergare_ligneNom_fkey" FOREIGN KEY ("ligneNom") REFERENCES public."Ligne"(nom) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Station Station_ligneNom_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Station"
    ADD CONSTRAINT "Station_ligneNom_fkey" FOREIGN KEY ("ligneNom") REFERENCES public."Ligne"(nom) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _GareLignes _GareLignes_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_GareLignes"
    ADD CONSTRAINT "_GareLignes_A_fkey" FOREIGN KEY ("A") REFERENCES public."Gare"(nom) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _GareLignes _GareLignes_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_GareLignes"
    ADD CONSTRAINT "_GareLignes_B_fkey" FOREIGN KEY ("B") REFERENCES public."Ligne"(nom) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

