% Process_Data_fMRI_Depression
clear; close all; clc



%% Participants info.
% 
% % info_P = importdata( 'participants.tsv' );
% [ ~, ~, info_P ] = tsvread( 'participants.tsv' );
% 
% P_info = [];
% for pn = 1 : size( info_P, 1 ) - 1
% 
%     % 1) Group, 1:= Healthy Controls, 2:= MDD
%     if strcmpi( info_P{ pn + 1, 4 }, 'Never-Depressed Control' )
%         P_info( pn, 1 ) = 1;
%     elseif strcmpi( info_P{ pn + 1, 4 }, 'Major Depressive Disorder' )
%         P_info( pn, 1 ) = 2;
%     end
% 
%     % 2) Gender, 1:= Male, 2:= Female
%     if strcmpi( info_P{ pn + 1, 2 }, 'M' )
%         P_info( pn, 2 ) = 1;
%     elseif strcmpi( info_P{ pn + 1, 2 }, 'F' )
%         P_info( pn, 2 ) = 2;
%     end
% 
%     % 3) Age
%     P_info( pn, 3 ) = str2num( info_P{ pn + 1, 3 } );
% 
% end; clear pn
% 
% save( 'P_info.mat', 'P_info' )
% 

%% Make brain T1 image
%
% V = niftiread( [ 'single_subj_T1.nii' ] );
% V = double( V );
%
% dim_data = [ 55, 66, 52 ];
% dim_standard = size( V );
%
% coord1 = round( linspace( 1, dim_standard( 1 ), dim_data( 1 ) ) );
% coord2 = round( linspace( 1, dim_standard( 2 ), dim_data( 2 ) ) );
% coord3 = round( linspace( 1, dim_standard( 3 ), dim_data( 3 ) ) );
%
% V_new = NaN( dim_data );
% for c1 = [ 1 : dim_data( 1 ) ]
%     for c2 = [ 1 : dim_data( 2 ) ]
%         for c3 = [ 1 : dim_data( 3 ) ]
%             V_new( c1, c2, c3 ) = V( coord1( c1 ), coord2( c2 ), coord3( c3 ) );
%         end; clear c3
%     end; clear c2
% end; clear c1
% V_new = V_new / 255;
%
% save( 'single_subj_T1.mat', 'V_new' )
%

%% fit, schaefer 200 atlas
%
% atlas = niftiread( 'schaefer200MNI.nii.gz' );% schaefer 200
% atlas_name = importdata( 'schaefer200NodeNames.txt' );
%
% dim_data = [ 55, 66, 52 ];
% dim_atlas = size( atlas );
%
% atlas_fD = {};
% for k = 1 : 200
%
%     [ coord1, coord2, coord3 ] = ind2sub( dim_atlas, find( atlas == k ) );
%     coords = [ coord1, coord2, coord3 ];
%
%     re_coords = [];
%     for d = 1 : 3
%         idx = linspace( 1, dim_data( d ), dim_atlas( d ) );
%         re_coords( :, d ) = round( idx( coords( :, d ) ) );
%         clear idx
%     end; clear d
%
%     idx = sub2ind( dim_data, re_coords( :, 1 ), re_coords( :, 2 ), re_coords( :, 3 ) );
%     atlas_fD{ k, 1 } = unique( idx );
%     atlas_fD{ k, 2 } = atlas_name{ k, 1 };
%
%     clear coord1 coord2 coord3 coords re_coords
%
% end; clear k
%
% save( 'atlas_schaefer_200_fD.mat', 'atlas_fD' )
%

%% fit, schaefer 400 atlas
%
% atlas = niftiread( 'schaefer400MNI.nii.gz' );% schaefer 400
% atlas_name = importdata( 'schaefer400NodeNames.txt' );
%
% dim_data = [ 55, 66, 52 ];
% dim_atlas = size( atlas );
%
% atlas_fD = {};
% for k = 1 : 400
%
%     [ coord1, coord2, coord3 ] = ind2sub( dim_atlas, find( atlas == k ) );
%     coords = [ coord1, coord2, coord3 ];
%
%     re_coords = [];
%     for d = 1 : 3
%         idx = linspace( 1, dim_data( d ), dim_atlas( d ) );
%         re_coords( :, d ) = round( idx( coords( :, d ) ) );
%         clear idx
%     end; clear d
%
%     idx = sub2ind( dim_data, re_coords( :, 1 ), re_coords( :, 2 ), re_coords( :, 3 ) );
%     atlas_fD{ k, 1 } = unique( idx );
%     atlas_fD{ k, 2 } = atlas_name{ k, 1 };
%
%     clear coord1 coord2 coord3 coords re_coords
%
% end; clear k
%
% save( 'atlas_schaefer_400_fD.mat', 'atlas_fD' )
%

%% center, schaefer 200 atlas
%
% atlas = niftiread( 'schaefer200MNI.nii.gz' );% schaefer 200
% atlas_name = importdata( 'schaefer200NodeNames.txt' );
%
% dim_data = [ 55, 66, 52 ];
% dim_atlas = size( atlas );
%
% center_fD = [];
% for k = 1 : 200
%
%     [ coord1, coord2, coord3 ] = ind2sub( dim_atlas, find( atlas == k ) );
%     coords = [ coord1, coord2, coord3 ];
%
%     re_coords = [];
%     for d = 1 : 3
%         idx = linspace( 1, dim_data( d ), dim_atlas( d ) );
%         re_coords( :, d ) = round( idx( coords( :, d ) ) );
%         clear idx
%     end; clear d
%
%     idx = sub2ind( dim_data, re_coords( :, 1 ), re_coords( :, 2 ), re_coords( :, 3 ) );
%     idx = unique( idx );
%
%     [ coord1, coord2, coord3 ] = ind2sub( dim_data, idx );
%     center_fD( k, : ) = mean( [ coord1, coord2, coord3 ], 1, 'omitnan' );
%
%     clear coord1 coord2 coord3 coords re_coords
%
% end; clear k
%
% save( 'center_schaefer_200_fD.mat', 'center_fD' )
%

%% Calculate, parcel-wise signals
% 
% load( 'atlas_schaefer_200_fD.mat' )
% 
% cd( 'MatGW' )
% 
% flist = dir( 'preproc_GW_sub-*_bold.nii.gz' );
% 
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     V = niftiread( fname );% BOLD data
% 
%     load( [ fname( 1 : end - 11 ), 'event.mat' ] )% event data
%     events = [];
%     ct = 0;
%     for tr = 1 : size( event, 1 ) - 1
%         if strcmpi( event{ tr + 1, 3 }, 'positive_music' )% 1
%             ct = ct + 1;
%             events( 1, ct ) = str2num( event{ tr + 1, 1 } ) - 10 * 3.0;
%             events( 2, ct ) = 1;
%         elseif strcmpi( event{ tr + 1, 3 }, 'negative_music' )% 2
%             ct = ct + 1;
%             events( 1, ct ) = str2num( event{ tr + 1, 1 } ) - 10 * 3.0;
%             events( 2, ct ) = 2;
%         elseif strcmpi( event{ tr + 1, 3 }, 'positive_nonmusic' )% 3
%             ct = ct + 1;
%             events( 1, ct ) = str2num( event{ tr + 1, 1 } ) - 10 * 3.0;
%             events( 2, ct ) = 3;
%         elseif strcmpi( event{ tr + 1, 3 }, 'negative_nonmusic' )% 4
%             ct = ct + 1;
%             events( 1, ct ) = str2num( event{ tr + 1, 1 } ) - 10 * 3.0;
%             events( 2, ct ) = 4;
%         end
%     end; clear tr
%     
%     events( 1, : ) = round( events( 1, : ) / 3.0 );
%     event = events; clear events
% 
%     % =========================================================================
%     % Global Signal Regression (described in - Fox et al., 2009. doi:10.1152/jn.90777.2008)
%     % -------------------------------------------------------------------------
% 
%     sizeV = size( V );
%     B = reshape( V, [ prod( sizeV( 1 : 3 ) ), sizeV( 4 ) ] );
%     B = transpose( B );
% 
%     % B = B - mean( B, 1, 'omitnan' );% de-mean
%     % B = detrend( B );% de-trend
% 
%     g = mean( B, 2, 'omitnan' );
% 
%     g_plus = inv( transpose( g ) * g ) * transpose( g );
% 
%     beta_g = g_plus * B;
% 
%     B_p = B - ( g * beta_g );% regress-out of global signal
% 
%     V_p = transpose( B_p );
%     V_p = reshape( V_p, [ sizeV ] );% global-signal-free BOLD data
% 
%     clear B g g_plus beta_g B_p
% 
%     % =========================================================================
%     % Get, parcel-wise signals
%     % -------------------------------------------------------------------------
% 
%     data = nan(  size( atlas_fD, 1 ), sizeV( 4 ) );
%     for t = 1 : sizeV( 4 )
%         temp_V = V_p( :, :, :, t );
%         for k = 1 : size( atlas_fD, 1 )
%             data( k, t ) = mean( temp_V( atlas_fD{ k, 1 } ), 1, 'omitnan' );
%         end; clear k
%     end; clear t
%     clear temp_V
% 
%     % =========================================================================
% 
%     save( [ fname( 4 : end - 12 ), '.mat' ], 'event', 'data' )
%     clear fname V event sizeV V_p data
% 
% end; clear fn
% 
% clear flist
% 
% cd( '..' )
% 

%% Save, parcel-wise signals
% 
% cd( 'MatGW' )
% 
% flist1 = dir( 'proc_GW_sub-*_1.mat' );
% flist2 = dir( 'proc_GW_sub-*_2.mat' );
% flist3 = dir( 'proc_GW_sub-*_3.mat' );
% flist4 = dir( 'proc_GW_sub-*_4.mat' );
% flist5 = dir( 'proc_GW_sub-*_5.mat' );
% 
% for fn = 1 : size( flist1, 1 )
% 
%     fname1 = flist1( fn, 1 ).name;
%     fname2 = flist2( fn, 1 ).name;
%     fname3 = flist3( fn, 1 ).name;
%     fname4 = flist4( fn, 1 ).name;
%     fname5 = flist5( fn, 1 ).name;
% 
%     data_all = {};
%     event_all = {};
% 
%     load( fname1 )
%     data_all{ 1, 1 } = data;
%     event_all{ 1, 1 } = event;
% 
%     load( fname2 )
%     data_all{ 1, 2 } = data;
%     event_all{ 1, 2 } = event;
% 
%     load( fname3 )
%     data_all{ 1, 3 } = data;
%     event_all{ 1, 3 } = event;
% 
%     load( fname4 )
%     data_all{ 1, 4 } = data;
%     event_all{ 1, 4 } = event;
% 
%     load( fname5 )
%     data_all{ 1, 5 } = data;
%     event_all{ 1, 5 } = event;
% 
%     cd( '..' )
% 
%     save( [ 'parcel', fname1( 5 : end - 6 ), '.mat' ], 'data_all', 'event_all' )
%     clear fname1 fname2 data event data_all event_all
% 
%     cd( 'MatGW' )
% 
% end; clear fn
% 
% clear flist1 flist2
% 
% cd( '..' )
% 

%% Calculate, parcel-wise signals (without GSR)
% 
% load( 'atlas_schaefer_200_fD.mat' )
% 
% cd( 'MatGW' )
% 
% flist = dir( 'preproc_GW_sub-*_bold.nii.gz' );
% 
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     V = niftiread( fname );% BOLD data
% 
%     load( [ fname( 1 : end - 11 ), 'event.mat' ] )% event data
%     events = [];
%     ct = 0;
%     for tr = 1 : size( event, 1 ) - 1
%         if strcmpi( event{ tr + 1, 3 }, 'positive_music' )% 1
%             ct = ct + 1;
%             events( 1, ct ) = str2num( event{ tr + 1, 1 } ) - 10 * 3.0;
%             events( 2, ct ) = 1;
%         elseif strcmpi( event{ tr + 1, 3 }, 'negative_music' )% 2
%             ct = ct + 1;
%             events( 1, ct ) = str2num( event{ tr + 1, 1 } ) - 10 * 3.0;
%             events( 2, ct ) = 2;
%         elseif strcmpi( event{ tr + 1, 3 }, 'positive_nonmusic' )% 3
%             ct = ct + 1;
%             events( 1, ct ) = str2num( event{ tr + 1, 1 } ) - 10 * 3.0;
%             events( 2, ct ) = 3;
%         elseif strcmpi( event{ tr + 1, 3 }, 'negative_nonmusic' )% 4
%             ct = ct + 1;
%             events( 1, ct ) = str2num( event{ tr + 1, 1 } ) - 10 * 3.0;
%             events( 2, ct ) = 4;
%         end
%     end; clear tr
% 
%     events( 1, : ) = round( events( 1, : ) / 3.0 );
%     event = events; clear events
% 
%     % =========================================================================
%     % Global Signal Regression (described in - Fox et al., 2009. doi:10.1152/jn.90777.2008)
%     % -------------------------------------------------------------------------
%     %
%     %     sizeV = size( V );
%     %     B = reshape( V, [ prod( sizeV( 1 : 3 ) ), sizeV( 4 ) ] );
%     %     B = transpose( B );
%     %
%     %     % B = B - mean( B, 1, 'omitnan' );% de-mean
%     %     % B = detrend( B );% de-trend
%     %
%     %     g = mean( B, 2, 'omitnan' );
%     %
%     %     g_plus = inv( transpose( g ) * g ) * transpose( g );
%     %
%     %     beta_g = g_plus * B;
%     %
%     %     B_p = B - ( g * beta_g );% regress-out of global signal
%     %
%     %     V_p = transpose( B_p );
%     %     V_p = reshape( V_p, [ sizeV ] );% global-signal-free BOLD data
%     %
%     %     clear B g g_plus beta_g B_p
%     %
%     % =========================================================================
%     % Get, parcel-wise signals
%     % -------------------------------------------------------------------------
% 
%     sizeV = size( V );
%     B = reshape( V, [ prod( sizeV( 1 : 3 ) ), sizeV( 4 ) ] );
%     B = transpose( B );
%     B = B - mean( B, 1, 'omitnan' );% de-mean
%     B = detrend( B );% de-trend
%     V_p = transpose( B );
%     V_p = reshape( V_p, [ sizeV ] );
% 
%     data = nan(  size( atlas_fD, 1 ), sizeV( 4 ) );
%     for t = 1 : sizeV( 4 )
%         temp_V = V_p( :, :, :, t );
%         for k = 1 : size( atlas_fD, 1 )
%             data( k, t ) = mean( temp_V( atlas_fD{ k, 1 } ), 1, 'omitnan' );
%         end; clear k
%     end; clear t
%     clear temp_V
% 
%     % =========================================================================
% 
%     % save( [ fname( 4 : end - 12 ), '.mat' ], 'event', 'data' )
%     save( [ fname( 4 : 8 ), 'WO', fname( 11 : end - 12 ), '.mat' ], 'event', 'data' )
%     clear fname V event sizeV V_p data
% 
% end; clear fn
% 
% clear flist
% 
% cd( '..' )
% 

%% Save, parcel-wise signals (without GSR)
% 
% cd( 'MatGW' )
% 
% flist1 = dir( 'proc_WO_sub-*_1.mat' );
% flist2 = dir( 'proc_WO_sub-*_2.mat' );
% flist3 = dir( 'proc_WO_sub-*_3.mat' );
% flist4 = dir( 'proc_WO_sub-*_4.mat' );
% flist5 = dir( 'proc_WO_sub-*_5.mat' );
% 
% for fn = 1 : size( flist1, 1 )
% 
%     fname1 = flist1( fn, 1 ).name;
%     fname2 = flist2( fn, 1 ).name;
%     fname3 = flist3( fn, 1 ).name;
%     fname4 = flist4( fn, 1 ).name;
%     fname5 = flist5( fn, 1 ).name;
% 
%     data_all = {};
%     event_all = {};
% 
%     load( fname1 )
%     data_all{ 1, 1 } = data;
%     event_all{ 1, 1 } = event;
% 
%     load( fname2 )
%     data_all{ 1, 2 } = data;
%     event_all{ 1, 2 } = event;
% 
%     load( fname3 )
%     data_all{ 1, 3 } = data;
%     event_all{ 1, 3 } = event;
% 
%     load( fname4 )
%     data_all{ 1, 4 } = data;
%     event_all{ 1, 4 } = event;
% 
%     load( fname5 )
%     data_all{ 1, 5 } = data;
%     event_all{ 1, 5 } = event;
% 
%     cd( '..' )
% 
%     save( [ 'parcel', fname1( 5 : end - 6 ), '.mat' ], 'data_all', 'event_all' )
%     clear fname1 fname2 data event data_all event_all
% 
%     cd( 'MatGW' )
% 
% end; clear fn
% 
% clear flist1 flist2
% 
% cd( '..' )
% 

%% Make, Data for fMRI Depression
% 
% atlas_networks = importdata( 'schaefer200x7CommunityAffiliation.1D' );
% 
% flist = dir( 'parcel_*.mat' );
% 
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn ).name;
% 
%     load( fname )
% 
%     nBins = 20;
% 
%     data = data_all{ 1, 1 };
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_1st = data;
% 
%     data = data_all{ 1, 2 };
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_2nd = data;
% 
%     data = data_all{ 1, 3 };
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_3rd = data;
% 
%     data = data_all{ 1, 4 };
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_4th = data;
% 
%     data = data_all{ 1, 5 };
%     edges = SD_getEdges( data, nBins );
%     data = SD_getStates( data, edges );
%     data = data ./ nBins;
%     data_5th = data;
% 
%     data = [ data_1st, data_2nd, data_3rd, data_4th, data_5th ];
% 
%     event = [];
%     ct = 0;
%     for n = 1 : size( event_all, 2 )
%         tevent = event_all{ 1, n };
%         tevent( 1, : ) = tevent( 1, : ) + ct;
%         event = [ event, tevent ];
%         ct = ct + size( data_all{ 1, n }, 2 );
%     end; clear n ct tevent
% 
%     % -------------------------------------------------------------------------
% 
%     save( [ 'Storage_fMRI_Depression_Data', fname( 10 : end ) ], ...
%         'event', 'data', ...
%         '-v7.3' )
% 
%     clear event data
%     clear nBins edges data_1st data_2nd data_3rd data_4th data_5th
%     clear data_all event_all
%     clear fname
% 
%     disp( [ 'Data: ', num2str( fn ), ' / ', num2str( size( flist, 1 ) ) ] )
% 
% end; clear fn
% 
% clear flist
% 
% clear atlas_networks
% 
