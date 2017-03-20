clear all
close all
clc

database_dir = 'data/fda_ue/';
audios = dir('data/fda_ue/*.wav');
%files = dir('data/fda_ue/*.f0ref');
%dataAnalysis(files,audios,32,15);
database_dir = 'data/ptdb_tug/MALE/MIC/M01/';
audios = dir('data/ptdb_tug/MALE/MIC/M01/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M02/';
audios = dir('data/ptdb_tug/MALE/MIC/M02/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M03/';
audios = dir('data/ptdb_tug/MALE/MIC/M03/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M04/';
audios = dir('data/ptdb_tug/MALE/MIC/M04/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M05/';
audios = dir('data/ptdb_tug/MALE/MIC/M05/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M06/';
audios = dir('data/ptdb_tug/MALE/MIC/M06/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M07/';
audios = dir('data/ptdb_tug/MALE/MIC/M07/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M08/';
audios = dir('data/ptdb_tug/MALE/MIC/M08/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M09/';
audios = dir('data/ptdb_tug/MALE/MIC/M09/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M10/';
audios = dir('data/ptdb_tug/MALE/MIC/M10/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);



database_dir = 'data/ptdb_tug/MALE/MIC/M01/';
audios = dir('data/ptdb_tug/MALE/MIC/M01/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M02/';
audios = dir('data/ptdb_tug/MALE/MIC/M02/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M03/';
audios = dir('data/ptdb_tug/MALE/MIC/M03/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M04/';
audios = dir('data/ptdb_tug/MALE/MIC/M04/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M05/';
audios = dir('data/ptdb_tug/MALE/MIC/M05/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M06/';
audios = dir('data/ptdb_tug/MALE/MIC/M06/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M07/';
audios = dir('data/ptdb_tug/MALE/MIC/M07/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M08/';
audios = dir('data/ptdb_tug/MALE/MIC/M08/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M09/';
audios = dir('data/ptdb_tug/MALE/MIC/M09/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

database_dir = 'data/ptdb_tug/MALE/MIC/M10/';
audios = dir('data/ptdb_tug/MALE/MIC/M10/*.wav');
[signals, fs_array, pitch_array, mean_pitch] = getPitch(audios, database_dir, 32, 15);

