% Analysis_Associative_Generators_RD_SCZ_L1
clear; close all; clc



%% Experiment - Real world data (Learning)

load( 'P_info.mat' )
load( 'missingParticipant.mat' )
P_info = P_info( missingParticipant == 0, : );
P_info = [ P_info( 1 : 9, : ); P_info( 86 : 88, : ); P_info( 10 : 85, : ) ];
list_HC = transpose( find( P_info( :, 1 ) == 1 ) );

flist = dir( 'Storage_fMRI_Schizophrenia_*.mat' );

for iterr = 1 : 9

    for k = 1 : 8

        for fn = 1 : size( flist, 1 )

            fname = flist( fn, 1 ).name;

            load( fname )

            data0 = data;

            data = {};
            data{ 1, 1 } = [ data0 ];
            clear data0

            % -------------------------------------------------------------------------

            vars = struct;

            vars.N_inputs = [];
            for g0 = 1 : length( data )
                vars.N_inputs( 1, g0 ) = size( data{ 1, g0 }, 1 );
            end; clear g0

            vars.T_length = ( 2 ^ ( k + 0 ) ) * [ 1 ] + 1;
            vars.N_units = 100 * ones( 1, length( vars.T_length ) );

            vars.V_from_inputs = [ 1 ];% ( from, to ), 1 (if exist) or 0 (otherwise).
            vars.V_between_G = [ 0 ];% ( from, to ), 1 (if exist) or 0 (otherwise).
            vars.V_to_outputs = [ 1 ];% ( from, to ), 1 (if exist) or 0 (otherwise).

            vars.W_from_inputs = [ 1 ];% ( from, to ), >= 0.
            vars.W_between_G = [ 0 ];% ( from, to ), >= 0.
            vars.W_to_outputs = [ 1 ];% ( from, to ), >= 0.

            vars.C_output_type = 1 * ones( 1, length( vars.T_length ) );% output is from generator [1], memory [0], or between two (0, 1).
            % vars.C_output_type = 0 * ones( 1, length( vars.T_length ) );% output is from generator [1], memory [0], or between two (0, 1).

            vars.C_modulation = 0.3;
            % vars.C_learning_rate = 0.2;
            % vars.C_learning_rate = 0.1;
            vars.C_learning_rate = 0.05;
            vars.C_learning_threshold = 1.5;
            vars.C_learning_scatter_ratio = 0.5;

            % -------------------------------------------------------------------------

            vars = AG1_initialize( vars );

            % -------------------------------------------------------------------------

            mean_eval_G_F = [];

            vars.learning = 'on';

            tic
            % [ vars, act_G, act_F ] = AG1_process( vars, data );
            % % [ vars, act_G, act_F ] = AG1_process_GPU( vars, data );
            list_HC_sd = setdiff( list_HC, fn );
            for fn1 = list_HC_sd( randperm( length( list_HC_sd ), min( [ length( list_HC_sd ), 32 ] ) ) )

                fname1 = flist( fn1, 1 ).name;

                load( fname1 )

                data1 = data;

                data = {};
                data{ 1, 1 } = [ data1 ];
                clear data1

                [ vars, act_G, act_F, ~, ~ ] = AG1_process( vars, data );
                eval_G_F = [];
                for g = 1 : length( vars.T_length )
                    eval_G_F( g, : ) = sqrt( mean( ( act_G{ 1, g } - act_F{ 1, g } ) .^ 2, 1 ) );
                end; clear g
                mean_eval_G_F = [ mean_eval_G_F, mean( eval_G_F, 2 ) ];
            end; clear fn1
            toc

            vars.learning = 'off';

            tic
            load( fname )

            data0 = data;

            data = {};
            data{ 1, 1 } = [ data0 ];
            clear data0

            [ vars, act_G, act_F, rec_G, rec_F ] = AG1_process( vars, data );
            eval_G_F = [];
            for g = 1 : length( vars.T_length )
                eval_G_F( g, : ) = sqrt( mean( ( act_G{ 1, g } - act_F{ 1, g } ) .^ 2, 1 ) );
            end; clear g
            mean_eval_G_F = [ mean_eval_G_F, mean( eval_G_F, 2 ) ];
            toc

            % -------------------------------------------------------------------------

            event( 1 : 2, find( diff( event( 1, : ) ) == 1 ) + 1 ) = nan;

            learning_assign = zeros( 1, size( data, 2 ) );
            for tr = 1 : size( event, 2 )
                if ~isnan( event( 1, tr ) )
                    learning_assign( event( 1, tr ) + [ 0 : 1 ] ) = event( 2, tr );
                end
            end; clear tr

            % -------------------------------------------------------------------------

            t_data = data{ 1, 1 };

            % -------------------------------------------------------------------------

            for beh = 1 : 3
                for iter = 1 : 30
                    idxBehavior = find( learning_assign == beh );
                    idxRandom = randperm( size( t_data, 2 ), length( idxBehavior ) );
                    idxBehavior = idxBehavior( randperm( length( idxBehavior ) ) );
                    idxRandom = idxRandom( randperm( length( idxRandom ) ) );
                    idxBehavior_Tr = idxBehavior( 1 : round( length( idxBehavior ) / 2 ) );
                    idxBehavior_Te = idxBehavior( ( round( length( idxBehavior ) / 2 ) + 1 : end ) );
                    idxRandom_Tr = idxRandom( 1 : round( length( idxRandom ) / 2 ) );
                    idxRandom_Te = idxRandom( ( round( length( idxRandom ) / 2 ) + 1 : end ) );

                    idx_Tr = [ 1 * ones( length( idxBehavior_Tr ), 1 ); 2 * ones( length( idxRandom_Tr ), 1 ) ];
                    idx_Te = [ 1 * ones( length( idxBehavior_Te ), 1 ); 2 * ones( length( idxRandom_Te ), 1 ) ];
                    data_Tr = transpose( t_data( :, [ idxBehavior_Tr, idxRandom_Tr ] ) );
                    data_Te = transpose( t_data( :, [ idxBehavior_Te, idxRandom_Te ] ) );
                    Mdl = fitcecoc( data_Tr, idx_Tr );% SVM
                    idx_out = predict( Mdl, data_Te );
                    acc = idx_out == idx_Te;
                    acc_data( beh, iter ) = mean( acc, 1, 'omitnan' );
                end; clear iter
            end; clear beh
            clear beh iter idxRandom idxBehavior idxBehavior_Tr idxBehavior_Te idxRandom_Tr idxRandom_Te idx_Tr idx_Te data_Tr data_Te Mdl idx_out acc

            % -------------------------------------------------------------------------

            acc_act = {};
            for g = 1 : length( vars.T_length )
                t_data = act_G{ 1, g };
                for beh = 1 : 3
                    for iter = 1 : 30
                        idxBehavior = find( learning_assign == beh );
                        idxRandom = randperm( size( t_data, 2 ), length( idxBehavior ) );
                        idxBehavior = idxBehavior( randperm( length( idxBehavior ) ) );
                        idxRandom = idxRandom( randperm( length( idxRandom ) ) );
                        idxBehavior_Tr = idxBehavior( 1 : round( length( idxBehavior ) / 2 ) );
                        idxBehavior_Te = idxBehavior( ( round( length( idxBehavior ) / 2 ) + 1 : end ) );
                        idxRandom_Tr = idxRandom( 1 : round( length( idxRandom ) / 2 ) );
                        idxRandom_Te = idxRandom( ( round( length( idxRandom ) / 2 ) + 1 : end ) );

                        idx_Tr = [ 1 * ones( length( idxBehavior_Tr ), 1 ); 2 * ones( length( idxRandom_Tr ), 1 ) ];
                        idx_Te = [ 1 * ones( length( idxBehavior_Te ), 1 ); 2 * ones( length( idxRandom_Te ), 1 ) ];
                        data_Tr = transpose( t_data( :, [ idxBehavior_Tr, idxRandom_Tr ] ) );
                        data_Te = transpose( t_data( :, [ idxBehavior_Te, idxRandom_Te ] ) );
                        Mdl = fitcecoc( data_Tr, idx_Tr );% SVM
                        idx_out = predict( Mdl, data_Te );
                        acc = idx_out == idx_Te;
                        acc_act{ 1, g }( beh, iter ) = mean( acc, 1, 'omitnan' );
                    end; clear iter
                end; clear beh
            end; clear g
            acc_act_G = acc_act;
            clear beh iter idxRandom idxBehavior idxBehavior_Tr idxBehavior_Te idxRandom_Tr idxRandom_Te idx_Tr idx_Te data_Tr data_Te Mdl idx_out acc
            clear act_pool beh idxBehavior n

            % -------------------------------------------------------------------------

            acc_act = {};
            for g = 1 : length( vars.T_length )
                t_data = act_F{ 1, g };
                for beh = 1 : 3
                    for iter = 1 : 30
                        idxBehavior = find( learning_assign == beh );
                        idxRandom = randperm( size( t_data, 2 ), length( idxBehavior ) );
                        idxBehavior = idxBehavior( randperm( length( idxBehavior ) ) );
                        idxRandom = idxRandom( randperm( length( idxRandom ) ) );
                        idxBehavior_Tr = idxBehavior( 1 : round( length( idxBehavior ) / 2 ) );
                        idxBehavior_Te = idxBehavior( ( round( length( idxBehavior ) / 2 ) + 1 : end ) );
                        idxRandom_Tr = idxRandom( 1 : round( length( idxRandom ) / 2 ) );
                        idxRandom_Te = idxRandom( ( round( length( idxRandom ) / 2 ) + 1 : end ) );

                        idx_Tr = [ 1 * ones( length( idxBehavior_Tr ), 1 ); 2 * ones( length( idxRandom_Tr ), 1 ) ];
                        idx_Te = [ 1 * ones( length( idxBehavior_Te ), 1 ); 2 * ones( length( idxRandom_Te ), 1 ) ];
                        data_Tr = transpose( t_data( :, [ idxBehavior_Tr, idxRandom_Tr ] ) );
                        data_Te = transpose( t_data( :, [ idxBehavior_Te, idxRandom_Te ] ) );
                        Mdl = fitcecoc( data_Tr, idx_Tr );% SVM
                        idx_out = predict( Mdl, data_Te );
                        acc = idx_out == idx_Te;
                        acc_act{ 1, g }( beh, iter ) = mean( acc, 1, 'omitnan' );
                    end; clear iter
                end; clear beh
            end; clear g
            acc_act_F = acc_act;
            clear beh iter idxRandom idxBehavior idxBehavior_Tr idxBehavior_Te idxRandom_Tr idxRandom_Te idx_Tr idx_Te data_Tr data_Te Mdl idx_out acc
            clear act_pool beh idxBehavior n

            % -------------------------------------------------------------------------

            t_data = rec_G{ length( vars.T_length ), 1 };

            % -------------------------------------------------------------------------

            acc_rec_G = [];
            for beh = 1 : 3
                for iter = 1 : 30
                    idxBehavior = find( learning_assign == beh );
                    idxRandom = randperm( size( t_data, 2 ), length( idxBehavior ) );
                    idxBehavior = idxBehavior( randperm( length( idxBehavior ) ) );
                    idxRandom = idxRandom( randperm( length( idxRandom ) ) );
                    idxBehavior_Tr = idxBehavior( 1 : round( length( idxBehavior ) / 2 ) );
                    idxBehavior_Te = idxBehavior( ( round( length( idxBehavior ) / 2 ) + 1 : end ) );
                    idxRandom_Tr = idxRandom( 1 : round( length( idxRandom ) / 2 ) );
                    idxRandom_Te = idxRandom( ( round( length( idxRandom ) / 2 ) + 1 : end ) );

                    idx_Tr = [ 1 * ones( length( idxBehavior_Tr ), 1 ); 2 * ones( length( idxRandom_Tr ), 1 ) ];
                    idx_Te = [ 1 * ones( length( idxBehavior_Te ), 1 ); 2 * ones( length( idxRandom_Te ), 1 ) ];
                    data_Tr = transpose( t_data( :, [ idxBehavior_Tr, idxRandom_Tr ] ) );
                    data_Te = transpose( t_data( :, [ idxBehavior_Te, idxRandom_Te ] ) );
                    Mdl = fitcecoc( data_Tr, idx_Tr );% SVM
                    idx_out = predict( Mdl, data_Te );
                    acc = idx_out == idx_Te;
                    acc_rec_G( beh, iter ) = mean( acc, 1, 'omitnan' );
                end; clear iter
            end; clear beh
            clear beh iter idxRandom idxBehavior idxBehavior_Tr idxBehavior_Te idxRandom_Tr idxRandom_Te idx_Tr idx_Te data_Tr data_Te Mdl idx_out acc

            % -------------------------------------------------------------------------

            t_data = rec_F{ length( vars.T_length ), 1 };

            % -------------------------------------------------------------------------

            acc_rec_F = [];
            for beh = 1 : 3
                for iter = 1 : 30
                    idxBehavior = find( learning_assign == beh );
                    idxRandom = randperm( size( t_data, 2 ), length( idxBehavior ) );
                    idxBehavior = idxBehavior( randperm( length( idxBehavior ) ) );
                    idxRandom = idxRandom( randperm( length( idxRandom ) ) );
                    idxBehavior_Tr = idxBehavior( 1 : round( length( idxBehavior ) / 2 ) );
                    idxBehavior_Te = idxBehavior( ( round( length( idxBehavior ) / 2 ) + 1 : end ) );
                    idxRandom_Tr = idxRandom( 1 : round( length( idxRandom ) / 2 ) );
                    idxRandom_Te = idxRandom( ( round( length( idxRandom ) / 2 ) + 1 : end ) );

                    idx_Tr = [ 1 * ones( length( idxBehavior_Tr ), 1 ); 2 * ones( length( idxRandom_Tr ), 1 ) ];
                    idx_Te = [ 1 * ones( length( idxBehavior_Te ), 1 ); 2 * ones( length( idxRandom_Te ), 1 ) ];
                    data_Tr = transpose( t_data( :, [ idxBehavior_Tr, idxRandom_Tr ] ) );
                    data_Te = transpose( t_data( :, [ idxBehavior_Te, idxRandom_Te ] ) );
                    Mdl = fitcecoc( data_Tr, idx_Tr );% SVM
                    idx_out = predict( Mdl, data_Te );
                    acc = idx_out == idx_Te;
                    acc_rec_F( beh, iter ) = mean( acc, 1, 'omitnan' );
                end; clear iter
            end; clear beh
            clear beh iter idxRandom idxBehavior idxBehavior_Tr idxBehavior_Te idxRandom_Tr idxRandom_Te idx_Tr idx_Te data_Tr data_Te Mdl idx_out acc

            % -------------------------------------------------------------------------

            % save( [ 'ALL_Results', fname( 8 : end - 4 ), '_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ], 'vars', 'act_G', 'act_F', 'rec_G', 'rec_F', 'acc_data', 'acc_act_G', 'acc_act_F', 'acc_rec_G', 'acc_rec_F', 'mean_eval_G_F' )
            % save( [ 'REC_Results', fname( 8 : end - 4 ), '_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ], 'rec_G', 'rec_F', 'acc_data', 'acc_act_G', 'acc_act_F', 'acc_rec_G', 'acc_rec_F', 'mean_eval_G_F' )
            save( [ 'Results_ExpRD', fname( 8 : end - 4 ), '_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ], 'acc_data', 'acc_act_G', 'acc_act_F', 'acc_rec_G', 'acc_rec_F', 'mean_eval_G_F' )

            disp( [ num2str( fn ), ' / ', num2str( size( flist, 1 ) ) ] )

        end; clear fn

    end; clear k

end; clear iterr


%% Results
% clear
% load( 'P_info.mat' )
% load( 'missingParticipant.mat' )
% P_info = P_info( missingParticipant == 0, : );
% P_info = [ P_info( 1 : 9, : ); P_info( 86 : 88, : ); P_info( 10 : 85, : ) ];
% 
% flist = dir( [ 'Results_ExpRD_*_k1_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k2_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k3_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k4_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k5_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k6_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k7_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k8_iterr1.mat' ] );
% 
% mm_acc_data = nan( 3, 1, 3, size( flist, 1 ) );
% mm_acc_act_G = nan( 3, 1, 3, size( flist, 1 ) );
% mm_acc_act_F = nan( 3, 1, 3, size( flist, 1 ) );
% mm_acc_rec_G = nan( 3, 1, 3, size( flist, 1 ) );
% mm_acc_rec_F = nan( 3, 1, 3, size( flist, 1 ) );
% mm_mean_eval_G_F = nan( 33, 3, size( flist, 1 ) );
% 
% ct_fn = [ 0, 0, 0 ];
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
% 
%     % for g = 1 : length( vars.T_length )
%     %     figure
%     %     subplot( 1, 2, 1 )
%     %     imagesc( act_G{ 1, g } ); colorbar
%     %     subplot( 1, 2, 2 )
%     %     imagesc( act_F{ 1, g } ); colorbar
%     % end; clear g
%     %
%     % for g = 1 : length( vars.T_length )
%     %     figure
%     %     subplot( 1, 2, 1 )
%     %     imagesc( act_G{ 1, g }( :, end - 128 : end ) ); colorbar
%     %     subplot( 1, 2, 2 )
%     %     imagesc( act_F{ 1, g }( :, end - 128 : end ) ); colorbar
%     % end; clear g
% 
% 
%     m_acc_data = [ mean( acc_data, 2 ) ];
%     m_acc_act_G = [];
%     m_acc_act_F = [];
%     for g = 1 : 1
%         m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2 );
%         m_acc_act_F( :, g ) = mean( acc_act_F{ 1, g }, 2 );
%     end; clear g
%     m_acc_rec_G = [ mean( acc_rec_G, 2 ) ];
%     m_acc_rec_F = [ mean( acc_rec_F, 2 ) ];
% 
%     % y_lim = [ 0.45, 0.8 ];
%     %
%     % figure
%     % subplot( 1, 3, 1 )
%     % bar( [ m_acc_data ] )
%     % ylim( y_lim )
%     % title( [ 'data' ] )
%     % subplot( 1, 3, 2 )
%     % bar( [ m_acc_act_G ] )
%     % ylim( y_lim )
%     % title( [ 'act_G' ] )
%     % subplot( 1, 3, 3 )
%     % bar( [ m_acc_act_F ] )
%     % ylim( y_lim )
%     % title( [ 'act_F' ] )
% 
% 
%     g = P_info( fn, 1 );
%     ct_fn( 1, g ) = ct_fn( 1, g ) + 1;
%     mm_acc_data( :, :, g, ct_fn( 1, g ) ) = m_acc_data;
%     mm_acc_act_G( :, :, g, ct_fn( 1, g ) ) = m_acc_act_G;
%     mm_acc_act_F( :, :, g, ct_fn( 1, g ) ) = m_acc_act_F;
%     mm_acc_rec_G( :, :, g, ct_fn( 1, g ) ) = m_acc_rec_G;
%     mm_acc_rec_F( :, :, g, ct_fn( 1, g ) ) = m_acc_rec_F;
%     mm_mean_eval_G_F( :, g, ct_fn( 1, g ) ) = mean_eval_G_F;
% 
% end; clear fn ct_fn
% 
% pVals_all = [];
% for beh = 1 : 3
%     pVals_all( beh, 1 ) = ranksum( squeeze( mm_acc_data( beh, 1, 1, : ) ), squeeze( mm_acc_data( beh, 1, 2, : ) ), 'tail', 'both' );
%     pVals_all( beh, 2 ) = ranksum( squeeze( mm_acc_act_G( beh, 1, 1, : ) ), squeeze( mm_acc_act_G( beh, 1, 2, : ) ), 'tail', 'both' );
%     pVals_all( beh, 3 ) = ranksum( squeeze( mm_acc_act_F( beh, 1, 1, : ) ), squeeze( mm_acc_act_F( beh, 1, 2, : ) ), 'tail', 'both' );
%     pVals_all( beh, 4 ) = ranksum( squeeze( mm_acc_rec_G( beh, 1, 1, : ) ), squeeze( mm_acc_rec_G( beh, 1, 2, : ) ), 'tail', 'both' );
%     pVals_all( beh, 5 ) = ranksum( squeeze( mm_acc_rec_F( beh, 1, 1, : ) ), squeeze( mm_acc_rec_F( beh, 1, 2, : ) ), 'tail', 'both' );
% end; clear beh
% qVals_all = [];
% for m = 1 : 5
%     qVals_all( :, m ) = mafdr( pVals_all( :, m ), 'BHFDR', 'True' );
% end; clear m
% 
% sigLevel = 0.05;
% figure
% subplot( 1, 2, 1 )
% imagesc( pVals_all < sigLevel )
% subplot( 1, 2, 2 )
% imagesc( qVals_all < sigLevel )
% 
% m_mm_acc_data = median( mm_acc_data, 4, 'omitnan' );
% m_mm_acc_act_G = median( mm_acc_act_G, 4, 'omitnan' );
% m_mm_acc_act_F = median( mm_acc_act_F, 4, 'omitnan' );
% m_mm_acc_rec_G = median( mm_acc_rec_G, 4, 'omitnan' );
% m_mm_acc_rec_F = median( mm_acc_rec_F, 4, 'omitnan' );
% m_mm_mean_eval_G_F = mean( mm_mean_eval_G_F, 3, 'omitnan' );
% 
% y_lim = [ 0.45, 0.8 ];
% 
% figure
% subplot( 1, 5, 1 )
% bar( [ squeeze( m_mm_acc_data ) ] )
% ylim( y_lim )
% title( [ 'data' ] )
% subplot( 1, 5, 2 )
% bar( [ squeeze( m_mm_acc_act_G ) ] )
% ylim( y_lim )
% title( [ 'act_G' ] )
% subplot( 1, 5, 3 )
% bar( [ squeeze( m_mm_acc_act_F ) ] )
% ylim( y_lim )
% title( [ 'act_F' ] )
% subplot( 1, 5, 4 )
% bar( [ squeeze( m_mm_acc_rec_G ) ] )
% ylim( y_lim )
% title( [ 'rec_G' ] )
% subplot( 1, 5, 5 )
% bar( [ squeeze( m_mm_acc_rec_F ) ] )
% ylim( y_lim )
% title( [ 'rec_F' ] )
% 
% figure
% bar( squeeze( m_mm_mean_eval_G_F ) )
% colorbar
% 
