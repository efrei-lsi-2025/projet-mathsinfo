import { relations } from 'drizzle-orm';
import { boolean, integer, pgTable, varchar } from 'drizzle-orm/pg-core';

export const ligneTable = pgTable('ligne', {
  nom: varchar().primaryKey(),
  couleur: varchar().notNull()
});

export const gareTable = pgTable('gare', {
  nom: varchar().primaryKey(),
  posX: integer(),
  posY: integer()
});

export const garesToLignesTable = pgTable('gares_to_lignes', {
  nomGare: varchar()
    .notNull()
    .references(() => gareTable.nom),
  nomLigne: varchar()
    .notNull()
    .references(() => ligneTable.nom)
});

export const ligneRelations = relations(ligneTable, ({ many }) => ({
  garesToLignes: many(garesToLignesTable)
}));

export const stationTable = pgTable('station', {
  num: integer().primaryKey(),
  nom: varchar().notNull(),
  nomLigne: varchar()
    .notNull()
    .references(() => ligneTable.nom),
  isTerminus: boolean().notNull(),
  branchement: integer().notNull(),
  posX: integer(),
  posY: integer()
});

export const adjacentStationTable = pgTable('adjacent_station', {
  id: integer().primaryKey().generatedAlwaysAsIdentity(),
  numStation1: integer()
    .notNull()
    .references(() => stationTable.num),
  numStation2: integer()
    .notNull()
    .references(() => stationTable.num),
  timeSeconds: integer().notNull()
});

export const intergareTable = pgTable('intergare', {
  id: integer().primaryKey().generatedAlwaysAsIdentity(),
  nomGare1: varchar()
    .notNull()
    .references(() => gareTable.nom),
  nomGare2: varchar()
    .notNull()
    .references(() => gareTable.nom),
  nomLigne: varchar()
    .notNull()
    .references(() => ligneTable.nom),
  timeSeconds: integer().notNull()
});
