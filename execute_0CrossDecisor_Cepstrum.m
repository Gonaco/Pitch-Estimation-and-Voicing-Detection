clc
close all
clear all

w_L = 32; % 32ms window

files = dir('data/ptdb_tug/FEMALE/MIC/F01/*.f0ref');
train_audios = dir('data/ptdb_tug/FEMALE/MIC/F01/*.wav');
[voiced_model, unvoiced_model] = learnFromData(files,'data/ptdb_tug/FEMALE/MIC/F01/',train_audios,'data/ptdb_tug/FEMALE/MIC/F01/', w_L, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F01/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F01/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F02/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F02/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F03/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F03/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F04/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F04/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F05/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F05/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F06/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F06/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F07/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F07/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F08/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F08/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F09/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F09/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F10/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F10/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

files = dir('data/ptdb_tug/MALE/MIC/M01/*.f0ref');
train_audios = dir('data/ptdb_tug/MALE/MIC/M01/*.wav');

%
files = dir('data/ptdb_tug/MALE/MIC/M01/*.f0ref');
train_audios = dir('data/ptdb_tug/MALE/MIC/M01/*.wav')
[voiced_model, unvoiced_model] = learnFromData(files,'data/ptdb_tug/MALE/MIC/M01/',train_audios,'data/ptdb_tug/MALE/MIC/M01/', w_L, 10);
%

database_dir = 'data/ptdb_tug/MALE/MIC/M01/';
audios = dir('data/ptdb_tug/MALE/MIC/M01/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M02/';
audios = dir('data/ptdb_tug/MALE/MIC/M02/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M03/';
audios = dir('data/ptdb_tug/MALE/MIC/M03/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M04/';
audios = dir('data/ptdb_tug/MALE/MIC/M04/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M05/';
audios = dir('data/ptdb_tug/MALE/MIC/M05/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M06/';
audios = dir('data/ptdb_tug/MALE/MIC/M06/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M07/';
audios = dir('data/ptdb_tug/MALE/MIC/M07/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M08/';
audios = dir('data/ptdb_tug/MALE/MIC/M08/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M09/';
audios = dir('data/ptdb_tug/MALE/MIC/M09/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M10/';
audios = dir('data/ptdb_tug/MALE/MIC/M10/*.wav');
getPitchCepstrum(audios, database_dir, voiced_model, unvoiced_model, 32, 10);

files = dir('data/fda_ue/*.f0ref');
train_audios = dir('data/fda_ue/*.wav');

[voiced_model, unvoiced_model] = learnFromData(files,'data/fda_ue/',train_audios,'data/fda_ue/', w_L, 15);

audios = dir('data/fda_ue/*.wav');
getPitchCepstrum(audios, 'data/fda_ue/', voiced_model, unvoiced_model, w_L, 15);

