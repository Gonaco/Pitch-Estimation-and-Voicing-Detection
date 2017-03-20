clear all
close all
clc

database_dir = 'data/fda_ue/';
audios = dir('data/fda_ue/*.wav');
% files = dir('data/fda_ue/*.f0ref');
% dataAnalysis(files,audios,32,10);
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F01/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F01/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F02/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F02/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F03/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F03/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F04/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F04/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F05/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F05/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F06/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F06/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F07/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F07/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F08/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F08/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F09/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F09/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/FEMALE/MIC/F10/';
audios = dir('data/ptdb_tug/FEMALE/MIC/F10/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);



database_dir = 'data/ptdb_tug/MALE/MIC/M01/';
audios = dir('data/ptdb_tug/MALE/MIC/M01/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M02/';
audios = dir('data/ptdb_tug/MALE/MIC/M02/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M03/';
audios = dir('data/ptdb_tug/MALE/MIC/M03/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M04/';
audios = dir('data/ptdb_tug/MALE/MIC/M04/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M05/';
audios = dir('data/ptdb_tug/MALE/MIC/M05/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M06/';
audios = dir('data/ptdb_tug/MALE/MIC/M06/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M07/';
audios = dir('data/ptdb_tug/MALE/MIC/M07/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M08/';
audios = dir('data/ptdb_tug/MALE/MIC/M08/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M09/';
audios = dir('data/ptdb_tug/MALE/MIC/M09/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);

database_dir = 'data/ptdb_tug/MALE/MIC/M10/';
audios = dir('data/ptdb_tug/MALE/MIC/M10/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 10);