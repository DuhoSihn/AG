% Summary_Data_Associative_Generators
clear; close all; clc



%% Summary, MDD_L1
% clear
% % dname = 'RD_MDD_L1';
% % dname = 'RD_01_MDD_L1';
% dname = 'RD_005_MDD_L1';
% % dname = 'RD_002_MDD_L1';
% % dname = 'RD_001_MDD_L1';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( 1 ), '_iterr', num2str( 1 ), '.mat' ] );
% 
% mm_acc_data = nan( 4, 1, 2, size( flist, 1 ), 6, 9 );
% mm_acc_act_G = nan( 4, 1, 2, size( flist, 1 ), 6, 9 );
% mm_acc_act_F = nan( 4, 1, 2, size( flist, 1 ), 6, 9 );
% mm_acc_rec_G = nan( 4, 1, 2, size( flist, 1 ), 6, 9 );
% mm_acc_rec_F = nan( 4, 1, 2, size( flist, 1 ), 6, 9 );
% mm_mean_eval_G_F = nan( 33, 2, size( flist, 1 ), 6, 9 );
% 
% mm0_acc_data = nan( 4, 1, 2, size( flist, 1 ), 6, 1 );
% mm0_acc_act_G = nan( 4, 1, 2, size( flist, 1 ), 6, 1 );
% mm0_acc_act_F = nan( 4, 1, 2, size( flist, 1 ), 6, 1 );
% mm0_acc_rec_G = nan( 4, 1, 2, size( flist, 1 ), 6, 1 );
% mm0_acc_rec_F = nan( 4, 1, 2, size( flist, 1 ), 6, 1 );
% mm0_mean_eval_G_F = nan( 33, 2, size( flist, 1 ), 6, 1 );
% 
% for k = 1 : 6
% 
%     iterr = 0;
% 
%     flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
%     ct_fn = [ 0, 0 ];
%     for fn = 1 : size( flist, 1 )
% 
%         fname = flist( fn, 1 ).name;
% 
%         load( fname )
% 
%         m_acc_data = [ mean( acc_data, 2 ) ];
%         m_acc_act_G = [];
%         m_acc_act_F = [];
%         for g = 1 : 1
%             m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%             m_acc_act_F( :, g ) = mean( acc_act_F{ 1, g }, 2 );
%         end; clear g
%         m_acc_rec_G = [ mean( acc_rec_G, 2 ) ];
%         m_acc_rec_F = [ mean( acc_rec_F, 2 ) ];
% 
%         g = P_info( fn, 1 );
%         ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%         mm0_acc_data( :, :, g, ct_fn( 1, g ), k, 1 ) = m_acc_data;
%         mm0_acc_act_G( :, :, g, ct_fn( 1, g ), k, 1 ) = m_acc_act_G;
%         mm0_acc_act_F( :, :, g, ct_fn( 1, g ), k, 1 ) = m_acc_act_F;
%         mm0_acc_rec_G( :, :, g, ct_fn( 1, g ), k, 1 ) = m_acc_rec_G;
%         mm0_acc_rec_F( :, :, g, ct_fn( 1, g ), k, 1 ) = m_acc_rec_F;
%         mm0_mean_eval_G_F( :, g, ct_fn( 1, g ), k, 1 ) = mean_eval_G_F;
% 
%     end; clear fn ct_fn
% 
%     clear iterr
% 
%     % ---------------------------------------------------------------------
% 
%     for iterr = 1 : 9
% 
%         flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
%         ct_fn = [ 0, 0 ];
%         for fn = 1 : size( flist, 1 )
% 
%             fname = flist( fn, 1 ).name;
% 
%             load( fname )
% 
%             m_acc_data = [ mean( acc_data, 2 ) ];
%             m_acc_act_G = [];
%             m_acc_act_F = [];
%             for g = 1 : 1
%                 m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%                 m_acc_act_F( :, g ) = mean( acc_act_F{ 1, g }, 2 );
%             end; clear g
%             m_acc_rec_G = [ mean( acc_rec_G, 2 ) ];
%             m_acc_rec_F = [ mean( acc_rec_F, 2 ) ];
% 
%             g = P_info( fn, 1 );
%             ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%             mm_acc_data( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_data;
%             mm_acc_act_G( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_act_G;
%             mm_acc_act_F( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_act_F;
%             mm_acc_rec_G( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_rec_G;
%             mm_acc_rec_F( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_rec_F;
%             mm_mean_eval_G_F( :, g, ct_fn( 1, g ), k, iterr ) = mean_eval_G_F;
% 
%         end; clear fn ct_fn
% 
%     end; clear iterr
% 
% end; clear k
% 
% mmm_acc_data = mean( mm_acc_data, 6, 'omitnan' );
% mmm_acc_act_G = mean( mm_acc_act_G, 6, 'omitnan' );
% mmm_acc_act_F = mean( mm_acc_act_F, 6, 'omitnan' );
% mmm_acc_rec_G = mean( mm_acc_rec_G, 6, 'omitnan' );
% mmm_acc_rec_F = mean( mm_acc_rec_F, 6, 'omitnan' );
% mmm_mean_eval_G_F = mean( mm_mean_eval_G_F, 5, 'omitnan' );
% 
% pVals_all = [];
% for k = 1 : 6
%     for beh = 1 : 4
%         pVals_all( beh, 1, k ) = ranksum( squeeze( mmm_acc_data( beh, 1, 1, :, k ) ), squeeze( mmm_acc_data( beh, 1, 2, :, k ) ), 'tail', 'both' );
%         pVals_all( beh, 2, k ) = ranksum( squeeze( mmm_acc_act_G( beh, 1, 1, :, k ) ), squeeze( mmm_acc_act_G( beh, 1, 2, :, k ) ), 'tail', 'both' );
%         pVals_all( beh, 3, k ) = ranksum( squeeze( mmm_acc_act_F( beh, 1, 1, :, k ) ), squeeze( mmm_acc_act_F( beh, 1, 2, :, k ) ), 'tail', 'both' );
%         pVals_all( beh, 4, k ) = ranksum( squeeze( mmm_acc_rec_G( beh, 1, 1, :, k ) ), squeeze( mmm_acc_rec_G( beh, 1, 2, :, k ) ), 'tail', 'both' );
%         pVals_all( beh, 5, k ) = ranksum( squeeze( mmm_acc_rec_F( beh, 1, 1, :, k ) ), squeeze( mmm_acc_rec_F( beh, 1, 2, :, k ) ), 'tail', 'both' );
%     end; clear beh
% end; clear k
% qVals_all = [];
% for k = 1 : 6
%     for m = 1 : 5
%         qVals_all( :, m, k ) = mafdr( pVals_all( :, m, k ), 'BHFDR', 'True' );
%     end; clear m
% end; clear k
% 
% cd( '..' )
% 
% save( [ 'Summary_Data_', dname, '.mat' ], ...
%     'mm_acc_data', 'mm_acc_act_G', 'mm_acc_act_F', 'mm_acc_rec_G', 'mm_acc_rec_F', 'mm_mean_eval_G_F', ...
%     'mmm_acc_data', 'mmm_acc_act_G', 'mmm_acc_act_F', 'mmm_acc_rec_G', 'mmm_acc_rec_F', 'mmm_mean_eval_G_F', ...
%     'mm0_acc_data', 'mm0_acc_act_G', 'mm0_acc_act_F', 'mm0_acc_rec_G', 'mm0_acc_rec_F', 'mm0_mean_eval_G_F', ...
%     'pVals_all', 'qVals_all', ...
%     'P_info' )
% 

%% Summary, SCZ_L1
% clear
% % dname = 'RD_SCZ_L1';
% % dname = 'RD_01_SCZ_L1';
% dname = 'RD_005_SCZ_L1';
% % dname = 'RD_002_SCZ_L1';
% % dname = 'RD_001_SCZ_L1';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% P_info = [ P_info( 1 : 9, : ); P_info( 86 : 88, : ); P_info( 10 : 85, : ) ];
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( 1 ), '_iterr', num2str( 1 ), '.mat' ] );
% 
% mm_acc_data = nan( 3, 1, 3, size( flist, 1 ), 8, 9 );
% mm_acc_act_G = nan( 3, 1, 3, size( flist, 1 ), 8, 9 );
% mm_acc_act_F = nan( 3, 1, 3, size( flist, 1 ), 8, 9 );
% mm_acc_rec_G = nan( 3, 1, 3, size( flist, 1 ), 8, 9 );
% mm_acc_rec_F = nan( 3, 1, 3, size( flist, 1 ), 8, 9 );
% mm_mean_eval_G_F = nan( 33, 3, size( flist, 1 ), 8, 9 );
% 
% mm0_acc_data = nan( 3, 1, 3, size( flist, 1 ), 8, 1 );
% mm0_acc_act_G = nan( 3, 1, 3, size( flist, 1 ), 8, 1 );
% mm0_acc_act_F = nan( 3, 1, 3, size( flist, 1 ), 8, 1 );
% mm0_acc_rec_G = nan( 3, 1, 3, size( flist, 1 ), 8, 1 );
% mm0_acc_rec_F = nan( 3, 1, 3, size( flist, 1 ), 8, 1 );
% mm0_mean_eval_G_F = nan( 33, 3, size( flist, 1 ), 8, 1 );
% 
% for k = 1 : 8
% 
%     iterr = 0;
% 
%     flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
%     ct_fn = [ 0, 0, 0 ];
%     for fn = 1 : size( flist, 1 )
% 
%         fname = flist( fn, 1 ).name;
% 
%         load( fname )
% 
%         m_acc_data = [ mean( acc_data, 2 ) ];
%         m_acc_act_G = [];
%         m_acc_act_F = [];
%         for g = 1 : 1
%             m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%             m_acc_act_F( :, g ) = mean( acc_act_F{ 1, g }, 2 );
%         end; clear g
%         m_acc_rec_G = [ mean( acc_rec_G, 2 ) ];
%         m_acc_rec_F = [ mean( acc_rec_F, 2 ) ];
% 
%         g = P_info( fn, 1 );
%         ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%         mm0_acc_data( :, :, g, ct_fn( 1, g ), k, 1 ) = m_acc_data;
%         mm0_acc_act_G( :, :, g, ct_fn( 1, g ), k, 1 ) = m_acc_act_G;
%         mm0_acc_act_F( :, :, g, ct_fn( 1, g ), k, 1 ) = m_acc_act_F;
%         mm0_acc_rec_G( :, :, g, ct_fn( 1, g ), k, 1 ) = m_acc_rec_G;
%         mm0_acc_rec_F( :, :, g, ct_fn( 1, g ), k, 1 ) = m_acc_rec_F;
%         mm0_mean_eval_G_F( :, g, ct_fn( 1, g ), k, 1 ) = mean_eval_G_F;
% 
%     end; clear fn ct_fn
% 
%     clear iterr
% 
%     % ---------------------------------------------------------------------
% 
%     for iterr = 1 : 9
% 
%         flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
%         ct_fn = [ 0, 0, 0 ];
%         for fn = 1 : size( flist, 1 )
% 
%             fname = flist( fn, 1 ).name;
% 
%             load( fname )
% 
%             m_acc_data = [ mean( acc_data, 2 ) ];
%             m_acc_act_G = [];
%             m_acc_act_F = [];
%             for g = 1 : 1
%                 m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%                 m_acc_act_F( :, g ) = mean( acc_act_F{ 1, g }, 2 );
%             end; clear g
%             m_acc_rec_G = [ mean( acc_rec_G, 2 ) ];
%             m_acc_rec_F = [ mean( acc_rec_F, 2 ) ];
% 
%             g = P_info( fn, 1 );
%             ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%             mm_acc_data( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_data;
%             mm_acc_act_G( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_act_G;
%             mm_acc_act_F( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_act_F;
%             mm_acc_rec_G( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_rec_G;
%             mm_acc_rec_F( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_rec_F;
%             mm_mean_eval_G_F( :, g, ct_fn( 1, g ), k, iterr ) = mean_eval_G_F;
% 
%         end; clear fn ct_fn
% 
%     end; clear iterr
% 
% end; clear k
% 
% mmm_acc_data = mean( mm_acc_data, 6, 'omitnan' );
% mmm_acc_act_G = mean( mm_acc_act_G, 6, 'omitnan' );
% mmm_acc_act_F = mean( mm_acc_act_F, 6, 'omitnan' );
% mmm_acc_rec_G = mean( mm_acc_rec_G, 6, 'omitnan' );
% mmm_acc_rec_F = mean( mm_acc_rec_F, 6, 'omitnan' );
% mmm_mean_eval_G_F = mean( mm_mean_eval_G_F, 5, 'omitnan' );
% 
% pVals_all = [];
% for k = 1 : 8
%     for beh = 1 : 3
%         pVals_all( beh, 1, k ) = ranksum( squeeze( mmm_acc_data( beh, 1, 1, :, k ) ), squeeze( mmm_acc_data( beh, 1, 2, :, k ) ), 'tail', 'both' );
%         pVals_all( beh, 2, k ) = ranksum( squeeze( mmm_acc_act_G( beh, 1, 1, :, k ) ), squeeze( mmm_acc_act_G( beh, 1, 2, :, k ) ), 'tail', 'both' );
%         pVals_all( beh, 3, k ) = ranksum( squeeze( mmm_acc_act_F( beh, 1, 1, :, k ) ), squeeze( mmm_acc_act_F( beh, 1, 2, :, k ) ), 'tail', 'both' );
%         pVals_all( beh, 4, k ) = ranksum( squeeze( mmm_acc_rec_G( beh, 1, 1, :, k ) ), squeeze( mmm_acc_rec_G( beh, 1, 2, :, k ) ), 'tail', 'both' );
%         pVals_all( beh, 5, k ) = ranksum( squeeze( mmm_acc_rec_F( beh, 1, 1, :, k ) ), squeeze( mmm_acc_rec_F( beh, 1, 2, :, k ) ), 'tail', 'both' );
%     end; clear beh
% end; clear k
% qVals_all = [];
% for k = 1 : 8
%     for m = 1 : 5
%         qVals_all( :, m, k ) = mafdr( pVals_all( :, m, k ), 'BHFDR', 'True' );
%     end; clear m
% end; clear k
% 
% cd( '..' )
% 
% save( [ 'Summary_Data_', dname, '.mat' ], ...
%     'mm_acc_data', 'mm_acc_act_G', 'mm_acc_act_F', 'mm_acc_rec_G', 'mm_acc_rec_F', 'mm_mean_eval_G_F', ...
%     'mmm_acc_data', 'mmm_acc_act_G', 'mmm_acc_act_F', 'mmm_acc_rec_G', 'mmm_acc_rec_F', 'mmm_mean_eval_G_F', ...
%     'mm0_acc_data', 'mm0_acc_act_G', 'mm0_acc_act_F', 'mm0_acc_rec_G', 'mm0_acc_rec_F', 'mm0_mean_eval_G_F', ...
%     'pVals_all', 'qVals_all', ...
%     'P_info' )
% 

%% Summary, PBWr_L1
% clear
% % dname = 'RD_PBWr_L1';
% % dname = 'RD_01_PBWr_L1';
% dname = 'RD_005_PBWr_L1';
% % dname = 'RD_002_PBWr_L1';
% % dname = 'RD_001_PBWr_L1';
% 
% cd( [ pwd, '\', dname ] )
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( 1 ), '_iterr', num2str( 1 ), '.mat' ] );
% 
% mm_acc_data1 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_data2 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_act_G = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_act_F = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_rec_G1 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_rec_G2 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_rec_F1 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_rec_F2 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_mean_eval_G_F = nan( 17, 1, size( flist, 1 ), 7, 9 );
% 
% mm0_acc_data1 = nan( 6, 1, 1, size( flist, 1 ), 7, 1 );
% mm0_acc_data2 = nan( 6, 1, 1, size( flist, 1 ), 7, 1 );
% mm0_acc_act_G = nan( 6, 1, 1, size( flist, 1 ), 7, 1 );
% mm0_acc_act_F = nan( 6, 1, 1, size( flist, 1 ), 7, 1 );
% mm0_acc_rec_G1 = nan( 6, 1, 1, size( flist, 1 ), 7, 1 );
% mm0_acc_rec_G2 = nan( 6, 1, 1, size( flist, 1 ), 7, 1 );
% mm0_acc_rec_F1 = nan( 6, 1, 1, size( flist, 1 ), 7, 1 );
% mm0_acc_rec_F2 = nan( 6, 1, 1, size( flist, 1 ), 7, 1 );
% mm0_mean_eval_G_F = nan( 17, 1, size( flist, 1 ), 7, 1 );
% 
% for k = 1 : 7
% 
%     iterr = 0;
% 
%     flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
%     for fn = 1 : size( flist, 1 )
% 
%         fname = flist( fn, 1 ).name;
% 
%         load( fname )
% 
%         m_acc_data1 = [ mean( acc_data1, 2 ) ];
%         m_acc_data2 = [ mean( acc_data2, 2 ) ];
%         m_acc_act_G = [];
%         m_acc_act_F = [];
%         for g = 1 : 1
%             m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%             m_acc_act_F( :, g ) = mean( acc_act_F{ 1, g }, 2 );
%         end; clear g
%         m_acc_rec_G1 = [ mean( acc_rec_G1, 2 ) ];
%         m_acc_rec_G2 = [ mean( acc_rec_G2, 2 ) ];
%         m_acc_rec_F1 = [ mean( acc_rec_F1, 2 ) ];
%         m_acc_rec_F2 = [ mean( acc_rec_F2, 2 ) ];
% 
%         mm0_acc_data1( :, :, 1, 1, k, 1 ) = m_acc_data1;
%         mm0_acc_data2( :, :, 1, 1, k, 1 ) = m_acc_data2;
%         mm0_acc_act_G( :, :, 1, 1, k, 1 ) = m_acc_act_G;
%         mm0_acc_act_F( :, :, 1, 1, k, 1 ) = m_acc_act_F;
%         mm0_acc_rec_G1( :, :, 1, 1, k, 1 ) = m_acc_rec_G1;
%         mm0_acc_rec_G2( :, :, 1, 1, k, 1 ) = m_acc_rec_G2;
%         mm0_acc_rec_F1( :, :, 1, 1, k, 1 ) = m_acc_rec_F1;
%         mm0_acc_rec_F2( :, :, 1, 1, k, 1 ) = m_acc_rec_F2;
%         mm0_mean_eval_G_F( :, 1, 1, k, 1 ) = mean_eval_G_F;
% 
%     end; clear fn
% 
%     clear iterr
% 
%     % ---------------------------------------------------------------------
% 
%     for iterr = 1 : 9
% 
%         flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
%         for fn = 1 : size( flist, 1 )
% 
%             fname = flist( fn, 1 ).name;
% 
%             load( fname )
% 
%             m_acc_data1 = [ mean( acc_data1, 2 ) ];
%             m_acc_data2 = [ mean( acc_data2, 2 ) ];
%             m_acc_act_G = [];
%             m_acc_act_F = [];
%             for g = 1 : 1
%                 m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%                 m_acc_act_F( :, g ) = mean( acc_act_F{ 1, g }, 2 );
%             end; clear g
%             m_acc_rec_G1 = [ mean( acc_rec_G1, 2 ) ];
%             m_acc_rec_G2 = [ mean( acc_rec_G2, 2 ) ];
%             m_acc_rec_F1 = [ mean( acc_rec_F1, 2 ) ];
%             m_acc_rec_F2 = [ mean( acc_rec_F2, 2 ) ];
% 
%             mm_acc_data1( :, :, 1, 1, k, iterr ) = m_acc_data1;
%             mm_acc_data2( :, :, 1, 1, k, iterr ) = m_acc_data2;
%             mm_acc_act_G( :, :, 1, 1, k, iterr ) = m_acc_act_G;
%             mm_acc_act_F( :, :, 1, 1, k, iterr ) = m_acc_act_F;
%             mm_acc_rec_G1( :, :, 1, 1, k, iterr ) = m_acc_rec_G1;
%             mm_acc_rec_G2( :, :, 1, 1, k, iterr ) = m_acc_rec_G2;
%             mm_acc_rec_F1( :, :, 1, 1, k, iterr ) = m_acc_rec_F1;
%             mm_acc_rec_F2( :, :, 1, 1, k, iterr ) = m_acc_rec_F2;
%             mm_mean_eval_G_F( :, 1, 1, k, iterr ) = mean_eval_G_F;
% 
%         end; clear fn
% 
%     end; clear iterr
% 
% end; clear k
% 
% mmm_acc_data1 = mean( mm_acc_data1, 6, 'omitnan' );
% mmm_acc_data2 = mean( mm_acc_data2, 6, 'omitnan' );
% mmm_acc_act_G = mean( mm_acc_act_G, 6, 'omitnan' );
% mmm_acc_act_F = mean( mm_acc_act_F, 6, 'omitnan' );
% mmm_acc_rec_G1 = mean( mm_acc_rec_G1, 6, 'omitnan' );
% mmm_acc_rec_G2 = mean( mm_acc_rec_G2, 6, 'omitnan' );
% mmm_acc_rec_F1 = mean( mm_acc_rec_F1, 6, 'omitnan' );
% mmm_acc_rec_F2 = mean( mm_acc_rec_F2, 6, 'omitnan' );
% mmm_mean_eval_G_F = mean( mm_mean_eval_G_F, 5, 'omitnan' );
% 
% cd( '..' )
% 
% save( [ 'Summary_Data_', dname, '.mat' ], ...
%     'mm_acc_data1', 'mm_acc_data2', 'mm_acc_act_G', 'mm_acc_act_F', 'mm_acc_rec_G1', 'mm_acc_rec_G2', 'mm_acc_rec_F1', 'mm_acc_rec_F2', 'mm_mean_eval_G_F', ...
%     'mmm_acc_data1', 'mmm_acc_data2', 'mmm_acc_act_G', 'mmm_acc_act_F', 'mmm_acc_rec_G1', 'mmm_acc_rec_G2', 'mmm_acc_rec_F1', 'mmm_acc_rec_F2', 'mmm_mean_eval_G_F', ...
%     'mm0_acc_data1', 'mm0_acc_data2', 'mm0_acc_act_G', 'mm0_acc_act_F', 'mm0_acc_rec_G1', 'mm0_acc_rec_G2', 'mm0_acc_rec_F1', 'mm0_acc_rec_F2', 'mm0_mean_eval_G_F' )
% 

%% Summary, MDD_L1_LOSO
% clear
% dname = 'RD_005_MDD_L1_LOSO';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( 1 ), '_iterr', num2str( 1 ), '.mat' ] );
% 
% mm_acc_data = nan( 4, 1, 2, size( flist, 1 ), 6, 9 );
% mm_acc_act_G = nan( 4, 1, 2, size( flist, 1 ), 6, 9 );
% mm_acc_act_F = nan( 4, 1, 2, size( flist, 1 ), 6, 9 );
% mm_acc_rec_G = nan( 4, 1, 2, size( flist, 1 ), 6, 9 );
% mm_acc_rec_F = nan( 4, 1, 2, size( flist, 1 ), 6, 9 );
% 
% for k = 1 : 6
% 
%     for iterr = 1 : 9
% 
%         flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
%         ct_fn = [ 0, 0 ];
%         for fn = 1 : size( flist, 1 )
% 
%             fname = flist( fn, 1 ).name;
% 
%             load( fname )
% 
%             m_acc_data = [ mean( acc_data, 2 ) ];
%             m_acc_act_G = [];
%             m_acc_act_F = [];
%             for g = 1 : 1
%                 m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%                 m_acc_act_F( :, g ) = mean( acc_act_F{ 1, g }, 2 );
%             end; clear g
%             m_acc_rec_G = [ mean( acc_rec_G, 2 ) ];
%             m_acc_rec_F = [ mean( acc_rec_F, 2 ) ];
% 
%             g = P_info( fn, 1 );
%             ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%             mm_acc_data( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_data;
%             mm_acc_act_G( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_act_G;
%             mm_acc_act_F( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_act_F;
%             mm_acc_rec_G( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_rec_G;
%             mm_acc_rec_F( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_rec_F;
% 
%         end; clear fn ct_fn
% 
%     end; clear iterr
% 
% end; clear k
% 
% mmm_acc_data = mean( mm_acc_data, 6, 'omitnan' );
% mmm_acc_act_G = mean( mm_acc_act_G, 6, 'omitnan' );
% mmm_acc_act_F = mean( mm_acc_act_F, 6, 'omitnan' );
% mmm_acc_rec_G = mean( mm_acc_rec_G, 6, 'omitnan' );
% mmm_acc_rec_F = mean( mm_acc_rec_F, 6, 'omitnan' );
% 
% cd( '..' )
% 
% save( [ 'Summary_Data_', dname, '.mat' ], ...
%     'mm_acc_data', 'mm_acc_act_G', 'mm_acc_act_F', 'mm_acc_rec_G', 'mm_acc_rec_F', ...
%     'mmm_acc_data', 'mmm_acc_act_G', 'mmm_acc_act_F', 'mmm_acc_rec_G', 'mmm_acc_rec_F', ...
%     'P_info' )
% 

%% Summary, SCZ_L1_LOSO
% clear
% dname = 'RD_005_SCZ_L1_LOSO';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% P_info = [ P_info( 1 : 9, : ); P_info( 86 : 88, : ); P_info( 10 : 85, : ) ];
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( 1 ), '_iterr', num2str( 1 ), '.mat' ] );
% 
% mm_acc_data = nan( 3, 1, 3, size( flist, 1 ), 8, 9 );
% mm_acc_act_G = nan( 3, 1, 3, size( flist, 1 ), 8, 9 );
% mm_acc_act_F = nan( 3, 1, 3, size( flist, 1 ), 8, 9 );
% mm_acc_rec_G = nan( 3, 1, 3, size( flist, 1 ), 8, 9 );
% mm_acc_rec_F = nan( 3, 1, 3, size( flist, 1 ), 8, 9 );
% 
% for k = 1 : 8
% 
%     for iterr = 1 : 9
% 
%         flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
%         ct_fn = [ 0, 0, 0 ];
%         for fn = 1 : size( flist, 1 )
% 
%             fname = flist( fn, 1 ).name;
% 
%             load( fname )
% 
%             m_acc_data = [ mean( acc_data, 2 ) ];
%             m_acc_act_G = [];
%             m_acc_act_F = [];
%             for g = 1 : 1
%                 m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%                 m_acc_act_F( :, g ) = mean( acc_act_F{ 1, g }, 2 );
%             end; clear g
%             m_acc_rec_G = [ mean( acc_rec_G, 2 ) ];
%             m_acc_rec_F = [ mean( acc_rec_F, 2 ) ];
% 
%             g = P_info( fn, 1 );
%             ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%             mm_acc_data( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_data;
%             mm_acc_act_G( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_act_G;
%             mm_acc_act_F( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_act_F;
%             mm_acc_rec_G( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_rec_G;
%             mm_acc_rec_F( :, :, g, ct_fn( 1, g ), k, iterr ) = m_acc_rec_F;
% 
%         end; clear fn ct_fn
% 
%     end; clear iterr
% 
% end; clear k
% 
% mmm_acc_data = mean( mm_acc_data, 6, 'omitnan' );
% mmm_acc_act_G = mean( mm_acc_act_G, 6, 'omitnan' );
% mmm_acc_act_F = mean( mm_acc_act_F, 6, 'omitnan' );
% mmm_acc_rec_G = mean( mm_acc_rec_G, 6, 'omitnan' );
% mmm_acc_rec_F = mean( mm_acc_rec_F, 6, 'omitnan' );
% 
% cd( '..' )
% 
% save( [ 'Summary_Data_', dname, '.mat' ], ...
%     'mm_acc_data', 'mm_acc_act_G', 'mm_acc_act_F', 'mm_acc_rec_G', 'mm_acc_rec_F', ...
%     'mmm_acc_data', 'mmm_acc_act_G', 'mmm_acc_act_F', 'mmm_acc_rec_G', 'mmm_acc_rec_F', ...
%     'P_info' )
% 

%% Summary, PBWr_L1_LOSO
% clear
% dname = 'RD_005_PBWr_L1_LOSO';
% 
% cd( [ pwd, '\', dname ] )
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( 1 ), '_iterr', num2str( 1 ), '.mat' ] );
% 
% mm_acc_data1 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_data2 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_act_G = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_act_F = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_rec_G1 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_rec_G2 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_rec_F1 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% mm_acc_rec_F2 = nan( 6, 1, 1, size( flist, 1 ), 7, 9 );
% 
% for k = 1 : 7
% 
%     for iterr = 1 : 9
% 
%         flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
%         for fn = 1 : size( flist, 1 )
% 
%             fname = flist( fn, 1 ).name;
% 
%             load( fname )
% 
%             m_acc_data1 = [ mean( acc_data1, 2 ) ];
%             m_acc_data2 = [ mean( acc_data2, 2 ) ];
%             m_acc_act_G = [];
%             m_acc_act_F = [];
%             for g = 1 : 1
%                 m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%                 m_acc_act_F( :, g ) = mean( acc_act_F{ 1, g }, 2 );
%             end; clear g
%             m_acc_rec_G1 = [ mean( acc_rec_G1, 2 ) ];
%             m_acc_rec_G2 = [ mean( acc_rec_G2, 2 ) ];
%             m_acc_rec_F1 = [ mean( acc_rec_F1, 2 ) ];
%             m_acc_rec_F2 = [ mean( acc_rec_F2, 2 ) ];
% 
%             mm_acc_data1( :, :, 1, 1, k, iterr ) = m_acc_data1;
%             mm_acc_data2( :, :, 1, 1, k, iterr ) = m_acc_data2;
%             mm_acc_act_G( :, :, 1, 1, k, iterr ) = m_acc_act_G;
%             mm_acc_act_F( :, :, 1, 1, k, iterr ) = m_acc_act_F;
%             mm_acc_rec_G1( :, :, 1, 1, k, iterr ) = m_acc_rec_G1;
%             mm_acc_rec_G2( :, :, 1, 1, k, iterr ) = m_acc_rec_G2;
%             mm_acc_rec_F1( :, :, 1, 1, k, iterr ) = m_acc_rec_F1;
%             mm_acc_rec_F2( :, :, 1, 1, k, iterr ) = m_acc_rec_F2;
% 
%         end; clear fn
% 
%     end; clear iterr
% 
% end; clear k
% 
% mmm_acc_data1 = mean( mm_acc_data1, 6, 'omitnan' );
% mmm_acc_data2 = mean( mm_acc_data2, 6, 'omitnan' );
% mmm_acc_act_G = mean( mm_acc_act_G, 6, 'omitnan' );
% mmm_acc_act_F = mean( mm_acc_act_F, 6, 'omitnan' );
% mmm_acc_rec_G1 = mean( mm_acc_rec_G1, 6, 'omitnan' );
% mmm_acc_rec_G2 = mean( mm_acc_rec_G2, 6, 'omitnan' );
% mmm_acc_rec_F1 = mean( mm_acc_rec_F1, 6, 'omitnan' );
% mmm_acc_rec_F2 = mean( mm_acc_rec_F2, 6, 'omitnan' );
% 
% cd( '..' )
% 
% save( [ 'Summary_Data_', dname, '.mat' ], ...
%     'mm_acc_data1', 'mm_acc_data2', 'mm_acc_act_G', 'mm_acc_act_F', 'mm_acc_rec_G1', 'mm_acc_rec_G2', 'mm_acc_rec_F1', 'mm_acc_rec_F2', ...
%     'mmm_acc_data1', 'mmm_acc_data2', 'mmm_acc_act_G', 'mmm_acc_act_F', 'mmm_acc_rec_G1', 'mmm_acc_rec_G2', 'mmm_acc_rec_F1', 'mmm_acc_rec_F2' )
% 

%% Summary, MDD_L1_RecG
% clear
% % dname = 'RD_MDD_L1_RecG';
% dname = 'RD_005_MDD_L1_RecG';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( 4 ), '_iterr', num2str( 1 ), '.mat' ] );
% 
% event_eval_G_F = [];
% eval_G_F_all = {};
% learning_assign_all = {};
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     eval_G_F = [];
%     for g = 1 : 1
%         eval_G_F( g, : ) = sqrt( mean( ( act_G{ 1, g } - act_F{ 1, g } ) .^ 2, 1 ) );
%     end; clear g
%     learning_assign = [ learning_assign, zeros( 1, length( eval_G_F ) - length( learning_assign ) ) ];
% 
%     ct_beh = 0;
%     for beh = 0 : 4
%         ct_beh = ct_beh + 1;
%         event_eval_G_F( fn, ct_beh ) = mean( eval_G_F( learning_assign == beh ), 2, 'omitnan' );
%     end; clear beh ct_beh
% 
%     eval_G_F_all{ fn, 1 } = eval_G_F;
%     learning_assign_all{ fn, 1 } = learning_assign;
% 
% end; clear fn
% 
% event_lock_data = [];
% event_lock_rec_G = [];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     ct_beh = 0;
%     for beh = 0 : 4
%         ct_beh = ct_beh + 1;
%         event_lock_data( :, ct_beh, fn )  = mean( data{ 1, 1 }( :, learning_assign == beh ), 2, 'omitnan' );
%         event_lock_rec_G( :, ct_beh, fn )  = mean( rec_G{ 1, 1 }( :, learning_assign == beh ), 2, 'omitnan' );
%     end; clear beh ct_beh
% 
% end; clear fn
% 
% data_all = [];
% rec_G_all = [];
% cumlen_data = [];
% ct = 0;
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     data_all = [ data_all, data{ 1, 1 } ];
%     rec_G_all = [ rec_G_all, rec_G{ 1, 1 } ];
% 
%     cumlen_data( fn, 1 : 2 ) = ct + [ 1, size( data{ 1, 1 }, 2 ) ];
%     ct = ct + size( data{ 1, 1 }, 2 );
% 
% end; clear fn ct
% 
% idx_data_all = {};
% C_data = {};
% idx_rec_G_all = {};
% C_rec_G = {};
% for k = 2 : 10
%     [ idx_data_all{ k, 1 }, C_data{ k, 1 } ] = kmeans( transpose( data_all ), k, 'MaxIter', 10000 );
%     [ idx_rec_G_all{ k, 1 }, C_rec_G{ k, 1 } ] = kmeans( transpose( rec_G_all ), k, 'MaxIter', 10000 );
% end; clear k
% 
% idx_data = {};
% idx_rec_G = {};
% for k = 2 : 10
%     for fn = 1 : size( flist, 1 )
%         idx_data{ k, fn } = idx_data_all{ k, 1 }( cumlen_data( fn, 1 ) : cumlen_data( fn, 2 ) );
%         idx_rec_G{ k, fn } = idx_rec_G_all{ k, 1 }( cumlen_data( fn, 1 ) : cumlen_data( fn, 2 ) );
%     end; clear fn
% end; clear k
% 
% corr_data = [];
% corr_rec_G = [];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     t_corr_data = nan( 200, 200 );
%     t_corr_rec_G = nan( 200, 200 );
%     for ch1 = 1 : 199
%         for ch2 = ch1 + 1 : 200
%             t_corr_data( ch1, ch2 ) = corr( transpose( data{ 1, 1 }( ch1, : ) ), transpose( data{ 1, 1 }( ch2, : ) ), 'row', 'complete' );
%             t_corr_rec_G( ch1, ch2 ) = corr( transpose( rec_G{ 1, 1 }( ch1, : ) ), transpose( rec_G{ 1, 1 }( ch2, : ) ), 'row', 'complete' );
%             t_corr_data( ch2, ch1 ) = t_corr_data( ch1, ch2 );
%             t_corr_rec_G( ch2, ch1 ) = t_corr_rec_G( ch1, ch2 );
%         end; clear ch2
%     end; clear ch1
%     corr_data( :, :, fn ) = t_corr_data;
%     corr_rec_G( :, :, fn ) = t_corr_rec_G;
% 
% end; clear fn ct
% 
% cd( '..' )
% 
% save( [ 'Summary_Data_', dname, '.mat' ], ...
%     'eval_G_F_all', 'learning_assign_all', 'event_eval_G_F', ...
%     'event_lock_data', 'event_lock_rec_G', ...
%     'C_data', 'C_rec_G', 'idx_data', 'idx_rec_G', 'idx_data_all', 'idx_rec_G_all', ...
%     'corr_data', 'corr_rec_G', ...
%     'P_info' )
% 

%% Summary, SCZ_L1_RecG
% clear
% % dname = 'RD_SCZ_L1_RecG';
% dname = 'RD_005_SCZ_L1_RecG';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% P_info = [ P_info( 1 : 9, : ); P_info( 86 : 88, : ); P_info( 10 : 85, : ) ];
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( 7 ), '_iterr', num2str( 1 ), '.mat' ] );
% 
% event_eval_G_F = [];
% eval_G_F_all = {};
% learning_assign_all = {};
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     eval_G_F = [];
%     for g = 1 : 1
%         eval_G_F( g, : ) = sqrt( mean( ( act_G{ 1, g } - act_F{ 1, g } ) .^ 2, 1 ) );
%     end; clear g
%     learning_assign = [ learning_assign, zeros( 1, length( eval_G_F ) - length( learning_assign ) ) ];
% 
%     ct_beh = 0;
%     for beh = 0 : 3
%         ct_beh = ct_beh + 1;
%         event_eval_G_F( fn, ct_beh ) = mean( eval_G_F( learning_assign == beh ), 2, 'omitnan' );
%     end; clear beh ct_beh
% 
%     eval_G_F_all{ fn, 1 } = eval_G_F;
%     learning_assign_all{ fn, 1 } = learning_assign;
% 
% end; clear fn
% 
% event_lock_data = [];
% event_lock_rec_G = [];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     ct_beh = 0;
%     for beh = 0 : 3
%         ct_beh = ct_beh + 1;
%         event_lock_data( :, ct_beh, fn )  = mean( data{ 1, 1 }( :, learning_assign == beh ), 2, 'omitnan' );
%         event_lock_rec_G( :, ct_beh, fn )  = mean( rec_G{ 1, 1 }( :, learning_assign == beh ), 2, 'omitnan' );
%     end; clear beh ct_beh
% 
% end; clear fn
% 
% data_all = [];
% rec_G_all = [];
% cumlen_data = [];
% ct = 0;
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     data_all = [ data_all, data{ 1, 1 } ];
%     rec_G_all = [ rec_G_all, rec_G{ 1, 1 } ];
% 
%     cumlen_data( fn, 1 : 2 ) = ct + [ 1, size( data{ 1, 1 }, 2 ) ];
%     ct = ct + size( data{ 1, 1 }, 2 );
% 
% end; clear fn ct
% 
% idx_data_all = {};
% C_data = {};
% idx_rec_G_all = {};
% C_rec_G = {};
% for k = 2 : 10
%     [ idx_data_all{ k, 1 }, C_data{ k, 1 } ] = kmeans( transpose( data_all ), k, 'MaxIter', 10000 );
%     [ idx_rec_G_all{ k, 1 }, C_rec_G{ k, 1 } ] = kmeans( transpose( rec_G_all ), k, 'MaxIter', 10000 );
% end; clear k
% 
% idx_data = {};
% idx_rec_G = {};
% for k = 2 : 10
%     for fn = 1 : size( flist, 1 )
%         idx_data{ k, fn } = idx_data_all{ k, 1 }( cumlen_data( fn, 1 ) : cumlen_data( fn, 2 ) );
%         idx_rec_G{ k, fn } = idx_rec_G_all{ k, 1 }( cumlen_data( fn, 1 ) : cumlen_data( fn, 2 ) );
%     end; clear fn
% end; clear k
% 
% corr_data = [];
% corr_rec_G = [];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     t_corr_data = nan( 200, 200 );
%     t_corr_rec_G = nan( 200, 200 );
%     for ch1 = 1 : 199
%         for ch2 = ch1 + 1 : 200
%             t_corr_data( ch1, ch2 ) = corr( transpose( data{ 1, 1 }( ch1, : ) ), transpose( data{ 1, 1 }( ch2, : ) ), 'row', 'complete' );
%             t_corr_rec_G( ch1, ch2 ) = corr( transpose( rec_G{ 1, 1 }( ch1, : ) ), transpose( rec_G{ 1, 1 }( ch2, : ) ), 'row', 'complete' );
%             t_corr_data( ch2, ch1 ) = t_corr_data( ch1, ch2 );
%             t_corr_rec_G( ch2, ch1 ) = t_corr_rec_G( ch1, ch2 );
%         end; clear ch2
%     end; clear ch1
%     corr_data( :, :, fn ) = t_corr_data;
%     corr_rec_G( :, :, fn ) = t_corr_rec_G;
% 
% end; clear fn ct
% 
% cd( '..' )
% 
% save( [ 'Summary_Data_', dname, '.mat' ], ...
%     'eval_G_F_all', 'learning_assign_all', 'event_eval_G_F', ...
%     'event_lock_data', 'event_lock_rec_G', ...
%     'C_data', 'C_rec_G', 'idx_data', 'idx_rec_G', 'idx_data_all', 'idx_rec_G_all', ...
%     'corr_data', 'corr_rec_G', ...
%     'P_info' )
% 

%% Summary, Functional Networks
% clear
% % dname = 'RD_MDD_L1_RecG';
% % dname = 'RD_SCZ_L1_RecG';
% % dname = 'RD_005_MDD_L1_RecG';
% dname = 'RD_005_SCZ_L1_RecG';
% 
% load( [ 'Summary_Data_', dname, '.mat' ] )
% 
% m_corr_data = mean( corr_data( :, :, P_info( :, 1 ) == 1 ), 3, 'omitnan' );
% m_corr_rec_G = mean( corr_rec_G( :, :, P_info( :, 1 ) == 1 ), 3, 'omitnan' );
% 
% % m_corr_data( isnan( m_corr_data ) ) = 0;
% % m_corr_rec_G( isnan( m_corr_rec_G ) ) = 0;
% 
% m_corr_data( isnan( m_corr_data ) ) = 1;
% m_corr_rec_G( isnan( m_corr_rec_G ) ) = 1;
% 
% % m_corr_data( m_corr_data < 0 ) = 0;
% % m_corr_rec_G( m_corr_rec_G < 0 ) = 0;
% 
% m_corr_data = ( m_corr_data + 1 ) / 2;
% m_corr_rec_G = ( m_corr_rec_G + 1 ) / 2;
% 
% idx_m_corr_data = spectralcluster( m_corr_data, 7, 'Distance', 'precomputed' );
% idx_m_corr_rec_G = spectralcluster( m_corr_rec_G, 7, 'Distance', 'precomputed' );
% 
% idx_m_corr_atlas = importdata( 'schaefer200x7CommunityAffiliation.1D' );
% 
% idx_m_corr_data_amount = [];
% idx_m_corr_rec_G_amount = [];
% for k = 1 : 7
%     idx_m_corr_data_amount( 1, k ) = sum( idx_m_corr_data == k, 1, 'omitnan' );
%     idx_m_corr_rec_G_amount( 1, k ) = sum( idx_m_corr_rec_G == k, 1, 'omitnan' );
% end; clear k
% 
% idxss_data = nan( 1, 7 );
% idxss_rec_G = nan( 1, 7 );
% for k = 1 : 7
%     idxs_data = idx_m_corr_data( idx_m_corr_atlas == k );
%     idxs_rec_G = idx_m_corr_rec_G( idx_m_corr_atlas == k );
%     for kk = 1 : 7
%         idxs_data( idxs_data == idxss_data( 1, kk ) ) = nan;
%         idxs_rec_G( idxs_rec_G == idxss_rec_G( 1, kk ) ) = nan;
%     end; clear kk
%     idxs_data_amount = [];
%     idxs_rec_G_amount = [];
%     for kk = 1 : 7
%         idxs_data_amount( 1, kk ) = sum( idxs_data == kk, 1, 'omitnan' );
%         idxs_rec_G_amount( 1, kk ) = sum( idxs_rec_G == kk, 1, 'omitnan' );
%     end; clear kk
%     ratio_data = idxs_data_amount ./ idx_m_corr_data_amount;
%     ratio_rec_G = idxs_rec_G_amount ./ idx_m_corr_rec_G_amount;
%     [ ~, idxss_data( 1, k ) ] = max( ratio_data );
%     [ ~, idxss_rec_G( 1, k ) ] = max( ratio_rec_G );
% end; clear k
% 
% idx_m_corr_data_corrected = nan( 200, 1 );
% idx_m_corr_rec_G_corrected = nan( 200, 1 );
% for k = 1 : 7
%     idx_m_corr_data_corrected( idx_m_corr_data == idxss_data( 1, k ), 1 ) = k;
%     idx_m_corr_rec_G_corrected( idx_m_corr_rec_G == idxss_rec_G( 1, k ), 1 ) = k;
% end; clear k
% 
% similarityScore = [];
% similarityScore( 1, 1 ) = mean( idx_m_corr_atlas == idx_m_corr_data_corrected, 1, 'omitnan' );
% similarityScore( 2, 1 ) = mean( idx_m_corr_atlas == idx_m_corr_rec_G_corrected, 1, 'omitnan' );
% similarityScore( 3, 1 ) = mean( idx_m_corr_data_corrected == idx_m_corr_rec_G_corrected, 1, 'omitnan' );
% 
% save( [ 'Summary_Data_', dname, '_FN.mat' ], ...
%     'idx_m_corr_atlas', 'idx_m_corr_data_corrected', 'idx_m_corr_rec_G_corrected', 'similarityScore' )
% 

%% Figure, Summary, Functional Networks
% clear
% % dname = 'RD_MDD_L1_RecG';
% % dname = 'RD_SCZ_L1_RecG';
% % dname = 'RD_005_MDD_L1_RecG';
% dname = 'RD_005_SCZ_L1_RecG';
% 
% load( [ 'Summary_Data_', dname, '_FN.mat' ] )
% 
% info_200 = niftiinfo( 'schaefer200MNI.nii.gz' );
% atlas_200 = niftiread( info_200 );
% 
% vals = idx_m_corr_atlas;
% vals_200 = nan( size( atlas_200 ) );
% for r = 1 : 200
%     if ~isnan( vals( r ) )
%         r_idx = atlas_200 == r;
%         % r_idx = r_idx( : );
%         vals_200( r_idx ) = vals( r );
%     end
% end; clear r
% vals_200 = single( vals_200 );
% niftiwrite( vals_200, [ 'Figure_Summary_Data_', dname, '_FN_atlas.nii' ], info_200, 'Compressed', true )
% 
% vals = idx_m_corr_data_corrected;
% vals_200 = nan( size( atlas_200 ) );
% for r = 1 : 200
%     if ~isnan( vals( r ) )
%         r_idx = atlas_200 == r;
%         % r_idx = r_idx( : );
%         vals_200( r_idx ) = vals( r );
%     end
% end; clear r
% vals_200 = single( vals_200 );
% niftiwrite( vals_200, [ 'Figure_Summary_Data_', dname, '_FN_data.nii' ], info_200, 'Compressed', true )
% 
% vals = idx_m_corr_rec_G_corrected;
% vals_200 = nan( size( atlas_200 ) );
% for r = 1 : 200
%     if ~isnan( vals( r ) )
%         r_idx = atlas_200 == r;
%         % r_idx = r_idx( : );
%         vals_200( r_idx ) = vals( r );
%     end
% end; clear r
% vals_200 = single( vals_200 );
% niftiwrite( vals_200, [ 'Figure_Summary_Data_', dname, '_FN_rec_G.nii' ], info_200, 'Compressed', true )
% 

%% Summary, Convergence for Conditions
% clear
% % % dname = 'RD_MDD_L1_RecG';
% % dname = 'RD_005_MDD_L1_RecG';
% % xtick_names = { 'None', 'Pos. Music', 'Neg. Music', 'Pos. Non-music', 'Neg. Non-music' };
% % dname = 'RD_SCZ_L1_RecG';
% dname = 'RD_005_SCZ_L1_RecG';
% xtick_names = { 'None', '1-back', '2-back', '3-back' };
% 
% load( [ 'Summary_Data_', dname, '.mat' ] )
% 
% event_eval_G_F_1 = [];
% event_eval_G_F_2 = [];
% event_eval_G_F_1( 1, : ) = mean( event_eval_G_F( P_info( :, 1 ) == 1, : ), 1, 'omitnan' );
% event_eval_G_F_2( 1, : ) = mean( event_eval_G_F( P_info( :, 1 ) == 2, : ), 1, 'omitnan' );
% event_eval_G_F_1( 2, : ) = std( event_eval_G_F( P_info( :, 1 ) == 1, : ), 0, 1, 'omitnan' );
% event_eval_G_F_2( 2, : ) = std( event_eval_G_F( P_info( :, 1 ) == 2, : ), 0, 1, 'omitnan' );
% event_eval_G_F_1( 3, : ) = event_eval_G_F_1( 2, : ) ./ sqrt( sum( P_info( :, 1 ) == 1 ) );
% event_eval_G_F_2( 3, : ) = event_eval_G_F_2( 2, : ) ./ sqrt( sum( P_info( :, 1 ) == 2 ) );
% 
% save( [ 'Summary_Data_', dname, '_CC.mat' ], ...
%     'xtick_names', 'event_eval_G_F_1', 'event_eval_G_F_2' )
% 

%% Summary, PBWr_L1_RecG
% clear
% % dname = 'RD_PBWr_L1_RecG';
% dname = 'RD_005_PBWr_L1_RecG';
% 
% cd( [ pwd, '\', dname ] )
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( 7 ), '_iterr', num2str( 1 ), '.mat' ] );
% 
% learning_assign_all = {};
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     eval_G_F = [];
%     for g = 1 : 1
%         eval_G_F( g, : ) = sqrt( mean( ( act_G{ 1, g } - act_F{ 1, g } ) .^ 2, 1 ) );
%     end; clear g
%     learning_assign = [ learning_assign, zeros( 1, length( eval_G_F ) - length( learning_assign ) ) ];
% 
%     learning_assign( isnan( learning_assign( :, 1 ) ), : ) = 10.5 / 20;
%     
%     learning_assign_all{ fn, 1 } = learning_assign;
% 
% end; clear fn
% 
% [ coeff, score ] = pca( transpose( cell2mat( transpose( learning_assign_all ) ) ) );
% all_learning_assign = transpose( score( :, 1 ) );
% edges = SD_getEdges( all_learning_assign, 3 );
% states = SD_getStates( all_learning_assign, edges );
% all_learning_assign( states == 1 ) = 1;
% all_learning_assign( states == 2 ) = 0;
% all_learning_assign( states == 3 ) = 2;
% 
% event_eval_G_F = [];
% eval_G_F_all = {};
% % learning_assign_all = {};
% ct_fn = 0;
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     eval_G_F = [];
%     for g = 1 : 1
%         eval_G_F( g, : ) = sqrt( mean( ( act_G{ 1, g } - act_F{ 1, g } ) .^ 2, 1 ) );
%     end; clear g
%     % learning_assign = [ learning_assign, zeros( 1, length( eval_G_F ) - length( learning_assign ) ) ];
% 
%     learning_assign = all_learning_assign( 1, ct_fn + [ 1 : length( learning_assign_all{ fn, 1 } ) ] );
%     ct_fn = ct_fn + length( learning_assign_all{ fn, 1 } );
% 
%     ct_beh = 0;
%     for beh = 0 : 2
%         ct_beh = ct_beh + 1;
%         event_eval_G_F( fn, ct_beh ) = mean( eval_G_F( learning_assign == beh ), 2, 'omitnan' );
%     end; clear beh ct_beh
% 
%     eval_G_F_all{ fn, 1 } = eval_G_F;
%     learning_assign_all{ fn, 1 } = learning_assign;
% 
% end; clear fn ct_fn
% 
% event_lock_data = [];
% event_lock_rec_G = [];
% ct_fn = 0;
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     learning_assign = all_learning_assign( 1, ct_fn + [ 1 : length( learning_assign_all{ fn, 1 } ) ] );
%     ct_fn = ct_fn + length( learning_assign_all{ fn, 1 } );
% 
%     ct_beh = 0;
%     for beh = 0 : 2
%         ct_beh = ct_beh + 1;
%         event_lock_data( :, ct_beh, fn )  = mean( data{ 1, 1 }( :, learning_assign == beh ), 2, 'omitnan' );
%         event_lock_rec_G( :, ct_beh, fn )  = mean( rec_G{ 1, 1 }( :, learning_assign == beh ), 2, 'omitnan' );
%     end; clear beh ct_beh
% 
% end; clear fn ct_fn
% 
% data_all = [];
% rec_G_all = [];
% cumlen_data = [];
% ct = 0;
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     data_all = [ data_all, data{ 1, 1 } ];
%     rec_G_all = [ rec_G_all, rec_G{ 1, 1 } ];
% 
%     cumlen_data( fn, 1 : 2 ) = ct + [ 1, size( data{ 1, 1 }, 2 ) ];
%     ct = ct + size( data{ 1, 1 }, 2 );
% 
% end; clear fn ct
% 
% idx_data_all = {};
% C_data = {};
% idx_rec_G_all = {};
% C_rec_G = {};
% for k = 2 : 10
%     [ idx_data_all{ k, 1 }, C_data{ k, 1 } ] = kmeans( transpose( data_all ), k, 'MaxIter', 10000 );
%     [ idx_rec_G_all{ k, 1 }, C_rec_G{ k, 1 } ] = kmeans( transpose( rec_G_all ), k, 'MaxIter', 10000 );
% end; clear k
% 
% idx_data = {};
% idx_rec_G = {};
% for k = 2 : 10
%     for fn = 1 : size( flist, 1 )
%         idx_data{ k, fn } = idx_data_all{ k, 1 }( cumlen_data( fn, 1 ) : cumlen_data( fn, 2 ) );
%         idx_rec_G{ k, fn } = idx_rec_G_all{ k, 1 }( cumlen_data( fn, 1 ) : cumlen_data( fn, 2 ) );
%     end; clear fn
% end; clear k
% 
% corr_data = [];
% corr_rec_G = [];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     t_corr_data = nan( 128, 128 );
%     t_corr_rec_G = nan( 128, 128 );
%     for ch1 = 1 : 127
%         for ch2 = ch1 + 1 : 128
%             t_corr_data( ch1, ch2 ) = corr( transpose( data{ 1, 1 }( ch1, : ) ), transpose( data{ 1, 1 }( ch2, : ) ), 'row', 'complete' );
%             t_corr_rec_G( ch1, ch2 ) = corr( transpose( rec_G{ 1, 1 }( ch1, : ) ), transpose( rec_G{ 1, 1 }( ch2, : ) ), 'row', 'complete' );
%             t_corr_data( ch2, ch1 ) = t_corr_data( ch1, ch2 );
%             t_corr_rec_G( ch2, ch1 ) = t_corr_rec_G( ch1, ch2 );
%         end; clear ch2
%     end; clear ch1
%     corr_data( :, :, fn ) = t_corr_data;
%     corr_rec_G( :, :, fn ) = t_corr_rec_G;
% 
% end; clear fn ct
% 
% cd( '..' )
% 
% save( [ 'Summary_Data_', dname, '.mat' ], ...
%     'eval_G_F_all', 'learning_assign_all', 'event_eval_G_F', ...
%     'event_lock_data', 'event_lock_rec_G', ...
%     'C_data', 'C_rec_G', 'idx_data', 'idx_rec_G', 'idx_data_all', 'idx_rec_G_all', ...
%     'corr_data', 'corr_rec_G' )
% 

%% Summary, Principal Gradient
% clear
% % dname = 'RD_PBWr_L1_RecG';
% dname = 'RD_005_PBWr_L1_RecG';
% 
% load( [ 'Summary_Data_', dname, '.mat' ] )
% 
% conn_Data = corr_data;
% conn_Data = atanh( conn_Data );
% conn_Mat = mean( conn_Data, 3, 'omitnan' );
% conn_Mat = tanh( conn_Mat );
% conn_Mat( isnan( conn_Mat ) ) = 0;
% for ch = 1 : 128
%     temp_conn = conn_Mat( ch, : );
%     temp_conn = sort( temp_conn, 2, 'descend' );
%     temp_conn = temp_conn( 12 );
%     conn_Mat( ch, conn_Mat( ch, : ) < temp_conn ) = 0;
%     conn_Mat( ch, conn_Mat( ch, : ) < 0 ) = 0;
%     clear temp_conn
% end; clear ch
% conn_L = zeros( size( conn_Mat ) );
% for ch1 = 1 : 128
%     for ch2 = 1 : 128
%         if ch1 ~= ch2
%             conn_L( ch1, ch2 ) = 1 - pdist2( conn_Mat( ch1, : ), conn_Mat( ch2, : ), 'cosine' );
%         end
%     end; clear ch2
% end; clear ch1
% conn_Mat = conn_L; clear conn_L
% [ embedding, scaled_eigval ] = diffusion_mapping( conn_Mat, 5, 0.5, 0 );
% embedding = real( embedding );
% embedding_data = embedding;
% scaled_eigval_data = scaled_eigval;
% clear conn_Data conn_Mat embedding scaled_eigval
% 
% conn_Data = corr_rec_G;
% conn_Data = atanh( conn_Data );
% conn_Mat = mean( conn_Data, 3, 'omitnan' );
% conn_Mat = tanh( conn_Mat );
% conn_Mat( isnan( conn_Mat ) ) = 0;
% for ch = 1 : 128
%     temp_conn = conn_Mat( ch, : );
%     temp_conn = sort( temp_conn, 2, 'descend' );
%     temp_conn = temp_conn( 12 );
%     conn_Mat( ch, conn_Mat( ch, : ) < temp_conn ) = 0;
%     conn_Mat( ch, conn_Mat( ch, : ) < 0 ) = 0;
%     clear temp_conn
% end; clear ch
% conn_L = zeros( size( conn_Mat ) );
% for ch1 = 1 : 128
%     for ch2 = 1 : 128
%         if ch1 ~= ch2
%             conn_L( ch1, ch2 ) = 1 - pdist2( conn_Mat( ch1, : ), conn_Mat( ch2, : ), 'cosine' );
%         end
%     end; clear ch2
% end; clear ch1
% conn_Mat = conn_L; clear conn_L
% [ embedding, scaled_eigval ] = diffusion_mapping( conn_Mat, 5, 0.5, 0 );
% embedding = real( embedding );
% embedding_rec_G = embedding;
% scaled_eigval_rec_G = scaled_eigval;
% clear conn_Data conn_Mat embedding scaled_eigval
% 
% save( [ 'Summary_Data_', dname, '_PG.mat' ], ...
%     'embedding_data', 'scaled_eigval_data', 'embedding_rec_G', 'scaled_eigval_rec_G' )
% 

%% Summary, Convergence for Conditions
% clear
% % dname = 'RD_PBWr_L1_RecG';
% dname = 'RD_005_PBWr_L1_RecG';
% xtick_names = { 'Neutral', 'State 1', 'State2' };
% 
% load( [ 'Summary_Data_', dname, '.mat' ] )
% 
% event_eval_G_F_1 = [];
% event_eval_G_F_1( 1, : ) = mean( event_eval_G_F( :, : ), 1, 'omitnan' );
% event_eval_G_F_1( 2, : ) = std( event_eval_G_F( :, : ), 0, 1, 'omitnan' );
% event_eval_G_F_1( 3, : ) = event_eval_G_F_1( 2, : ) ./ sqrt( size( event_eval_G_F, 1 ) );
% 
% save( [ 'Summary_Data_', dname, '_CC.mat' ], ...
%     'xtick_names', 'event_eval_G_F_1' )
% 

%% Summary, Event Locking
% clear
% dname = 'RD_005_MDD_L1_RecG';
% xtick_names = { 'Pos. Music', 'Neg. Music', 'Pos. Non-music', 'Neg. Non-music' };
% % dname = 'RD_005_SCZ_L1_RecG';
% % xtick_names = { '1-back', '2-back', '3-back' };
% 
% load( [ 'Summary_Data_', dname, '.mat' ] )
% 
% m_event_lock_data = mean( event_lock_data( :, :, P_info( :, 1 ) == 1 ), 3, 'omitnan' );
% m_event_lock_rec_G = mean( event_lock_rec_G( :, :, P_info( :, 1 ) == 1 ), 3, 'omitnan' );
% 
% dB_xc_data = 20 * log10( m_event_lock_data( :, 2 : end ) ./ m_event_lock_data( :, 1 ) );
% dB_xc_rec_G = 20 * log10( m_event_lock_rec_G( :, 2 : end ) ./ m_event_lock_rec_G( :, 1 ) );
% 
% corr_dB = [];
% for beh = 1 : size( dB_xc_data, 2 )
%     corr_dB( 1, beh ) = corr( dB_xc_data( :, beh ), dB_xc_rec_G( :, beh ), 'rows', 'complete' );
% end; clear beh
% 
% act_dB = [];
% for beh = 1 : size( dB_xc_data, 2 )
%     act_dB( 1, beh ) = sqrt( sum( ( dB_xc_data( :, beh ) .^ 2 ), 1, 'omitnan' ) );
%     act_dB( 2, beh ) = sqrt( sum( ( dB_xc_rec_G( :, beh ) .^ 2 ), 1, 'omitnan' ) );
% end; clear beh
% 
% save( [ 'Summary_Data_', dname, '_Event_Lock.mat' ], ...
%     'xtick_names', 'dB_xc_data', 'dB_xc_rec_G', 'corr_dB', 'act_dB' )
% 
% pVals_xc_data = [];
% pVals_xc_rec_G = [];
% qVals_xc_data = [];
% qVals_xc_rec_G = [];
% for beh = 1 : size( event_lock_data, 2 ) - 1
%     for ch = 1 : 200
%         pVals_xc_data( ch, beh ) = signrank( squeeze( event_lock_data( ch, 1, P_info( :, 1 ) == 1 ) ), squeeze( event_lock_data( ch, beh + 1, P_info( :, 1 ) == 1 ) ), 'tail', 'both' );
%         pVals_xc_rec_G( ch, beh ) = signrank( squeeze( event_lock_rec_G( ch, 1, P_info( :, 1 ) == 1 ) ), squeeze( event_lock_rec_G( ch, beh + 1, P_info( :, 1 ) == 1 ) ), 'tail', 'both' );
%     end; clear ch
%     qVals_xc_data( :, beh ) = mafdr( pVals_xc_data( :, beh ), 'BHFDR', 'True' );
%     qVals_xc_rec_G( :, beh ) = mafdr( pVals_xc_rec_G( :, beh ), 'BHFDR', 'True' );
% end; clear beh
% 
% dB_xc_data( qVals_xc_data >= 0.05 ) = nan;
% dB_xc_rec_G( qVals_xc_rec_G >= 0.05 ) = nan;
% 
% info_200 = niftiinfo( 'schaefer200MNI.nii.gz' );
% atlas_200 = niftiread( info_200 );
% 
% for beh = 1 : size( dB_xc_data, 2 )
%     vals = dB_xc_data( :, beh );
%     vals_200 = nan( size( atlas_200 ) );
%     for r = 1 : 200
%         if ~isnan( vals( r ) )
%             r_idx = atlas_200 == r;
%             % r_idx = r_idx( : );
%             vals_200( r_idx ) = vals( r );
%         end
%     end; clear r
%     vals_200 = single( vals_200 );
%     niftiwrite( vals_200, [ 'Figure_Summary_Data_', dname, '_Event_Lock_data_', num2str( beh ), '.nii' ], info_200, 'Compressed', true )
% end; clear beh
% 
% for beh = 1 : size( dB_xc_data, 2 )
%     vals = dB_xc_rec_G( :, beh );
%     vals_200 = nan( size( atlas_200 ) );
%     for r = 1 : 200
%         if ~isnan( vals( r ) )
%             r_idx = atlas_200 == r;
%             % r_idx = r_idx( : );
%             vals_200( r_idx ) = vals( r );
%         end
%     end; clear r
%     vals_200 = single( vals_200 );
%     niftiwrite( vals_200, [ 'Figure_Summary_Data_', dname, '_Event_Lock_rec_G', num2str( beh ), '.nii' ], info_200, 'Compressed', true )
% end; clear beh
% 

%% Summary, Event Locking
% clear
% dname = 'RD_005_PBWr_L1_RecG';
% xtick_names = { 'State 1', 'State2' };
% 
% load( [ 'Summary_Data_', dname, '.mat' ] )
% 
% m_event_lock_data = mean( event_lock_data( :, :, : ), 3, 'omitnan' );
% m_event_lock_rec_G = mean( event_lock_rec_G( :, :, : ), 3, 'omitnan' );
% 
% dB_xc_data = 20 * log10( m_event_lock_data( :, 2 : end ) ./ m_event_lock_data( :, 1 ) );
% dB_xc_rec_G = 20 * log10( m_event_lock_rec_G( :, 2 : end ) ./ m_event_lock_rec_G( :, 1 ) );
% 
% corr_dB = [];
% for beh = 1 : size( dB_xc_data, 2 )
%     corr_dB( 1, beh ) = corr( dB_xc_data( :, beh ), dB_xc_rec_G( :, beh ), 'rows', 'complete' );
% end; clear beh
% 
% act_dB = [];
% for beh = 1 : size( dB_xc_data, 2 )
%     act_dB( 1, beh ) = sqrt( sum( ( dB_xc_data( :, beh ) .^ 2 ), 1, 'omitnan' ) );
%     act_dB( 2, beh ) = sqrt( sum( ( dB_xc_rec_G( :, beh ) .^ 2 ), 1, 'omitnan' ) );
% end; clear beh
% 
% save( [ 'Summary_Data_', dname, '_Event_Lock.mat' ], ...
%     'xtick_names', 'dB_xc_data', 'dB_xc_rec_G', 'corr_dB', 'act_dB' )
% 

%% Comparison, MDD_L1
% clear
% k = 4;
% iterr = 1;
% 
% % -------------------------------------------------------------------------
% 
% dname = 'RD_005_MDD_L1';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
% mm_acc_data = nan( 4, 1, 2, size( flist, 1 ) );
% mm_acc_act_G = nan( 4, 1, 2, size( flist, 1 ) );
% mm_acc_rec_G = nan( 4, 1, 2, size( flist, 1 ) );
% 
% ct_fn = [ 0, 0 ];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     m_acc_data = [ mean( acc_data, 2 ) ];
%     m_acc_act_G = [];
%     for g = 1 : 1
%         m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%     end; clear g
%     m_acc_rec_G = [ mean( acc_rec_G, 2 ) ];
% 
%     g = P_info( fn, 1 );
%     ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%     mm_acc_data( :, :, g, ct_fn( 1, g ) ) = m_acc_data;
%     mm_acc_act_G( :, :, g, ct_fn( 1, g ) ) = m_acc_act_G;
%     mm_acc_rec_G( :, :, g, ct_fn( 1, g ) ) = m_acc_rec_G;
% 
% end; clear fn ct_fn
% 
% cd( '..' )
% 
% % -------------------------------------------------------------------------
% 
% dname = 'Comp_HSM_AG_MDD_L1';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
% mm_acc_act_G_HSM = nan( 4, 1, 2, size( flist, 1 ) );
% mm_acc_rec_G_HSM = nan( 4, 1, 2, size( flist, 1 ) );
% 
% ct_fn = [ 0, 0 ];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     m_acc_act_G = [];
%     for g = 1 : 1
%         m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%     end; clear g
%     m_acc_rec_G = [ mean( acc_rec_G, 2 ) ];
% 
%     g = P_info( fn, 1 );
%     ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%     mm_acc_act_G_HSM( :, :, g, ct_fn( 1, g ) ) = m_acc_act_G;
%     mm_acc_rec_G_HSM( :, :, g, ct_fn( 1, g ) ) = m_acc_rec_G;
% 
% end; clear fn ct_fn
% 
% cd( '..' )
% 
% % -------------------------------------------------------------------------
% 
% dname = 'Comp_HSM_MDD_L1';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
% mm_acc_HSM = nan( 4, 1, 2, size( flist, 1 ) );
% 
% ct_fn = [ 0, 0 ];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     m_acc_HSM = mean( acc_HSM, 2 );
% 
%     g = P_info( fn, 1 );
%     ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%     mm_acc_HSM( :, :, g, ct_fn( 1, g ) ) = m_acc_HSM;
% 
% end; clear fn ct_fn
% 
% cd( '..' )
% 
% % -------------------------------------------------------------------------
% 
% dname = 'Comp_AG_HSM_MDD_L1';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
% mm_acc_HSM_G = nan( 4, 1, 2, size( flist, 1 ) );
% mm_acc_HSM_recG = nan( 4, 1, 2, size( flist, 1 ) );
% 
% ct_fn = [ 0, 0 ];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     m_acc_HSM_G = mean( acc_HSM_G, 2 );
%     m_acc_HSM_recG = mean( acc_HSM_recG, 2 );
% 
%     g = P_info( fn, 1 );
%     ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%     mm_acc_HSM_G( :, :, g, ct_fn( 1, g ) ) = m_acc_HSM_G;
%     mm_acc_HSM_recG( :, :, g, ct_fn( 1, g ) ) = m_acc_HSM_recG;
% 
% end; clear fn ct_fn
% 
% cd( '..' )
% 
% % -------------------------------------------------------------------------
% 
% save( [ 'Comparion_Data_MDD_L1.mat' ], ...
%     'mm_acc_data', 'mm_acc_act_G', 'mm_acc_rec_G', ...
%     'mm_acc_act_G_HSM', 'mm_acc_rec_G_HSM', ...
%     'mm_acc_HSM', ...
%     'mm_acc_HSM_G', 'mm_acc_HSM_recG', ...
%     'P_info' )
% 

%% Comparison, SCZ_L1
% clear
% k = 7;
% iterr = 1;
% 
% % -------------------------------------------------------------------------
% 
% dname = 'RD_005_SCZ_L1';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% P_info = [ P_info( 1 : 9, : ); P_info( 86 : 88, : ); P_info( 10 : 85, : ) ];
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
% mm_acc_data = nan( 3, 1, 3, size( flist, 1 ) );
% mm_acc_act_G = nan( 3, 1, 3, size( flist, 1 ) );
% mm_acc_rec_G = nan( 3, 1, 3, size( flist, 1 ) );
% 
% ct_fn = [ 0, 0, 0 ];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     m_acc_data = [ mean( acc_data, 2 ) ];
%     m_acc_act_G = [];
%     for g = 1 : 1
%         m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%     end; clear g
%     m_acc_rec_G = [ mean( acc_rec_G, 2 ) ];
% 
%     g = P_info( fn, 1 );
%     ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%     mm_acc_data( :, :, g, ct_fn( 1, g ) ) = m_acc_data;
%     mm_acc_act_G( :, :, g, ct_fn( 1, g ) ) = m_acc_act_G;
%     mm_acc_rec_G( :, :, g, ct_fn( 1, g ) ) = m_acc_rec_G;
% 
% end; clear fn ct_fn
% 
% cd( '..' )
% 
% % -------------------------------------------------------------------------
% 
% dname = 'Comp_HSM_AG_SCZ_L1';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% P_info = [ P_info( 1 : 9, : ); P_info( 86 : 88, : ); P_info( 10 : 85, : ) ];
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
% mm_acc_act_G_HSM = nan( 3, 1, 3, size( flist, 1 ) );
% mm_acc_rec_G_HSM = nan( 3, 1, 3, size( flist, 1 ) );
% 
% ct_fn = [ 0, 0, 0 ];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     m_acc_act_G = [];
%     for g = 1 : 1
%         m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%     end; clear g
%     m_acc_rec_G = [ mean( acc_rec_G, 2 ) ];
% 
%     g = P_info( fn, 1 );
%     ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%     mm_acc_act_G_HSM( :, :, g, ct_fn( 1, g ) ) = m_acc_act_G;
%     mm_acc_rec_G_HSM( :, :, g, ct_fn( 1, g ) ) = m_acc_rec_G;
% 
% end; clear fn ct_fn
% 
% cd( '..' )
% 
% % -------------------------------------------------------------------------
% 
% dname = 'Comp_HSM_SCZ_L1';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% P_info = [ P_info( 1 : 9, : ); P_info( 86 : 88, : ); P_info( 10 : 85, : ) ];
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
% mm_acc_HSM = nan( 3, 1, 3, size( flist, 1 ) );
% 
% ct_fn = [ 0, 0, 0 ];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     m_acc_HSM = mean( acc_HSM, 2 );
% 
%     g = P_info( fn, 1 );
%     ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%     mm_acc_HSM( :, :, g, ct_fn( 1, g ) ) = m_acc_HSM;
% 
% end; clear fn ct_fn
% 
% cd( '..' )
% 
% % -------------------------------------------------------------------------
% 
% dname = 'Comp_AG_HSM_SCZ_L1';
% 
% cd( [ pwd, '\', dname ] )
% 
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% P_info = [ P_info( 1 : 9, : ); P_info( 86 : 88, : ); P_info( 10 : 85, : ) ];
% 
% flist = dir( [ 'Results_ExpRD_*_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ] );
% 
% mm_acc_HSM_G = nan( 3, 1, 3, size( flist, 1 ) );
% mm_acc_HSM_recG = nan( 3, 1, 3, size( flist, 1 ) );
% 
% ct_fn = [ 0, 0, 0 ];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     m_acc_HSM_G = mean( acc_HSM_G, 2 );
%     m_acc_HSM_recG = mean( acc_HSM_recG, 2 );
% 
%     g = P_info( fn, 1 );
%     ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%     mm_acc_HSM_G( :, :, g, ct_fn( 1, g ) ) = m_acc_HSM_G;
%     mm_acc_HSM_recG( :, :, g, ct_fn( 1, g ) ) = m_acc_HSM_recG;
% 
% end; clear fn ct_fn
% 
% cd( '..' )
% 
% % -------------------------------------------------------------------------
% 
% save( [ 'Comparion_Data_SCZ_L1.mat' ], ...
%     'mm_acc_data', 'mm_acc_act_G', 'mm_acc_rec_G', ...
%     'mm_acc_act_G_HSM', 'mm_acc_rec_G_HSM', ...
%     'mm_acc_HSM', ...
%     'mm_acc_HSM_G', 'mm_acc_HSM_recG', ...
%     'P_info' )
% 
