# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table administrador (
  id                        bigint auto_increment not null,
  login                     varchar(255),
  senha                     varchar(255),
  nome                      varchar(255),
  email                     varchar(255),
  chave_redefinicao_senha   varchar(255),
  is_avaliador              tinyint(1) default 0,
  is_professor              tinyint(1) default 0,
  is_gestor                 tinyint(1) default 0,
  is_administrador          tinyint(1) default 0,
  is_ativo                  tinyint(1) default 0,
  id_administrador          integer,
  constraint uq_administrador_login unique (login),
  constraint uq_administrador_email unique (email),
  constraint pk_administrador primary key (id))
;

create table bolsista (
  id                        bigint auto_increment not null,
  nome                      varchar(255),
  email                     varchar(255),
  matricula                 varchar(255),
  cpf                       varchar(255),
  projeto_id                bigint,
  constraint pk_bolsista primary key (id))
;

create table campus (
  id                        bigint auto_increment not null,
  nome                      varchar(255),
  constraint pk_campus primary key (id))
;

create table edital (
  id_edital                 bigint auto_increment not null,
  nome                      varchar(255),
  descricao                 varchar(255),
  periodo_inscricao_inicial varchar(255),
  periodo_inscricao_final   varchar(255),
  constraint pk_edital primary key (id_edital))
;

create table professor (
  id                        bigint auto_increment not null,
  login                     varchar(255),
  senha                     varchar(255),
  nome                      varchar(255),
  email                     varchar(255),
  chave_redefinicao_senha   varchar(255),
  is_avaliador              tinyint(1) default 0,
  is_professor              tinyint(1) default 0,
  is_gestor                 tinyint(1) default 0,
  is_administrador          tinyint(1) default 0,
  is_ativo                  tinyint(1) default 0,
  constraint uq_professor_login unique (login),
  constraint uq_professor_email unique (email),
  constraint pk_professor primary key (id))
;

create table projeto (
  id                        bigint auto_increment not null,
  nome                      varchar(255),
  data_cadastro             datetime,
  agencia                   varchar(255),
  area_conhecimento         varchar(255),
  edital_id_edital          bigint,
  campus_id                 bigint,
  constraint pk_projeto primary key (id))
;

create table usuario (
  id                        bigint auto_increment not null,
  login                     varchar(255),
  senha                     varchar(255),
  nome                      varchar(255),
  email                     varchar(255),
  chave_redefinicao_senha   varchar(255),
  is_avaliador              tinyint(1) default 0,
  is_professor              tinyint(1) default 0,
  is_gestor                 tinyint(1) default 0,
  is_administrador          tinyint(1) default 0,
  is_ativo                  tinyint(1) default 0,
  constraint uq_usuario_login unique (login),
  constraint uq_usuario_email unique (email),
  constraint pk_usuario primary key (id))
;


create table projeto_professor (
  projeto_id                     bigint not null,
  professor_id                   bigint not null,
  constraint pk_projeto_professor primary key (projeto_id, professor_id))
;
alter table bolsista add constraint fk_bolsista_projeto_1 foreign key (projeto_id) references projeto (id) on delete restrict on update restrict;
create index ix_bolsista_projeto_1 on bolsista (projeto_id);
alter table projeto add constraint fk_projeto_edital_2 foreign key (edital_id_edital) references edital (id_edital) on delete restrict on update restrict;
create index ix_projeto_edital_2 on projeto (edital_id_edital);
alter table projeto add constraint fk_projeto_campus_3 foreign key (campus_id) references campus (id) on delete restrict on update restrict;
create index ix_projeto_campus_3 on projeto (campus_id);



alter table projeto_professor add constraint fk_projeto_professor_projeto_01 foreign key (projeto_id) references projeto (id) on delete restrict on update restrict;

alter table projeto_professor add constraint fk_projeto_professor_professo_02 foreign key (professor_id) references professor (id) on delete restrict on update restrict;

# --- !Downs

SET FOREIGN_KEY_CHECKS=0;

drop table administrador;

drop table bolsista;

drop table campus;

drop table edital;

drop table professor;

drop table projeto;

drop table projeto_professor;

drop table usuario;

SET FOREIGN_KEY_CHECKS=1;

