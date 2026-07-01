% Process_Data_fMRI_Schizophrenia
clear; close all; clc



%% Participants info.
% 
% % info_P = importdata( 'participants.tsv' );
% [ ~, ~, info_P ] = tsvread( 'participants.tsv' );
% 
% P_info = [];
% for pn = 1 : size( info_P, 1 ) - 1
% 
%     % 1) Group, 1:= Healthy Controls, 2:= SCZ, 3:= SCZ-SIB
%     if strcmpi( info_P{ pn + 1, 2 }, 'CON' ) || strcmpi( info_P{ pn + 1, 2 }, 'CON-SIB' )
%         P_info( pn, 1 ) = 1;
%     elseif strcmpi( info_P{ pn + 1, 2 }, 'SCZ' )
%         P_info( pn, 1 ) = 2;
%     elseif strcmpi( info_P{ pn + 1, 2 }, 'SCZ-SIB' )
%         P_info( pn, 1 ) = 3;
%     end
% 
%     % 2) Gender, 1:= Male, 2:= Female
%     if strcmpi( info_P{ pn + 1, 3 }, 'MALE' )
%         P_info( pn, 2 ) = 1;
%     elseif strcmpi( info_P{ pn + 1, 3 }, 'FEMALE' )
%         P_info( pn, 2 ) = 2;
%     end
% 
%     % 3) Age
%     P_info( pn, 3 ) = str2num( info_P{ pn + 1, 5 } );
% 
%     % 4) Participant Index
%     P_info( pn, 4 ) = str2num( info_P{ pn + 1, 1 }( 5 : end ) );
% 
% end; clear pn
% 
% P_info = [ P_info( 1 : 10, : ); P_info( 97 : 99, : ); P_info( 11 : 96, : ) ];
% 
% save( 'P_info.mat', 'P_info' )
% 

%% Make brain T1 image
%
% V = niftiread( [ 'single_subj_T1.nii' ] );
% V = double( V );
%
% dim_data = [ 41, 48, 40 ];
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
% dim_data = [ 41, 48, 40 ];
% dim_atlas = size( atlas );
%
% atlas_fS = {};
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
%     atlas_fS{ k, 1 } = unique( idx );
%     atlas_fS{ k, 2 } = atlas_name{ k, 1 };
%
%     clear coord1 coord2 coord3 coords re_coords
%
% end; clear k
%
% save( 'atlas_schaefer_200_fS.mat', 'atlas_fS' )
%

%% fit, schaefer 400 atlas
%
% atlas = niftiread( 'schaefer400MNI.nii.gz' );% schaefer 400
% atlas_name = importdata( 'schaefer400NodeNames.txt' );
%
% dim_data = [ 41, 48, 40 ];
% dim_atlas = size( atlas );
%
% atlas_fS = {};
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
%     atlas_fS{ k, 1 } = unique( idx );
%     atlas_fS{ k, 2 } = atlas_name{ k, 1 };
%
%     clear coord1 coord2 coord3 coords re_coords
%
% end; clear k
%
% save( 'atlas_schaefer_400_fS.mat', 'atlas_fS' )
%

%% center, schaefer 200 atlas
%
% atlas = niftiread( 'schaefer200MNI.nii.gz' );% schaefer 200
% atlas_name = importdata( 'schaefer200NodeNames.txt' );
%
% dim_data = [ 41, 48, 40 ];
% dim_atlas = size( atlas );
%
% center_fS = [];
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
%     center_fS( k, : ) = mean( [ coord1, coord2, coord3 ], 1, 'omitnan' );
%
%     clear coord1 coord2 coord3 coords re_coords
%
% end; clear k
%
% save( 'center_schaefer_200_fS.mat', 'center_fS' )
%

%% Calculate, parcel-wise signals
% 
% load( 'atlas_schaefer_200_fS.mat' )
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
%     tr_info = str2num( fname( end - 12 ) );
%     events = [];
%     if size( event, 1 ) > 1
%         ct = 0;
%         for tr = 1 : size( event, 1 ) - 1
%             if str2num( event{ tr + 1, 4 } ) < 0
%                 ct = ct + 1;
%                 events( 1, ct ) = str2num( event{ tr + 1, 1 } ) - 10 * 2.5;
%                 events( 2, ct ) = tr_info;
%             end
%         end; clear tr ct
% 
%         events( 1, : ) = round( events( 1, : ) / 2.5 );
%     end
%     event = events; clear events tr_info
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
%     data = nan(  size( atlas_fS, 1 ), sizeV( 4 ) );
%     for t = 1 : sizeV( 4 )
%         temp_V = V_p( :, :, :, t );
%         for k = 1 : size( atlas_fS, 1 )
%             data( k, t ) = mean( temp_V( atlas_fS{ k, 1 } ), 1, 'omitnan' );
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
% 
% for fn = 1 : size( flist1, 1 )
% 
%     try
% 
%         fname1 = flist1( fn, 1 ).name;
%         fname2 = flist2( fn, 1 ).name;
%         fname3 = flist3( fn, 1 ).name;
% 
%         data_all = {};
%         event_all = {};
% 
%         load( fname1 )
%         if isempty( event ), error( 'Empty event!' ), end
%         data_all{ 1, 1 } = data;
%         event_all{ 1, 1 } = event;
% 
%         load( fname2 )
%         if isempty( event ), error( 'Empty event!' ), end
%         data_all{ 1, 2 } = data;
%         event_all{ 1, 2 } = event;
% 
%         load( fname3 )
%         if isempty( event ), error( 'Empty event!' ), end
%         data_all{ 1, 3 } = data;
%         event_all{ 1, 3 } = event;
% 
%         cd( '..' )
% 
%         save( [ 'parcel', fname1( 5 : end - 6 ), '.mat' ], 'data_all', 'event_all' )
%         clear fname1 fname2 data event data_all event_all
% 
%         cd( 'MatGW' )
% 
%     catch
% 
% 
%     end
% 
% end; clear fn
% 
% clear flist1 flist2
% 
% cd( '..' )
% 

%% Calculate, parcel-wise signals (without GSR)
% 
% load( 'atlas_schaefer_200_fS.mat' )
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
%     tr_info = str2num( fname( end - 12 ) );
%     events = [];
%     if size( event, 1 ) > 1
%         ct = 0;
%         for tr = 1 : size( event, 1 ) - 1
%             if str2num( event{ tr + 1, 4 } ) < 0
%                 ct = ct + 1;
%                 events( 1, ct ) = str2num( event{ tr + 1, 1 } ) - 10 * 2.5;
%                 events( 2, ct ) = tr_info;
%             end
%         end; clear tr ct
% 
%         events( 1, : ) = round( events( 1, : ) / 2.5 );
%     end
%     event = events; clear events tr_info
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
%     data = nan(  size( atlas_fS, 1 ), sizeV( 4 ) );
%     for t = 1 : sizeV( 4 )
%         temp_V = V_p( :, :, :, t );
%         for k = 1 : size( atlas_fS, 1 )
%             data( k, t ) = mean( temp_V( atlas_fS{ k, 1 } ), 1, 'omitnan' );
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
% 
% for fn = 1 : size( flist1, 1 )
% 
%     try
% 
%         fname1 = flist1( fn, 1 ).name;
%         fname2 = flist2( fn, 1 ).name;
%         fname3 = flist3( fn, 1 ).name;
% 
%         data_all = {};
%         event_all = {};
% 
%         load( fname1 )
%         if isempty( event ), error( 'Empty event!' ), end
%         data_all{ 1, 1 } = data;
%         event_all{ 1, 1 } = event;
% 
%         load( fname2 )
%         if isempty( event ), error( 'Empty event!' ), end
%         data_all{ 1, 2 } = data;
%         event_all{ 1, 2 } = event;
% 
%         load( fname3 )
%         if isempty( event ), error( 'Empty event!' ), end
%         data_all{ 1, 3 } = data;
%         event_all{ 1, 3 } = event;
% 
%         cd( '..' )
% 
%         save( [ 'parcel', fname1( 5 : end - 6 ), '.mat' ], 'data_all', 'event_all' )
%         clear fname1 fname2 data event data_all event_all
% 
%         cd( 'MatGW' )
% 
%     catch
% 
% 
%     end
% 
% end; clear fn
% 
% clear flist1 flist2
% 
% cd( '..' )
% 

%% Missing Participants
% 
% load( 'P_info.mat' )
% 
% missingParticipant = zeros( size( P_info, 1 ), 1 );
% for p = 1 : size( P_info, 1 )
%     pn = P_info( p, 4 );
%     if pn < 10
%         flist = dir( [ 'parcel_GW_sub-0', num2str( pn ), '.mat' ] );
%     else
%         flist = dir( [ 'parcel_GW_sub-', num2str( pn ), '.mat' ] );
%     end
%     if size( flist, 1 ) == 0
%         missingParticipant( p, 1 ) = 1;
%     end
%     clear pn flist
% end; clear p
% 
% save( 'missingParticipant.mat', 'missingParticipant' )
% 

%% Make, Data for fMRI Schizophrenia
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
%     data = [ data_1st, data_2nd, data_3rd ];
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
%     save( [ 'Storage_fMRI_Schizophrenia_Data', fname( 10 : end ) ], ...
%         'event', 'data', ...
%         '-v7.3' )
% 
%     clear event data
%     clear nBins edges data_1st data_2nd data_3rd
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
