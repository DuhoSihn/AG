% Process_Data_RD_PBW
clear; close all; clc



%% Channel locations
% clear
% N_ch = 128; % number of EEG electrodes (same for all participants)
% 
% % % Kayser, J., Tenke, C.E. 2006a. Principal components analysis of Laplacian waveforms as a generic method for identifying ERP generator patterns: I. Evaluation with auditory oddball tasks. Clinical Neurophysiology, 117(2):348-368. doi: 10.1016/j.clinph.2005.08.034
% % % Kayser, J., Tenke, C.E. 2006b. Principal components analysis of Laplacian waveforms as a generic method for identifying ERP generator patterns: II. Adequacy of low-density estimates. Clinical Neurophysiology, 117(2):369-380. doi: 10.1016/j.clinph.2005.08.033
% % % Kayser, J. 2009. Current source density (CSD) interpolation using spherical splines - CSD Toolbox (Version 1.1) [http://psychophysiology.cpmc.columbia.edu/Software/CSDtoolbox]. New York State Psychiatric Institute: Division of Cognitive Neuroscience.
% % % constant m = 4 which indicates a rigid spline interpolation; smoothing constant \lambda = 10e-5
% % % Tenke, C.E., Kayser J., Manna C.G., Fekri, S., Kroppmann, C.J., Schaller, J.D., Alschuler, D.M., Stewart, J.W., McGrath, P.J., Bruder, G.E. 2011. Current source density measures of electroencephalographic alpha predict antidepressant treatment response. Biological Psychiatry 70(4):388-394. doi: 10.1016/j.biopsych.2011.02.016
% % 
% % addpath( genpath( 'F:\DATA\Util\Programs_for_Data_Treate\CSDtoolbox' ) )
% 
% load( 'raw_sub-001_ses-01_1.mat' )
% 
% chanlocs = raw.chanlocs;
% clear raw
% 
% t_ch_name = cell( N_ch, 1 );
% for ch = 1 : N_ch
%     tch_name = chanlocs( 1, ch ).labels;
%     t_ch_name{ ch, 1 } = tch_name;
%     clear tch_name
% end; clear ch
% ch_name = t_ch_name;
% clear t_ch_name
% 
% % ch_use = [];
% % E = {};
% % ct_ch = 0;
% % for ch = 1 : N_ch
% %     ct_ch = ct_ch + 1;
% %     E{ ct_ch, 1 } = ch_name{ ch, 1 };
% %     ch_use = [ ch_use; ch ];
% % end; clear ch ct_ch
% 
% % ch_locs = importdata( '10-5-System_Mastoids_EGI129.csd' );
% % ch_loc = [];
% % for ch = 1 : size( E, 1 )
% %     idx0 = [];
% %     for ch0 = 1 : size( ch_locs.textdata, 1 )
% %         idx0( ch0, 1 ) = strcmpi( ch_locs.textdata{ ch0, 1 }, E{ ch, 1 } );
% %     end; clear ch0
% %     idx0 = find( idx0 == 1 );
% %     if isempty( idx0 )
% %         error( 'There is no appropriate channel name!' )
% %     else
% %         ch_loc( ch, : ) = ch_locs.data( idx0 - 2, 4 :6 );
% %     end
% %     clear idx0
% % end; clear ch
% % clear ch_locs
% 
% ch_loc = [];
% for ch = 1 : N_ch
%     ch_loc( ch, 1 ) = chanlocs( ch ).X;
%     ch_loc( ch, 2 ) = -chanlocs( ch ).Y;
%     ch_loc( ch, 3 ) = chanlocs( ch ).Z;
% end; clear ch
% 
% chanloc3D = ch_loc;
% 
% [ ThetaRad, PhiRad ] = cart2sph( chanloc3D( :, 1 ), chanloc3D( :, 2 ), chanloc3D( :, 3 ) );
% PhiRad = ( pi / 2 ) - PhiRad;
% 
% chanloc2D = [ cos( ThetaRad ) .* PhiRad, sin( ThetaRad ) .* PhiRad ];
% chanloc2D = chanloc2D ./ max( abs( chanloc2D ), [], 1 );
% 
% save( 'chanloc.mat', 'ch_name', 'chanloc2D', 'chanloc3D' )
% 

%% ICA
% clear
% addpath( genpath( 'F:\DATA\Util\Programs_for_Data_Treate\eeglab2023.0' ) );
% 
% N_ch = 128; % number of EEG electrodes (same for all participants)
% 
% flist = dir( 'raw_*.mat' );
% 
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     % ---------------------------------------------------------------------
% 
%     EEG = raw;
% 
%     EEG = pop_select( EEG, 'channel', [ 1 : N_ch ] );
% 
%     EEG = clean_asr( EEG, 20 );
% 
%     % EEG = pop_runica( EEG );
%     [ EEG.icaweights, EEG.icasphere ] = runica( EEG.data );
%     % EEG.icawinv = pinv( EEG.icaweights * EEG.icasphere );
%     % EEG.icachansind = [ 1 : N_ch ];
% 
%     % ---------------------------------------------------------------------
% 
%     save( [ 'ICA', fname( 4 : end ) ], 'EEG' )
% 
%     clear raw EEG
%     clear fname
% 
% end; clear fn
% 

%% Remove ICs
% clear
% N_ch = 128; % number of EEG electrodes (same for all participants)
% 
% flist = dir( 'raw_*.mat' );
% 
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
%     load( [ 'ICA', fname( 4 : end ) ] )
% 
%     % ---------------------------------------------------------------------
% 
%     % % EEG = pop_iclabel( EEG );
%     % EEG = iclabel( EEG );
%     % ch_loc_1 = find( EEG.etc.ic_classification.ICLabel.classifications( :, 3 ) > 0.9 );
%     % ch_loc_2 = find( EEG.etc.ic_classification.ICLabel.classifications( :, 2 ) > 0.9 );
%     %
%     % data_ICA = EEG.icaweights * EEG.data;
%     % data_ICA( [ ch_loc_1, ch_loc_2 ], : ) = 0;% removing eye blink noise
%     % data_rec = inv( EEG.icaweights ) * data_ICA;
%     % EEG.data = single( data_rec );
% 
%     % data_ICA = EEG.icaweights * EEG.data;
%     data_ICA = real( EEG.icaweights ) * EEG.data;
% 
%     comp_corr = [];
%     for ch = 1 : size( data_ICA, 1 )
%         comp_corr( ch, 1 ) = corr( transpose( data_ICA( ch, : ) ), transpose( raw.data( 133, : ) ), 'Type', 'Spearman' );
%     end; clear ch
%     [ ~, ch_loc1 ] = max( abs( comp_corr ), [], 1 );% choosing eye blink component
%     ch_loc2 = find( abs( comp_corr ) > 0.5 );% choosing eye blink component
%     if isempty( ch_loc2 )
%         ch_loc_eye = ch_loc1;
%     else
%         ch_loc_eye = ch_loc2;
%     end
%     clear ch_loc1 ch_loc2
% 
%     comp_corr = [];
%     for ch = 1 : size( data_ICA, 1 )
%         comp_corr( ch, 1 ) = corr( transpose( data_ICA( ch, : ) ), transpose( raw.data( 129, : ) ), 'Type', 'Spearman' );
%     end; clear ch
%     [ ~, ch_loc1 ] = max( abs( comp_corr ), [], 1 );% choosing muscle component
%     ch_loc2 = find( abs( comp_corr ) > 0.5 );% choosing muscle component
%     if isempty( ch_loc2 )
%         ch_loc_muscle = ch_loc1;
%     else
%         ch_loc_muscle = ch_loc2;
%     end
%     clear ch_loc1 ch_loc2
% 
%     data_ICA( [ ch_loc_eye; ch_loc_muscle ], : ) = 0;% removing eye blink & muscle noise
% 
%     % data_rec = inv( EEG.icaweights ) * data_ICA;
%     data_rec = inv( real( EEG.icaweights ) ) * data_ICA;
% 
%     raw.data( [ 1 : N_ch ], : ) = single( data_rec );
% 
%     % ---------------------------------------------------------------------
% 
%     save( [ 'rIC', fname( 4 : end ) ], 'raw' )
% 
%     clear raw EEG
%     clear fname
% 
% end; clear fn
% 

%% Surface Laplacian
% clear
% N_ch = 128; % number of EEG electrodes (same for all participants)
% 
% load( 'chanloc.mat' )
% 
% % Kayser, J., Tenke, C.E. 2006a. Principal components analysis of Laplacian waveforms as a generic method for identifying ERP generator patterns: I. Evaluation with auditory oddball tasks. Clinical Neurophysiology, 117(2):348-368. doi: 10.1016/j.clinph.2005.08.034
% % Kayser, J., Tenke, C.E. 2006b. Principal components analysis of Laplacian waveforms as a generic method for identifying ERP generator patterns: II. Adequacy of low-density estimates. Clinical Neurophysiology, 117(2):369-380. doi: 10.1016/j.clinph.2005.08.033
% % Kayser, J. 2009. Current source density (CSD) interpolation using spherical splines - CSD Toolbox (Version 1.1) [http://psychophysiology.cpmc.columbia.edu/Software/CSDtoolbox]. New York State Psychiatric Institute: Division of Cognitive Neuroscience.
% % constant m = 4 which indicates a rigid spline interpolation; smoothing constant \lambda = 10e-5
% % Tenke, C.E., Kayser J., Manna C.G., Fekri, S., Kroppmann, C.J., Schaller, J.D., Alschuler, D.M., Stewart, J.W., McGrath, P.J., Bruder, G.E. 2011. Current source density measures of electroencephalographic alpha predict antidepressant treatment response. Biological Psychiatry 70(4):388-394. doi: 10.1016/j.biopsych.2011.02.016
% 
% addpath( genpath( 'F:\DATA\Util\Programs_for_Data_Treate\CSDtoolbox' ) )
% 
% flist = dir( 'rIC_*.mat' );
% 
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn ).name;
% 
%     load( fname )
% 
%     [ ThetaRad, PhiRad ] = cart2sph( chanloc3D( :, 1 ), chanloc3D( :, 2 ), chanloc3D( :, 3 ) );
%     theta = ThetaRad * 180 / pi;
%     phi = PhiRad * 180 / pi;
% 
%     clear M
%     M.theta = theta;
%     M.phi = phi;
%     M.lab = cell( N_ch , 1 );
%     for ch = 1 : N_ch
%         M.lab{ ch, 1 } = [ 'Ch', num2str( ch ) ];
%     end; clear ch
% 
%     [ G, H ] = GetGH( M );% = GetGH( M, 4 )
%     % [ G, H ] = GetGH( M, 3 );
%     % [ G, H ] = GetGH( M, 2 );
% 
%     data_A = CSD( double( raw.data( [ 1 : N_ch ], : ) ), G, H );% current source density
% 
%     % ---------------------------------------------------------------------
% 
%     fs = raw.srate;
% 
%     data_A_D = data_A;
%     data_A_T = data_A;
%     data_A_A = data_A;
%     data_A_B = data_A;
%     data_A_G = data_A;
% 
%     data_A_D = fct_bandpass_parfor( data_A_D, fs, [ 1, 3 ], 'fir1', 7 * fix( fs / 1 ) );
%     data_A_T = fct_bandpass_parfor( data_A_T, fs, [ 4, 7 ], 'fir1', 7 * fix( fs / 4 ) );
%     data_A_A = fct_bandpass_parfor( data_A_A, fs, [ 8, 12 ], 'fir1', 7 * fix( fs / 8 ) );
%     data_A_B = fct_bandpass_parfor( data_A_B, fs, [ 13, 30 ], 'fir1', 7 * fix( fs / 13 ) );
%     data_A_G = fct_bandpass_parfor( data_A_G, fs, [ 31, 50 ], 'fir1', 7 * fix( fs / 31 ) );
% 
%     data_A_DH = [];
%     data_A_TH = [];
%     data_A_AH = [];
%     data_A_BH = [];
%     data_A_GH = [];
%     for ch = 1 : size( data_A, 1 )
%         data_A_DH( ch, : ) = hilbert( data_A_D( ch, : ) );
%         data_A_TH( ch, : ) = hilbert( data_A_T( ch, : ) );
%         data_A_AH( ch, : ) = hilbert( data_A_A( ch, : ) );
%         data_A_BH( ch, : ) = hilbert( data_A_B( ch, : ) );
%         data_A_GH( ch, : ) = hilbert( data_A_G( ch, : ) );
%     end; clear ch
% 
%     data_B = [];
%     ct_ch = 0;
%     for ch = [ 129, 130, 134 : 141 ]
%         ct_ch = ct_ch + 1;
%         data_B( ct_ch, : ) = abs( hilbert( double( raw.data( ch, : ) ) ) );
%     end; clear ch ct_ch
% 
%     data_C = [];
%     ct_ch = 0;
%     for ch = [ 142 : 147 ]
%         ct_ch = ct_ch + 1;
%         data_C( ct_ch, : ) = double( raw.data( ch, : ) );
%     end; clear ch ct_ch
% 
%     % ---------------------------------------------------------------------
% 
%     fs = raw.srate;
%     fss = 100;% Hz
% 
%     event = [];
%     for tr = 1 : size( raw.event, 2 )
%         event( 1, tr ) = round( raw.event( tr ).latency );
%         if str2num( fname( 18 ) ) <= 2
%             if strcmpi( raw.event( tr ).type( 1 ), 'L' )
%                 event( 2, tr ) = 1;
%             elseif strcmpi( raw.event( tr ).type( 1 ), 'R' )
%                 event( 2, tr ) = 2;
%             end
%         else
%             if strcmpi( raw.event( tr ).type( 6 : 8 ), 'CW_' )
%                 event( 2, tr ) = 1;
%             elseif strcmpi( raw.event( tr ).type( 6 : 8 ), 'CCW' )
%                 event( 2, tr ) = 2;
%             end
%         end
%     end; clear tr
% 
%     idx_realign = round( linspace( 1, size( data_A_D, 2 ), round( ( fss / fs ) * size( data_A_D, 2 ) ) ) );
% 
%     data_A_D = single( data_A_DH( :, idx_realign ) );
%     data_A_T = single( data_A_TH( :, idx_realign ) );
%     data_A_A = single( data_A_AH( :, idx_realign ) );
%     data_A_B = single( data_A_BH( :, idx_realign ) );
%     data_A_G = single( data_A_GH( :, idx_realign ) );
%     data_B = single( data_B( :, idx_realign ) );
%     data_C = single( data_C( :, idx_realign ) );
% 
%     [ ~, loc ] = min( abs( bsxfun( @minus, event( 1, : ), transpose( idx_realign ) ) ), [], 1 );
%     event( 1, : ) = loc;
% 
%     clear idx_realign loc
% 
%     save( [ 'CSD', fname( 4 : end ) ], 'fs', 'fss', 'event', 'data_A_D', 'data_A_T', 'data_A_A', 'data_A_B', 'data_A_G', 'data_B', 'data_C' )
%     
%     clear G H
%     clear ThetaRad PhiRad theta phi
%     clear raw
% 
% end; clear fn
% 

%% Make, Data for RD PBW
% clear
% flist = dir( 'CSD_*.mat' );
% 
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn ).name;
% 
%     load( fname )
% 
%     fsss = 10;% Hz
% 
%     data_A_D = abs( data_A_D );
%     data_A_T = abs( data_A_T );
%     data_A_A = abs( data_A_A );
%     data_A_B = abs( data_A_B );
%     data_A_G = abs( data_A_G );
%     idx_realign = round( linspace( 1, size( data_A_D, 2 ), round( ( fsss / fss ) * size( data_A_D, 2 ) ) ) );
%     data_A_D = double( data_A_D( :, idx_realign ) );
%     data_A_T = double( data_A_T( :, idx_realign ) );
%     data_A_A = double( data_A_A( :, idx_realign ) );
%     data_A_B = double( data_A_B( :, idx_realign ) );
%     data_A_G = double( data_A_G( :, idx_realign ) );
%     data_B = double( data_B( :, idx_realign ) );
%     data_C = double( data_C( :, idx_realign ) );
% 
%     [ ~, loc ] = min( abs( bsxfun( @minus, event( 1, : ), transpose( idx_realign ) ) ), [], 1 );
%     event( 1, : ) = loc;
%     clear idx_realign loc
% 
%     nBins = 20;
% 
%     data = data_A_D;
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_A_D = data;
% 
%     data = data_A_T;
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_A_T = data;
% 
%     data = data_A_A;
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_A_A = data;
% 
%     data = data_A_B;
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_A_B = data;
% 
%     data = data_A_G;
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_A_G = data;
% 
%     data = data_B;
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_B = data;
% 
%     nBins = 20;
% 
%     data = data_C;
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_C = data;
% 
%     % -------------------------------------------------------------------------
% 
%     save( [ 'Storage_RD_PBW_Data', fname( 4 : end ) ], ...
%         'fsss', 'event', 'data_A_D', 'data_A_T', 'data_A_A', 'data_A_B', 'data_A_G', 'data_B', 'data_C', ...
%         '-v7.3' )
%     clear event data_A_D data_A_T data_A_A data_A_B data_A_G data_B data_C
%     clear fsss nBins data edges
%     clear fs fss data_D data_T data_A data_B data_G
%     clear fname
% 
%     disp( [ 'Data: ', num2str( fn ), ' / ', num2str( size( flist, 1 ) ) ] )
% 
% end; clear fn
% 
% clear flist
% 
