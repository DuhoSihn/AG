% Analysis_Associative_Generators
clear; close all; clc



%% Table 1
% 
% load( 'Comparion_Data_MDD_L1.mat' )
% dataset_name = 'LT';
% % load( 'Comparion_Data_SCZ_L1.mat' )
% % dataset_name = 'WMT';
% 
% exp_group = 1;
% 
% mm_acc_data = mean( mean( mm_acc_data( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% % AG
% mm_acc_act_G = mean( mean( mm_acc_act_G( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% mm_acc_rec_G = mean( mean( mm_acc_rec_G( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% % HSM
% mm_acc_HSM = mean( mean( mm_acc_HSM( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% % AG -> HSM
% mm_acc_HSM_G = mean( mean( mm_acc_data( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% mm_acc_HSM_recG = mean( mean( mm_acc_data( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% % HSM -> AG
% mm_acc_act_G_HSM = mean( mean( mm_acc_act_G_HSM( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% mm_acc_rec_G_HSM = mean( mean( mm_acc_rec_G_HSM( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% 
% disp( [ 'Dataset: ', dataset_name ] )
% disp( [ 'Data: ', num2str( mm_acc_data ) ] )
% disp( [ 'AG: ', num2str( mm_acc_act_G ) ] )
% % disp( [ 'AG rec.: ', num2str( mm_acc_rec_G ) ] )
% disp( [ 'HSM: ', num2str( mm_acc_HSM ) ] )
% disp( [ 'AG -> HSM: ', num2str( mm_acc_HSM_G ) ] )
% % disp( [ 'AG -> HSM rec.: ', num2str( mm_acc_HSM_recG ) ] )
% disp( [ 'HSM -> AG: ', num2str( mm_acc_act_G_HSM ) ] )
% % disp( [ 'HSM -> AG rec.: ', num2str( mm_acc_rec_G_HSM ) ] )
% 

%% Figure 2A
% 
% dname = 'RD_005_MDD_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data = squeeze( mean( mmm_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% LT_data = mean( m_mmm_acc_data, [ 1, 2 ], 'omitnan' );
% LT_G = mean( m_mmm_acc_act_G, [ 1 ], 'omitnan' );
% 
% % -------------------------------------------------------------------------
% 
% dname = 'RD_005_SCZ_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data = squeeze( mean( mmm_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% WMT_data = mean( m_mmm_acc_data, [ 1, 2 ], 'omitnan' );
% WMT_G = mean( m_mmm_acc_act_G, [ 1 ], 'omitnan' );
% 
% % -------------------------------------------------------------------------
% 
% colors = [ 1, 0, 0; 0, 0, 1 ];
% inc_LT = -0.1;
% inc_WMT = 0.1;
% 
% figure( 'position', [ 100, 100, 200, 200 ] )
% hold on
% plot( 0 + inc_LT, LT_data, 'ok', 'markerfacecolor', colors( 1, : ) )
% plot( 0 + inc_WMT, WMT_data, 'ok', 'markerfacecolor', colors( 2, : ) )
% plot( [ 1 : length( LT_G ) ], LT_G, '-ok', 'markerfacecolor', colors( 1, : ) )
% plot( [ 1 : length( WMT_G ) ], WMT_G, '-ok', 'markerfacecolor', colors( 2, : ) )
% plot( [ -1, 8 ] + 0.5, 0.5 * [ 1, 1 ], '--k' )
% set( gca, 'xlim', [ -1, 8 ] + 0.5, 'ylim', [ 0.45, 0.8] )
% set( gca, 'xtick', [ 0 : 8 ], 'xticklabel', { 'Data', '2 + 1', '4 + 1', '8 + 1', '16 + 1', '32 + 1', '64 + 1', '128 + 1', '256 + 1' } )
% legend( 'LT', 'WMT', 'location', 'southeast' )
% ylabel( 'Decoding accuracy' )
% xlabel( 'Length of generator' )
% 

%% Figure 2B
% 
% LG_LT = 4;
% LG_WMT = 7;
% LG_MT = 7;
% 
% dname = 'RD_005_MDD_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_mean_eval_G_F = squeeze( mean( mmm_mean_eval_G_F( :, exp_group, :, : ), 3, 'omitnan' ) );
% LT_mean_eval_G_F = m_mmm_mean_eval_G_F( 1 : end - 1, LG_LT );
% 
% % -------------------------------------------------------------------------
% 
% dname = 'RD_005_SCZ_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_mean_eval_G_F = squeeze( mean( mmm_mean_eval_G_F( :, exp_group, :, : ), 3, 'omitnan' ) );
% WMT_mean_eval_G_F = m_mmm_mean_eval_G_F( 1 : end - 1, LG_WMT );
% 
% % -------------------------------------------------------------------------
% 
% colors = [ 1, 0, 0; 0, 0, 1 ];
% line_width = 2;
% 
% figure( 'position', [ 100, 100, 200, 200 ] )
% hold on
% plot( [ 1 : length( LT_mean_eval_G_F ) ], LT_mean_eval_G_F, '-', 'color', colors( 1, : ), 'linewidth', line_width )
% plot( [ 1 : length( WMT_mean_eval_G_F ) ], WMT_mean_eval_G_F, '-', 'color', colors( 2, : ), 'linewidth', line_width )
% set( gca, 'xlim', [ 0, 32 ] + 0.5, 'ylim', [ 0.42, 0.57] )
% legend( 'LT', 'WMT', 'location', 'northeast' )
% ylabel( 'Difference between outputs' )
% xlabel( 'Optimization epoch' )
% 

%% Figure 2C and 2D
% 
% LG_LT = 4;
% LG_WMT = 7;
% LG_MT = 7;
% 
% dname = 'RD_005_MDD_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data = squeeze( mean( mmm_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G = squeeze( mean( mmm_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% m_mm0_acc_act_G = squeeze( mean( mm0_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_act_F = squeeze( mean( mm0_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_rec_G = squeeze( mean( mm0_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% LT_data = mean( m_mmm_acc_data( :, LG_LT ), 1, 'omitnan' );
% LT_F0 = mean( m_mm0_acc_act_F( :, LG_LT ), 1, 'omitnan' );
% LT_F = mean( m_mmm_acc_act_F( :, LG_LT ), 1, 'omitnan' );
% LT_G0 = mean( m_mm0_acc_act_G( :, LG_LT ), 1, 'omitnan' );
% LT_G = mean( m_mmm_acc_act_G( :, LG_LT ), 1, 'omitnan' );
% LT_recG0 = mean( m_mm0_acc_rec_G( :, LG_LT ), 1, 'omitnan' );
% LT_recG = mean( m_mmm_acc_rec_G( :, LG_LT ), 1, 'omitnan' );
% 
% % -------------------------------------------------------------------------
% 
% fname = [ 'Summary_Data_', dname, '_LOSO.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G = squeeze( mean( mmm_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% % -------------------------------------------------------------------------
% 
% LT_G_LOSO = mean( m_mmm_acc_act_G( :, LG_LT ), 1, 'omitnan' );
% LT_recG_LOSO = mean( m_mmm_acc_rec_G( :, LG_LT ), 1, 'omitnan' );
% 
% LT_all = [ LT_data, LT_F0, LT_F, LT_G0, LT_G, LT_recG0, LT_recG, LT_G_LOSO, LT_recG_LOSO ];
% 
% % -------------------------------------------------------------------------
% 
% dname = 'RD_005_SCZ_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data = squeeze( mean( mmm_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G = squeeze( mean( mmm_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% m_mm0_acc_act_G = squeeze( mean( mm0_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_act_F = squeeze( mean( mm0_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_rec_G = squeeze( mean( mm0_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% WMT_data = mean( m_mmm_acc_data( :, LG_WMT ), 1, 'omitnan' );
% WMT_F0 = mean( m_mm0_acc_act_F( :, LG_WMT ), 1, 'omitnan' );
% WMT_F = mean( m_mmm_acc_act_F( :, LG_WMT ), 1, 'omitnan' );
% WMT_G0 = mean( m_mm0_acc_act_G( :, LG_WMT ), 1, 'omitnan' );
% WMT_G = mean( m_mmm_acc_act_G( :, LG_WMT ), 1, 'omitnan' );
% WMT_recG0 = mean( m_mm0_acc_rec_G( :, LG_WMT ), 1, 'omitnan' );
% WMT_recG = mean( m_mmm_acc_rec_G( :, LG_WMT ), 1, 'omitnan' );
% 
% % -------------------------------------------------------------------------
% 
% fname = [ 'Summary_Data_', dname, '_LOSO.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G = squeeze( mean( mmm_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% % -------------------------------------------------------------------------
% 
% WMT_G_LOSO = mean( m_mmm_acc_act_G( :, LG_WMT ), 1, 'omitnan' );
% WMT_recG_LOSO = mean( m_mmm_acc_rec_G( :, LG_WMT ), 1, 'omitnan' );
% 
% WMT_all = [ WMT_data, WMT_F0, WMT_F, WMT_G0, WMT_G, WMT_recG0, WMT_recG, WMT_G_LOSO, WMT_recG_LOSO ];
% 
% % -------------------------------------------------------------------------
% 
% figure( 'position', [ 100, 100, 200, 200 ] )
% bar( LT_all, 'r' )
% hold on
% plot( [ 0, 9 ] + 0.5, 0.5 * [ 1, 1 ], '--k' )
% set( gca, 'xlim', [ 0, 9 ] + 0.5, 'ylim', [ 0.45, 0.8 ] )
% set( gca, 'xtick', [ 1 : 9 ], 'xticklabel', { 'Data', 'Init. Trans.', 'Trans.', 'Init. Gen.', 'Gen.', 'Init. Inv. Trans.', 'Inv. Trans.', 'Gen. LOSO', 'Inv. Trans. LOSO' } )
% ylabel( 'Decoding accuracy' )
% legend( 'LT', 'location', 'southeast' )
% 
% figure( 'position', [ 100, 100, 200, 200 ] )
% bar( WMT_all, 'b' )
% hold on
% plot( [ 0, 9 ] + 0.5, 0.5 * [ 1, 1 ], '--k' )
% set( gca, 'xlim', [ 0, 9 ] + 0.5, 'ylim', [ 0.45, 0.8 ] )
% set( gca, 'xtick', [ 1 : 9 ], 'xticklabel', { 'Data', 'Init. Trans.', 'Trans.', 'Init. Gen.', 'Gen.', 'Init. Inv. Trans.', 'Inv. Trans.', 'Gen. LOSO', 'Inv. Trans. LOSO' } )
% ylabel( 'Decoding accuracy' )
% legend( 'WMT', 'location', 'southeast' )
% 

%% Figure 2E, 2F
% 
% dname = 'RD_005_MDD_L1_RecG';
% % dname = 'RD_005_SCZ_L1_RecG';
% 
% load( [ 'Summary_Data_', dname, '_Event_Lock.mat' ] )
% 
% figure( 'position', [ 100, 100, 100, 200 ] )
% bar( corr_dB, 'r' )
% set( gca, 'xlim', 0.5 + [ 0, length( xtick_names ) ], 'ylim', [ -1, 1 ] )
% set( gca, 'xtick', [ 1 : length( xtick_names ) ], 'xticklabel', xtick_names )
% ylabel( 'Corr( Data; Inv. Trans )' )
% title( 'Dataset: LT' )
% 
% figure( 'position', [ 100, 100, 200, 200 ] )
% bar( transpose( act_dB ) )
% set( gca, 'xlim', 0.5 + [ 0, length( xtick_names ) ], 'ylim', [ 0, 25 ] )
% set( gca, 'xtick', [ 1 : length( xtick_names ) ], 'xticklabel', xtick_names )
% ylabel( 'Relative change (|dB|)' )
% legend( 'Data', 'Inv. Trans.', 'location', 'southeast' )
% title( 'Dataset: LT' )
% 
% % -------------------------------------------------------------------------
% 
% % dname = 'RD_005_MDD_L1_RecG';
% dname = 'RD_005_SCZ_L1_RecG';
% 
% load( [ 'Summary_Data_', dname, '_Event_Lock.mat' ] )
% 
% figure( 'position', [ 100, 100, 100, 200 ] )
% bar( corr_dB, 'b' )
% set( gca, 'xlim', 0.5 + [ 0, length( xtick_names ) ], 'ylim', [ -1, 1 ] )
% set( gca, 'xtick', [ 1 : length( xtick_names ) ], 'xticklabel', xtick_names )
% ylabel( 'Corr( Data; Inv. Trans )' )
% title( 'Dataset: WMT' )
% 
% figure( 'position', [ 100, 100, 200, 200 ] )
% bar( transpose( act_dB ) )
% set( gca, 'xlim', 0.5 + [ 0, length( xtick_names ) ], 'ylim', [ 0, 15 ] )
% set( gca, 'xtick', [ 1 : length( xtick_names ) ], 'xticklabel', xtick_names )
% ylabel( 'Relative change (|dB|)' )
% legend( 'Data', 'Inv. Trans.', 'location', 'southeast' )
% title( 'Dataset: WMT' )
% 

%% Figure 3B
% 
% dname = 'RD_005_PBWr_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data = squeeze( mean( mmm_acc_data1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% MT_data = mean( m_mmm_acc_data, [ 1, 2 ], 'omitnan' );
% MT_G = mean( m_mmm_acc_act_G, [ 1 ], 'omitnan' );
% 
% % -------------------------------------------------------------------------
% 
% colors = [ 1, 0, 1 ];
% 
% figure( 'position', [ 100, 100, 200, 200 ] )
% hold on
% plot( 0 + 0, MT_data, 'ok', 'markerfacecolor', colors( 1, : ) )
% plot( [ 1 : length( MT_G ) ], MT_G, '-ok', 'markerfacecolor', colors( 1, : ) )
% set( gca, 'xlim', [ -1, 7 ] + 0.5, 'ylim', [ 0.0, 0.6] )
% set( gca, 'xtick', [ 0 : 7 ], 'xticklabel', { 'Data', '2 + 1', '4 + 1', '8 + 1', '16 + 1', '32 + 1', '64 + 1', '128 + 1' } )
% legend( 'MT', 'location', 'southeast' )
% ylabel( 'Decoding R^2' )
% xlabel( 'Length of generator' )
% 

%% Figure 3C
% 
% LG_LT = 4;
% LG_WMT = 7;
% LG_MT = 7;
% 
% dname = 'RD_005_PBWr_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_mean_eval_G_F = squeeze( mean( mmm_mean_eval_G_F( :, exp_group, :, : ), 3, 'omitnan' ) );
% MT_mean_eval_G_F = m_mmm_mean_eval_G_F( 1 : end - 1, LG_MT );
% 
% % -------------------------------------------------------------------------
% 
% colors = [ 1, 0, 1 ];
% line_width = 2;
% 
% figure( 'position', [ 100, 100, 200, 200 ] )
% hold on
% plot( [ 1 : length( MT_mean_eval_G_F ) ], MT_mean_eval_G_F, '-', 'color', colors( 1, : ), 'linewidth', line_width )
% set( gca, 'xlim', [ 0, 16 ] + 0.5, 'ylim', [ 0.45, 0.85] )
% legend( 'MT', 'location', 'northeast' )
% ylabel( 'Difference between outputs' )
% xlabel( 'Optimization epoch' )
% 

%% Figure 3D
% 
% LG_LT = 4;
% LG_WMT = 7;
% LG_MT = 7;
% 
% dname = 'RD_005_PBWr_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data = squeeze( mean( mmm_acc_data1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G = squeeze( mean( mmm_acc_rec_G1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% m_mm0_acc_act_G = squeeze( mean( mm0_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_act_F = squeeze( mean( mm0_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_rec_G = squeeze( mean( mm0_acc_rec_G1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% MT_data = mean( m_mmm_acc_data( :, LG_MT ), 1, 'omitnan' );
% MT_F0 = mean( m_mm0_acc_act_F( :, LG_MT ), 1, 'omitnan' );
% MT_F = mean( m_mmm_acc_act_F( :, LG_MT ), 1, 'omitnan' );
% MT_G0 = mean( m_mm0_acc_act_G( :, LG_MT ), 1, 'omitnan' );
% MT_G = mean( m_mmm_acc_act_G( :, LG_MT ), 1, 'omitnan' );
% MT_recG0 = mean( m_mm0_acc_rec_G( :, LG_MT ), 1, 'omitnan' );
% MT_recG = mean( m_mmm_acc_rec_G( :, LG_MT ), 1, 'omitnan' );
% 
% % -------------------------------------------------------------------------
% 
% fname = [ 'Summary_Data_', dname, '_LOSO.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G = squeeze( mean( mmm_acc_rec_G1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% % -------------------------------------------------------------------------
% 
% MT_G_LOSO = mean( m_mmm_acc_act_G( :, LG_MT ), 1, 'omitnan' );
% MT_recG_LOSO = mean( m_mmm_acc_rec_G( :, LG_MT ), 1, 'omitnan' );
% 
% MT_all = [ MT_data, MT_F0, MT_F, MT_G0, MT_G, MT_recG0, MT_recG, MT_G_LOSO, MT_recG_LOSO ];
% 
% % -------------------------------------------------------------------------
% 
% figure( 'position', [ 100, 100, 200, 200 ] )
% bar( MT_all, 'm' )
% set( gca, 'xlim', [ 0, 9 ] + 0.5, 'ylim', [ 0.0, 0.6 ] )
% set( gca, 'xtick', [ 1 : 9 ], 'xticklabel', { 'Data', 'Init. Trans.', 'Trans.', 'Init. Gen.', 'Gen.', 'Init. Inv. Trans.', 'Inv. Trans.', 'Gen. LOSO', 'Inv. Trans. LOSO' } )
% ylabel( 'Decoding R^2' )
% legend( 'MT', 'location', 'southeast' )
% 

%% Figure 3E, 3F, 3G
% 
% dname = 'RD_005_PBWr_L1_RecG';
% 
% load( [ 'Summary_Data_', dname, '_Event_Lock.mat' ] )
% 
% figure( 'position', [ 100, 100, 100, 200 ] )
% bar( corr_dB, 'm' )
% set( gca, 'xlim', 0.5 + [ 0, length( xtick_names ) ], 'ylim', [ -1, 1 ] )
% set( gca, 'xtick', [ 1 : length( xtick_names ) ], 'xticklabel', xtick_names )
% ylabel( 'Corr( Data; Inv. Trans )' )
% title( 'Dataset: MT' )
% 
% figure( 'position', [ 100, 100, 200, 200 ] )
% bar( transpose( act_dB ) )
% set( gca, 'xlim', 0.5 + [ 0, length( xtick_names ) ], 'ylim', [ 0, 2 ] )
% set( gca, 'xtick', [ 1 : length( xtick_names ) ], 'xticklabel', xtick_names )
% ylabel( 'Relative change (|dB|)' )
% legend( 'Data', 'Inv. Trans.', 'location', 'southeast' )
% title( 'Dataset: MT' )
% 
% 
% load( 'chanloc.mat' )
% 
% chanloc2D = fliplr( chanloc2D );
% chanloc2D = chanloc2D - mean( chanloc2D, 1 );
% 
% elecloc = chanloc2D( 1 : 128, : );
% boundary = [ 0, 0, 1.2 ];
% resol = 300;
% NN = 5;
% marker_idx = true( 128, 1 );
% % marker_idx = false( 128, 1 );
% marker_size = 1;
% 
% clim = 0.3 * [ -1, 1 ];
% colors = turbo;
% 
% for nc = 1 : 2
%     figure( 'position', [ 100, 100, 100, 100 ] )
%     data = dB_xc_data( :, nc );
%     EEG_topo_magnitude( data, elecloc, boundary, resol, NN, marker_idx, marker_size, clim, colors );
% end; clear nc
% 
% for nc = 1 : 2
%     figure( 'position', [ 100, 100, 100, 100 ] )
%     data = dB_xc_rec_G( :, nc );
%     EEG_topo_magnitude( data, elecloc, boundary, resol, NN, marker_idx, marker_size, clim, colors );
% end; clear nc
% 
% figure( 'position', [ 100, 100, 200, 100 ] )
% imagesc( nan, clim ); colormap( colors ); colorbar
% 





























































%% ========================================================================
%% ========================================================================
%% ========================================================================
%% ========================================================================
%% ========================================================================
%% Analysis, MDD_L1
% 
% % dname = 'RD_MDD_L1';
% % dname = 'RD_01_MDD_L1';
% dname = 'RD_005_MDD_L1';
% % dname = 'RD_002_MDD_L1';
% % dname = 'RD_001_MDD_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data = squeeze( mean( mmm_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G = squeeze( mean( mmm_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_F = squeeze( mean( mmm_acc_rec_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_mean_eval_G_F = squeeze( mean( mmm_mean_eval_G_F( :, exp_group, :, : ), 3, 'omitnan' ) );
% 
% m_mm0_acc_data = squeeze( mean( mm0_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_act_G = squeeze( mean( mm0_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_act_F = squeeze( mean( mm0_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_rec_G = squeeze( mean( mm0_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_rec_F = squeeze( mean( mm0_acc_rec_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_mean_eval_G_F = squeeze( mean( mm0_mean_eval_G_F( :, exp_group, :, : ), 3, 'omitnan' ) );
% 
% y_lim = [ 0.45, 0.8 ];
% 
% figure
% subplot( 1, 5, 1 )
% bar( [ squeeze( m_mmm_acc_data ) ] )
% ylim( y_lim )
% title( [ 'data' ] )
% subplot( 1, 5, 2 )
% bar( [ squeeze( m_mmm_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 5, 3 )
% bar( [ squeeze( m_mmm_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 5, 4 )
% bar( [ squeeze( m_mmm_acc_rec_G ) ] )
% ylim( y_lim )
% title( [ 'rec_G' ] )
% subplot( 1, 5, 5 )
% bar( [ squeeze( m_mmm_acc_rec_F ) ] )
% ylim( y_lim )
% title( [ 'rec_F' ] )
% 
% figure
% subplot( 1, 5, 1 )
% bar( [ squeeze( m_mm0_acc_data ) ] )
% ylim( y_lim )
% title( [ 'data' ] )
% subplot( 1, 5, 2 )
% bar( [ squeeze( m_mm0_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 5, 3 )
% bar( [ squeeze( m_mm0_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 5, 4 )
% bar( [ squeeze( m_mm0_acc_rec_G ) ] )
% ylim( y_lim )
% title( [ 'rec_G' ] )
% subplot( 1, 5, 5 )
% bar( [ squeeze( m_mm0_acc_rec_F ) ] )
% ylim( y_lim )
% title( [ 'rec_F' ] )
% 
% figure
% bar( squeeze( m_mmm_mean_eval_G_F ) )
% colorbar
% 

%% Analysis, SCZ_L1
% 
% % dname = 'RD_SCZ_L1';
% % dname = 'RD_01_SCZ_L1';
% dname = 'RD_005_SCZ_L1';
% % dname = 'RD_002_SCZ_L1';
% % dname = 'RD_001_SCZ_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data = squeeze( mean( mmm_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G = squeeze( mean( mmm_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_F = squeeze( mean( mmm_acc_rec_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_mean_eval_G_F = squeeze( mean( mmm_mean_eval_G_F( :, exp_group, :, : ), 3, 'omitnan' ) );
% 
% m_mm0_acc_data = squeeze( mean( mm0_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_act_G = squeeze( mean( mm0_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_act_F = squeeze( mean( mm0_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_rec_G = squeeze( mean( mm0_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_rec_F = squeeze( mean( mm0_acc_rec_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_mean_eval_G_F = squeeze( mean( mm0_mean_eval_G_F( :, exp_group, :, : ), 3, 'omitnan' ) );
% 
% y_lim = [ 0.45, 0.8 ];
% 
% figure
% subplot( 1, 5, 1 )
% bar( [ squeeze( m_mmm_acc_data ) ] )
% ylim( y_lim )
% title( [ 'data' ] )
% subplot( 1, 5, 2 )
% bar( [ squeeze( m_mmm_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 5, 3 )
% bar( [ squeeze( m_mmm_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 5, 4 )
% bar( [ squeeze( m_mmm_acc_rec_G ) ] )
% ylim( y_lim )
% title( [ 'rec_G' ] )
% subplot( 1, 5, 5 )
% bar( [ squeeze( m_mmm_acc_rec_F ) ] )
% ylim( y_lim )
% title( [ 'rec_F' ] )
% 
% figure
% subplot( 1, 5, 1 )
% bar( [ squeeze( m_mm0_acc_data ) ] )
% ylim( y_lim )
% title( [ 'data' ] )
% subplot( 1, 5, 2 )
% bar( [ squeeze( m_mm0_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 5, 3 )
% bar( [ squeeze( m_mm0_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 5, 4 )
% bar( [ squeeze( m_mm0_acc_rec_G ) ] )
% ylim( y_lim )
% title( [ 'rec_G' ] )
% subplot( 1, 5, 5 )
% bar( [ squeeze( m_mm0_acc_rec_F ) ] )
% ylim( y_lim )
% title( [ 'rec_F' ] )
% 
% figure
% bar( squeeze( m_mmm_mean_eval_G_F ) )
% colorbar
% 

%% Analysis, PBWr_L1
% 
% % dname = 'RD_PBWr_L1';
% % dname = 'RD_01_PBWr_L1';
% dname = 'RD_005_PBWr_L1';
% % dname = 'RD_002_PBWr_L1';
% % dname = 'RD_001_PBWr_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data1 = squeeze( mean( mmm_acc_data1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_data2 = squeeze( mean( mmm_acc_data2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G1 = squeeze( mean( mmm_acc_rec_G1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G2 = squeeze( mean( mmm_acc_rec_G2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_F1 = squeeze( mean( mmm_acc_rec_F1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_F2 = squeeze( mean( mmm_acc_rec_F2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_mean_eval_G_F = squeeze( mean( mmm_mean_eval_G_F( :, exp_group, :, : ), 3, 'omitnan' ) );
% 
% m_mm0_acc_data1 = squeeze( mean( mm0_acc_data1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_data2 = squeeze( mean( mm0_acc_data2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_act_G = squeeze( mean( mm0_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_act_F = squeeze( mean( mm0_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_rec_G1 = squeeze( mean( mm0_acc_rec_G1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_rec_G2 = squeeze( mean( mm0_acc_rec_G2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_rec_F1 = squeeze( mean( mm0_acc_rec_F1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_acc_rec_F2 = squeeze( mean( mm0_acc_rec_F2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mm0_mean_eval_G_F = squeeze( mean( mm0_mean_eval_G_F( :, exp_group, :, : ), 3, 'omitnan' ) );
% 
% y_lim = [ 0.0, 1.0 ];
% 
% figure
% subplot( 1, 8, 1 )
% bar( [ squeeze( m_mmm_acc_data1 ) ] )
% ylim( y_lim )
% title( [ 'data1' ] )
% subplot( 1, 8, 2 )
% bar( [ squeeze( m_mmm_acc_data2 ) ] )
% ylim( y_lim )
% title( [ 'data2' ] )
% subplot( 1, 8, 3 )
% bar( [ squeeze( m_mmm_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 8, 4 )
% bar( [ squeeze( m_mmm_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 8, 5 )
% bar( [ squeeze( m_mmm_acc_rec_G1 ) ] )
% ylim( y_lim )
% title( [ 'rec_G1' ] )
% subplot( 1, 8, 6 )
% bar( [ squeeze( m_mmm_acc_rec_G2 ) ] )
% ylim( y_lim )
% title( [ 'rec_G2' ] )
% subplot( 1, 8, 7 )
% bar( [ squeeze( m_mmm_acc_rec_F1 ) ] )
% ylim( y_lim )
% title( [ 'rec_F1' ] )
% subplot( 1, 8, 8 )
% bar( [ squeeze( m_mmm_acc_rec_F2 ) ] )
% ylim( y_lim )
% title( [ 'rec_F2' ] )
% 
% figure
% subplot( 1, 8, 1 )
% bar( [ squeeze( m_mm0_acc_data1 ) ] )
% ylim( y_lim )
% title( [ 'data1' ] )
% subplot( 1, 8, 2 )
% bar( [ squeeze( m_mm0_acc_data2 ) ] )
% ylim( y_lim )
% title( [ 'data2' ] )
% subplot( 1, 8, 3 )
% bar( [ squeeze( m_mm0_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 8, 4 )
% bar( [ squeeze( m_mm0_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 8, 5 )
% bar( [ squeeze( m_mm0_acc_rec_G1 ) ] )
% ylim( y_lim )
% title( [ 'rec_G1' ] )
% subplot( 1, 8, 6 )
% bar( [ squeeze( m_mm0_acc_rec_G2 ) ] )
% ylim( y_lim )
% title( [ 'rec_G2' ] )
% subplot( 1, 8, 7 )
% bar( [ squeeze( m_mm0_acc_rec_F1 ) ] )
% ylim( y_lim )
% title( [ 'rec_F1' ] )
% subplot( 1, 8, 8 )
% bar( [ squeeze( m_mm0_acc_rec_F2 ) ] )
% ylim( y_lim )
% title( [ 'rec_F2' ] )
% 
% figure
% bar( squeeze( m_mmm_mean_eval_G_F ) )
% colorbar
% ylim( [ 0, 1 ] )
% 

%% Analysis, MDD_L1_LOSO
% 
% dname = 'RD_005_MDD_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data = squeeze( mean( mmm_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G = squeeze( mean( mmm_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_F = squeeze( mean( mmm_acc_rec_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% % -------------------------------------------------------------------------
% 
% dname = [ dname, '_LOSO' ];
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmL_acc_data = squeeze( mean( mmm_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_rec_G = squeeze( mean( mmm_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_rec_F = squeeze( mean( mmm_acc_rec_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% % -------------------------------------------------------------------------
% 
% y_lim = [ 0.45, 0.8 ];
% 
% figure
% subplot( 1, 5, 1 )
% bar( [ squeeze( m_mmm_acc_data ) ] )
% ylim( y_lim )
% title( [ 'data' ] )
% subplot( 1, 5, 2 )
% bar( [ squeeze( m_mmm_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 5, 3 )
% bar( [ squeeze( m_mmm_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 5, 4 )
% bar( [ squeeze( m_mmm_acc_rec_G ) ] )
% ylim( y_lim )
% title( [ 'rec_G' ] )
% subplot( 1, 5, 5 )
% bar( [ squeeze( m_mmm_acc_rec_F ) ] )
% ylim( y_lim )
% title( [ 'rec_F' ] )
% 
% figure
% subplot( 1, 5, 1 )
% bar( [ squeeze( m_mmL_acc_data ) ] )
% ylim( y_lim )
% title( [ 'data' ] )
% subplot( 1, 5, 2 )
% bar( [ squeeze( m_mmL_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 5, 3 )
% bar( [ squeeze( m_mmL_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 5, 4 )
% bar( [ squeeze( m_mmL_acc_rec_G ) ] )
% ylim( y_lim )
% title( [ 'rec_G' ] )
% subplot( 1, 5, 5 )
% bar( [ squeeze( m_mmL_acc_rec_F ) ] )
% ylim( y_lim )
% title( [ 'rec_F' ] )
% 

%% Analysis, SCZ_L1_LOSO
% 
% dname = 'RD_005_SCZ_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data = squeeze( mean( mmm_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G = squeeze( mean( mmm_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_F = squeeze( mean( mmm_acc_rec_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% % -------------------------------------------------------------------------
% 
% dname = [ dname, '_LOSO' ];
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmL_acc_data = squeeze( mean( mmm_acc_data( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_rec_G = squeeze( mean( mmm_acc_rec_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_rec_F = squeeze( mean( mmm_acc_rec_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% % -------------------------------------------------------------------------
% 
% y_lim = [ 0.45, 0.8 ];
% 
% figure
% subplot( 1, 5, 1 )
% bar( [ squeeze( m_mmm_acc_data ) ] )
% ylim( y_lim )
% title( [ 'data' ] )
% subplot( 1, 5, 2 )
% bar( [ squeeze( m_mmm_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 5, 3 )
% bar( [ squeeze( m_mmm_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 5, 4 )
% bar( [ squeeze( m_mmm_acc_rec_G ) ] )
% ylim( y_lim )
% title( [ 'rec_G' ] )
% subplot( 1, 5, 5 )
% bar( [ squeeze( m_mmm_acc_rec_F ) ] )
% ylim( y_lim )
% title( [ 'rec_F' ] )
% 
% figure
% subplot( 1, 5, 1 )
% bar( [ squeeze( m_mmL_acc_data ) ] )
% ylim( y_lim )
% title( [ 'data' ] )
% subplot( 1, 5, 2 )
% bar( [ squeeze( m_mmL_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 5, 3 )
% bar( [ squeeze( m_mmL_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 5, 4 )
% bar( [ squeeze( m_mmL_acc_rec_G ) ] )
% ylim( y_lim )
% title( [ 'rec_G' ] )
% subplot( 1, 5, 5 )
% bar( [ squeeze( m_mmL_acc_rec_F ) ] )
% ylim( y_lim )
% title( [ 'rec_F' ] )
% 

%% Analysis, PBWr_L1_LOSO
% 
% dname = 'RD_005_PBWr_L1';
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmm_acc_data1 = squeeze( mean( mmm_acc_data1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_data2 = squeeze( mean( mmm_acc_data2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G1 = squeeze( mean( mmm_acc_rec_G1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_G2 = squeeze( mean( mmm_acc_rec_G2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_F1 = squeeze( mean( mmm_acc_rec_F1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmm_acc_rec_F2 = squeeze( mean( mmm_acc_rec_F2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% % -------------------------------------------------------------------------
% 
% dname = [ dname, '_LOSO' ];
% 
% fname = [ 'Summary_Data_', dname, '.mat' ];
% 
% load( fname )
% 
% % -------------------------------------------------------------------------
% 
% exp_group = 1;
% 
% m_mmL_acc_data1 = squeeze( mean( mmm_acc_data1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_data2 = squeeze( mean( mmm_acc_data2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_act_G = squeeze( mean( mmm_acc_act_G( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_act_F = squeeze( mean( mmm_acc_act_F( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_rec_G1 = squeeze( mean( mmm_acc_rec_G1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_rec_G2 = squeeze( mean( mmm_acc_rec_G2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_rec_F1 = squeeze( mean( mmm_acc_rec_F1( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% m_mmL_acc_rec_F2 = squeeze( mean( mmm_acc_rec_F2( :, 1, exp_group, :, : ), 4, 'omitnan' ) );
% 
% % -------------------------------------------------------------------------
% 
% y_lim = [ 0.0, 1.0 ];
% 
% figure
% subplot( 1, 8, 1 )
% bar( [ squeeze( m_mmm_acc_data1 ) ] )
% ylim( y_lim )
% title( [ 'data1' ] )
% subplot( 1, 8, 2 )
% bar( [ squeeze( m_mmm_acc_data2 ) ] )
% ylim( y_lim )
% title( [ 'data2' ] )
% subplot( 1, 8, 3 )
% bar( [ squeeze( m_mmm_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 8, 4 )
% bar( [ squeeze( m_mmm_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 8, 5 )
% bar( [ squeeze( m_mmm_acc_rec_G1 ) ] )
% ylim( y_lim )
% title( [ 'rec_G1' ] )
% subplot( 1, 8, 6 )
% bar( [ squeeze( m_mmm_acc_rec_G2 ) ] )
% ylim( y_lim )
% title( [ 'rec_G2' ] )
% subplot( 1, 8, 7 )
% bar( [ squeeze( m_mmm_acc_rec_F1 ) ] )
% ylim( y_lim )
% title( [ 'rec_F1' ] )
% subplot( 1, 8, 8 )
% bar( [ squeeze( m_mmm_acc_rec_F2 ) ] )
% ylim( y_lim )
% title( [ 'rec_F2' ] )
% 
% figure
% subplot( 1, 8, 1 )
% bar( [ squeeze( m_mmL_acc_data1 ) ] )
% ylim( y_lim )
% title( [ 'data1' ] )
% subplot( 1, 8, 2 )
% bar( [ squeeze( m_mmL_acc_data2 ) ] )
% ylim( y_lim )
% title( [ 'data2' ] )
% subplot( 1, 8, 3 )
% bar( [ squeeze( m_mmL_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 8, 4 )
% bar( [ squeeze( m_mmL_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 8, 5 )
% bar( [ squeeze( m_mmL_acc_rec_G1 ) ] )
% ylim( y_lim )
% title( [ 'rec_G1' ] )
% subplot( 1, 8, 6 )
% bar( [ squeeze( m_mmL_acc_rec_G2 ) ] )
% ylim( y_lim )
% title( [ 'rec_G2' ] )
% subplot( 1, 8, 7 )
% bar( [ squeeze( m_mmL_acc_rec_F1 ) ] )
% ylim( y_lim )
% title( [ 'rec_F1' ] )
% subplot( 1, 8, 8 )
% bar( [ squeeze( m_mmL_acc_rec_F2 ) ] )
% ylim( y_lim )
% title( [ 'rec_F2' ] )
% 

%% Summary, Convergence for Conditions
% 
% % dname = 'RD_MDD_L1_RecG';
% % dname = 'RD_SCZ_L1_RecG';
% dname = 'RD_005_MDD_L1_RecG';
% % dname = 'RD_005_SCZ_L1_RecG';
% 
% load( [ 'Summary_Data_', dname, '_CC.mat' ] )
% 
% y_lim = [ 0.45, 0.55 ];
% 
% figure( 'position', [ 100, 100, 100, 200 ] )
% hold on
% bar( event_eval_G_F_1( 1, : ), 'c' )
% for beh = 1 : length( xtick_names )
%     errorbar( beh, event_eval_G_F_1( 1, beh ), event_eval_G_F_1( 3, beh ), 'k' )
% end; clear beh
% set( gca, 'xlim', 0.5 + [ 0, length( xtick_names ) ], 'ylim', y_lim )
% set( gca, 'xtick', [ 1 : length( xtick_names ) ], 'xticklabel', xtick_names )
% 
% figure( 'position', [ 100, 100, 100, 200 ] )
% hold on
% bar( event_eval_G_F_2( 1, : ), 'c' )
% for beh = 1 : length( xtick_names )
%     errorbar( beh, event_eval_G_F_2( 1, beh ), event_eval_G_F_2( 3, beh ), 'k' )
% end; clear beh
% set( gca, 'xlim', 0.5 + [ 0, length( xtick_names ) ], 'ylim', y_lim )
% set( gca, 'xtick', [ 1 : length( xtick_names ) ], 'xticklabel', xtick_names )
% 

%% Summary, Convergence for Conditions
% 
% % dname = 'RD_PBWr_L1_RecG';
% dname = 'RD_005_PBWr_L1_RecG';
% 
% load( [ 'Summary_Data_', dname, '_CC.mat' ] )
% 
% y_lim = [ 0.45, 0.55 ];
% 
% figure( 'position', [ 100, 100, 100, 200 ] )
% hold on
% bar( event_eval_G_F_1( 1, : ), 'c' )
% for beh = 1 : length( xtick_names )
%     errorbar( beh, event_eval_G_F_1( 1, beh ), event_eval_G_F_1( 3, beh ), 'k' )
% end; clear beh
% set( gca, 'xlim', 0.5 + [ 0, length( xtick_names ) ], 'ylim', y_lim )
% set( gca, 'xtick', [ 1 : length( xtick_names ) ], 'xticklabel', xtick_names )
% 

%% Summary, Event Locking
% 
% dname = 'RD_005_MDD_L1_RecG';
% % dname = 'RD_005_SCZ_L1_RecG';
% 
% load( [ 'Summary_Data_', dname, '_Event_Lock.mat' ] )
% 


%% Summary, Event Locking
% 
% dname = 'RD_005_PBWr_L1_RecG';
% 
% load( [ 'Summary_Data_', dname, '_Event_Lock.mat' ] )
% 
% 
% load( 'chanloc.mat' )
% 
% chanloc2D = fliplr( chanloc2D );
% chanloc2D = chanloc2D - mean( chanloc2D, 1 );
% 
% elecloc = chanloc2D( 1 : 128, : );
% boundary = [ 0, 0, 1.2 ];
% resol = 300;
% NN = 5;
% marker_idx = true( 128, 1 );
% % marker_idx = false( 128, 1 );
% marker_size = 1;
% 
% clim = 0.3 * [ -1, 1 ];
% colors = turbo;
% 
% figure( 'position', [ 100, 100, 600, 200 ] )
% for nc = 1 : 2
%     subplot( 1, 2, nc )
%     data = dB_xc_data( :, nc );
%     EEG_topo_magnitude( data, elecloc, boundary, resol, NN, marker_idx, marker_size, clim, colors );
% end; clear nc
% 
% figure( 'position', [ 100, 100, 600, 200 ] )
% for nc = 1 : 2
%     subplot( 1, 2, nc )
%     data = dB_xc_rec_G( :, nc );
%     EEG_topo_magnitude( data, elecloc, boundary, resol, NN, marker_idx, marker_size, clim, colors );
% end; clear nc
% 
% figure( 'position', [ 100, 100, 200, 100 ] )
% imagesc( nan, clim ); colormap( colors ); colorbar
% 

%% Summary, Principal Gradient
% 
% % dname = 'RD_PBWr_L1_RecG';
% dname = 'RD_005_PBWr_L1_RecG';
% 
% load( [ 'Summary_Data_', dname, '_PG.mat' ] )
% 
% embedding_rec_G( :, 2 ) = -embedding_rec_G( :, 2 );
% 
% load( 'chanloc.mat' )
% 
% chanloc2D = fliplr( chanloc2D );
% chanloc2D = chanloc2D - mean( chanloc2D, 1 );
% 
% elecloc = chanloc2D( 1 : 128, : );
% boundary = [ 0, 0, 1.2 ];
% resol = 300;
% NN = 5;
% % marker_idx = true( 128, 1 );
% marker_idx = false( 128, 1 );
% marker_size = 1;
% 
% clim = 15 * [ -1, 1 ];
% colors = turbo;
% 
% % figure( 'position', [ 100, 100, 1000, 200 ] )
% % for ng = 1 : 5
% %     subplot( 1, 5, ng )
% %     data = embedding_data( :, ng );
% %     EEG_topo_magnitude( data, elecloc, boundary, resol, NN, marker_idx, marker_size, clim, colors );
% % end; clear ng
% % 
% % figure( 'position', [ 100, 100, 1000, 200 ] )
% % for ng = 1 : 5
% %     subplot( 1, 5, ng )
% %     data = embedding_rec_G( :, ng );
% %     EEG_topo_magnitude( data, elecloc, boundary, resol, NN, marker_idx, marker_size, clim, colors );
% % end; clear ng
% 
% figure( 'position', [ 100, 100, 600, 200 ] )
% for ng = 1 : 3
%     subplot( 1, 3, ng )
%     data = embedding_data( :, ng );
%     EEG_topo_magnitude( data, elecloc, boundary, resol, NN, marker_idx, marker_size, clim, colors );
% end; clear ng
% 
% figure( 'position', [ 100, 100, 600, 200 ] )
% for ng = 1 : 3
%     subplot( 1, 3, ng )
%     data = embedding_rec_G( :, ng );
%     EEG_topo_magnitude( data, elecloc, boundary, resol, NN, marker_idx, marker_size, clim, colors );
% end; clear ng
% 
% figure( 'position', [ 100, 100, 200, 100 ] )
% imagesc( nan, clim ); colormap( colors ); colorbar
% 

%% Summary, Temporal Dynamics
% 
% % dname = 'RD_MDD_L1_RecG';
% dname = 'RD_005_MDD_L1_RecG';
% N_beh = 4;
% % % dname = 'RD_SCZ_L1_RecG';
% % dname = 'RD_005_SCZ_L1_RecG';
% % N_beh = 3;
% 
% load( [ 'Summary_Data_', dname, '.mat' ] )
% 
% dRF_data = {};
% dRF_rec_G = {};
% for k_c = 2 : 10
%     for fn = 1 : size( learning_assign_all, 1 )
%         k_data = idx_data{ k_c, fn };
%         k_rec_G = idx_rec_G{ k_c, fn };
%         c_data = histcounts( k_data, 0.5 + [ 0 : k_c ] ) ./ mean( histcounts( k_data, 0.5 + [ 0 : k_c ] ), 2, 'omitnan' );
%         c_rec_G = histcounts( k_rec_G, 0.5 + [ 0 : k_c ] ) ./ mean( histcounts( k_rec_G, 0.5 + [ 0 : k_c ] ), 2, 'omitnan' );
%         bc_data = [];
%         bc_rec_G = [];
%         ct_beh = 0;
%         for beh = 1 : N_beh
%             ct_beh = ct_beh + 1;
%             b_k_data = k_data( learning_assign_all{ fn, 1 } == beh );
%             b_k_rec_G = k_rec_G( learning_assign_all{ fn, 1 } == beh );
%             bc_data( ct_beh, : ) = histcounts( b_k_data, 0.5 + [ 0 : k_c ] ) ./ mean( histcounts( b_k_data, 0.5 + [ 0 : k_c ] ), 2, 'omitnan' );
%             bc_rec_G( ct_beh, : ) = histcounts( b_k_rec_G, 0.5 + [ 0 : k_c ] ) ./ mean( histcounts( b_k_rec_G, 0.5 + [ 0 : k_c ] ), 2, 'omitnan' );
%         end; clear beh ct_beh
%         dRF_data{ k_c, 1 }( :, :, fn ) = 20 * log10( bc_data ./ c_data );
%         dRF_rec_G{ k_c, 1 }( :, :, fn ) = 20 * log10( bc_rec_G ./ c_rec_G );
%     end; clear fn
% end; clear k_c
% 
% pVals_data = {};
% pVals_rec_G = {};
% for k_c = 2 : 10
%     t_data = dRF_data{ k_c, 1 }( :, :, P_info( :, 1 ) == 1 );
%     t_rec_G = dRF_rec_G{ k_c, 1 }( :, :, P_info( :, 1 ) == 1 );
%     for ct_beh = 1 : size( t_data, 1 )
%         for k = 1 : k_c
%             try
%                 pVals_data{ k_c, 1 }( ct_beh, k ) = signrank( squeeze( t_data( ct_beh, k, : ) ), 0, 'tail', 'both' );
%             catch
%                 pVals_data{ k_c, 1 }( ct_beh, k ) = nan;
%             end
%             try
%                 pVals_rec_G{ k_c, 1 }( ct_beh, k ) = signrank( squeeze( t_rec_G( ct_beh, k, : ) ), 0, 'tail', 'both' );
%             catch
%                 pVals_rec_G{ k_c, 1 }( ct_beh, k ) = nan;
%             end
%         end; clear k
%     end; clear ct_beh
%     qVals_data{ k_c, 1 } = reshape( mafdr( reshape( pVals_data{ k_c, 1 }, [ size( t_data, 1 ) * k_c, 1 ] ), 'BHFDR', 'True' ), [ size( t_data, 1 ), k_c ] );
%     qVals_rec_G{ k_c, 1 } = reshape( mafdr( reshape( pVals_rec_G{ k_c, 1 }, [ size( t_data, 1 ) * k_c, 1 ] ), 'BHFDR', 'True' ), [ size( t_data, 1 ), k_c ] );
% end; clear k_c
% 
% sigLevel = 0.05;
% sig_data = nan( 1, 10 );
% sig_rec_G = nan( 1, 10 );
% for k_c = 2 : 10
%     stat_data = qVals_data{ k_c, 1 }( : );
%     stat_rec_G = qVals_rec_G{ k_c, 1 }( : );
%     stat_data = stat_data( ~isnan( stat_data ) );
%     stat_rec_G = stat_rec_G( ~isnan( stat_rec_G ) );
%     sig_data( 1, k_c ) = mean( stat_data < sigLevel, 1, 'omitnan' );
%     sig_rec_G( 1, k_c ) = mean( stat_rec_G < sigLevel, 1, 'omitnan' );
% end; clear k_c
% 
% figure
% hold on
% plot( [ 1 : 10 ], sig_data, 'o' )
% plot( [ 1 : 10 ], sig_rec_G, '+' )
% 

%% Summary, Temporal Dynamics
% 
% % dname = 'RD_PBWr_L1_RecG';
% dname = 'RD_005_PBWr_L1_RecG';
% N_beh = 2;
% 
% load( [ 'Summary_Data_', dname, '.mat' ] )
% 
% dRF_data = {};
% dRF_rec_G = {};
% for k_c = 2 : 10
%     for fn = 1 : size( learning_assign_all, 1 )
%         k_data = idx_data{ k_c, fn };
%         k_rec_G = idx_rec_G{ k_c, fn };
%         c_data = histcounts( k_data, 0.5 + [ 0 : k_c ] ) ./ mean( histcounts( k_data, 0.5 + [ 0 : k_c ] ), 2, 'omitnan' );
%         c_rec_G = histcounts( k_rec_G, 0.5 + [ 0 : k_c ] ) ./ mean( histcounts( k_rec_G, 0.5 + [ 0 : k_c ] ), 2, 'omitnan' );
%         bc_data = [];
%         bc_rec_G = [];
%         ct_beh = 0;
%         for beh = 0 : N_beh%1 : N_beh
%             ct_beh = ct_beh + 1;
%             b_k_data = k_data( learning_assign_all{ fn, 1 } == beh );
%             b_k_rec_G = k_rec_G( learning_assign_all{ fn, 1 } == beh );
%             bc_data( ct_beh, : ) = histcounts( b_k_data, 0.5 + [ 0 : k_c ] ) ./ mean( histcounts( b_k_data, 0.5 + [ 0 : k_c ] ), 2, 'omitnan' );
%             bc_rec_G( ct_beh, : ) = histcounts( b_k_rec_G, 0.5 + [ 0 : k_c ] ) ./ mean( histcounts( b_k_rec_G, 0.5 + [ 0 : k_c ] ), 2, 'omitnan' );
%         end; clear beh ct_beh
%         dRF_data{ k_c, 1 }( :, :, fn ) = 20 * log10( bc_data ./ c_data );
%         dRF_rec_G{ k_c, 1 }( :, :, fn ) = 20 * log10( bc_rec_G ./ c_rec_G );
%     end; clear fn
% end; clear k_c
% 
% pVals_data = {};
% pVals_rec_G = {};
% for k_c = 2 : 10
%     t_data = dRF_data{ k_c, 1 }( :, :, : );
%     t_rec_G = dRF_rec_G{ k_c, 1 }( :, :, : );
%     for ct_beh = 1 : size( t_data, 1 )
%         for k = 1 : k_c
%             try
%                 pVals_data{ k_c, 1 }( ct_beh, k ) = signrank( squeeze( t_data( ct_beh, k, : ) ), 0, 'tail', 'both' );
%             catch
%                 pVals_data{ k_c, 1 }( ct_beh, k ) = nan;
%             end
%             try
%                 pVals_rec_G{ k_c, 1 }( ct_beh, k ) = signrank( squeeze( t_rec_G( ct_beh, k, : ) ), 0, 'tail', 'both' );
%             catch
%                 pVals_rec_G{ k_c, 1 }( ct_beh, k ) = nan;
%             end
%         end; clear k
%     end; clear ct_beh
%     qVals_data{ k_c, 1 } = reshape( mafdr( reshape( pVals_data{ k_c, 1 }, [ size( t_data, 1 ) * k_c, 1 ] ), 'BHFDR', 'True' ), [ size( t_data, 1 ), k_c ] );
%     qVals_rec_G{ k_c, 1 } = reshape( mafdr( reshape( pVals_rec_G{ k_c, 1 }, [ size( t_data, 1 ) * k_c, 1 ] ), 'BHFDR', 'True' ), [ size( t_data, 1 ), k_c ] );
% end; clear k_c
% 
% sigLevel = 0.05;
% sig_data = nan( 1, 10 );
% sig_rec_G = nan( 1, 10 );
% for k_c = 2 : 10
%     stat_data = qVals_data{ k_c, 1 }( : );
%     stat_rec_G = qVals_rec_G{ k_c, 1 }( : );
%     stat_data = stat_data( ~isnan( stat_data ) );
%     stat_rec_G = stat_rec_G( ~isnan( stat_rec_G ) );
%     sig_data( 1, k_c ) = mean( stat_data < sigLevel, 1, 'omitnan' );
%     sig_rec_G( 1, k_c ) = mean( stat_rec_G < sigLevel, 1, 'omitnan' );
% end; clear k_c
% 
% figure
% hold on
% plot( [ 1 : 10 ], sig_data, 'o' )
% plot( [ 1 : 10 ], sig_rec_G, '+' )
% 

%% Comparison
% 
% load( 'Comparion_Data_MDD_L1.mat' )
% % load( 'Comparion_Data_SCZ_L1.mat' )
% 
% exp_group = 1;
% 
% mm_acc_data = mean( mean( mm_acc_data( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% % AG
% mm_acc_act_G = mean( mean( mm_acc_act_G( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% mm_acc_rec_G = mean( mean( mm_acc_rec_G( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% % HSM
% mm_acc_HSM = mean( mean( mm_acc_HSM( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% % AG -> HSM
% mm_acc_HSM_G = mean( mean( mm_acc_data( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% mm_acc_HSM_recG = mean( mean( mm_acc_data( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% % HSM -> AG
% mm_acc_act_G_HSM = mean( mean( mm_acc_act_G_HSM( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% mm_acc_rec_G_HSM = mean( mean( mm_acc_rec_G_HSM( :, 1, exp_group, : ), 1, 'omitnan' ), 4, 'omitnan' );
% 
% disp( [ 'Data: ', num2str( mm_acc_data ) ] )
% disp( [ 'AG: ', num2str( mm_acc_act_G ) ] )
% disp( [ 'AG rec.: ', num2str( mm_acc_rec_G ) ] )
% disp( [ 'HSM: ', num2str( mm_acc_HSM ) ] )
% disp( [ 'AG -> HSM: ', num2str( mm_acc_HSM_G ) ] )
% disp( [ 'AG -> HSM rec.: ', num2str( mm_acc_HSM_recG ) ] )
% disp( [ 'HSM -> AG: ', num2str( mm_acc_act_G_HSM ) ] )
% disp( [ 'HSM -> AG rec.: ', num2str( mm_acc_rec_G_HSM ) ] )
% 
