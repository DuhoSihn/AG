% Analysis_Associative_Generators_RD_PBWr_L1
clear; close all; clc



%% Experiment - Real world data (No learning)

flist = dir( 'Storage_RD_PBW_*.mat' );

for iterr = 0

    for k = 1 : 7

        for fn = 1 : size( flist, 1 )

            fname = flist( fn, 1 ).name;

            load( fname )

            data = {};
            data{ 1, 1 } = [ data_A_D ];
            data{ 1, 2 } = [ data_B ];

            data_C = double( data_C );
            for beh = 1 : 6
                if all( data_C( beh, : ) == median( data_C( beh, : ), 2, 'omitnan' ) )
                    data_C( beh, : ) = nan;
                end
            end; clear beh

            % -------------------------------------------------------------------------

            vars = struct;

            vars.N_inputs = [];
            for g0 = 1 : length( data )
                vars.N_inputs( 1, g0 ) = size( data{ 1, g0 }, 1 );
            end; clear g0

            vars.T_length = ( 2 ^ ( k + 0 ) ) * [ 1 ] + 1;
            vars.N_units = 64 * ones( 1, length( vars.T_length ) );

            vars.V_from_inputs = [ [ 1 ]; [ 1 ] ];% ( from, to ), 1 (if exist) or 0 (otherwise).
            vars.V_between_G = [ [ 0 ] ];% ( from, to ), 1 (if exist) or 0 (otherwise).
            vars.V_to_outputs = [ [ 1, 1 ] ];% ( from, to ), 1 (if exist) or 0 (otherwise).

            vars.W_from_inputs = [ [ 1 ]; [ 1 ] ];% ( from, to ), >= 0.
            vars.W_between_G = [ [ 0 ] ];% ( from, to ), >= 0.
            vars.W_to_outputs = [ [ 1, 1 ] ];% ( from, to ), >= 0.

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

            %             vars.learning = 'on';
            %
            %             tic
            %             % [ vars, act_G, act_F ] = AG1_process( vars, data );
            %             % % [ vars, act_G, act_F ] = AG1_process_GPU( vars, data );
            %             for iter = 1 : 16
            %                 [ vars, act_G, act_F, ~, ~ ] = AG1_process( vars, data );
            %                 eval_G_F = [];
            %                 for g = 1 : length( vars.T_length )
            %                     eval_G_F( g, : ) = sqrt( mean( ( act_G{ 1, g } - act_F{ 1, g } ) .^ 2, 1 ) );
            %                 end; clear g
            %                 mean_eval_G_F = [ mean_eval_G_F, mean( eval_G_F, 2 ) ];
            %             end; clear iter
            %             toc

            vars.learning = 'off';

            tic
            [ vars, act_G, act_F, rec_G, rec_F ] = AG1_process( vars, data );
            eval_G_F = [];
            for g = 1 : length( vars.T_length )
                eval_G_F( g, : ) = sqrt( mean( ( act_G{ 1, g } - act_F{ 1, g } ) .^ 2, 1 ) );
            end; clear g
            mean_eval_G_F = [ mean_eval_G_F, mean( eval_G_F, 2 ) ];
            toc

            % -------------------------------------------------------------------------

            learning_assign = data_C;

            % -------------------------------------------------------------------------

            t_data = data{ 1, 1 };

            % -------------------------------------------------------------------------

            acc_data1 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_data1( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_data1( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats

            % -------------------------------------------------------------------------

            t_data = data{ 1, 2 };

            % -------------------------------------------------------------------------

            acc_data2 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_data2( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_data2( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats

            % -------------------------------------------------------------------------

            acc_act = {};
            for g = 1 : length( vars.T_length )
                t_data = act_G{ 1, g };
                for beh = 1 : 6
                    if ~all( isnan( learning_assign( beh, : ) ) )
                        [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                        acc_act{ 1, g }( beh, 1 ) = stats( 1 );% R-square
                    else
                        acc_act{ 1, g }( beh, 1 ) = nan;
                    end
                end; clear beh
            end; clear g
            acc_act_G = acc_act;
            clear stats

            % -------------------------------------------------------------------------

            acc_act = {};
            for g = 1 : length( vars.T_length )
                t_data = act_F{ 1, g };
                for beh = 1 : 6
                    if ~all( isnan( learning_assign( beh, : ) ) )
                        [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                        acc_act{ 1, g }( beh, 1 ) = stats( 1 );% R-square
                    else
                        acc_act{ 1, g }( beh, 1 ) = nan;
                    end
                end; clear beh
            end; clear g
            acc_act_F = acc_act;
            clear stats

            % -------------------------------------------------------------------------

            t_data = rec_G{ length( vars.T_length ), 1 };

            % -------------------------------------------------------------------------

            acc_rec_G1 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_rec_G1( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_rec_G1( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats

            % -------------------------------------------------------------------------

            t_data = rec_G{ length( vars.T_length ), 2 };

            % -------------------------------------------------------------------------

            acc_rec_G2 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_rec_G2( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_rec_G2( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats


            % -------------------------------------------------------------------------

            t_data = rec_F{ length( vars.T_length ), 1 };

            % -------------------------------------------------------------------------

            acc_rec_F1 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_rec_F1( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_rec_F1( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats

            % -------------------------------------------------------------------------

            t_data = rec_F{ length( vars.T_length ), 2 };

            % -------------------------------------------------------------------------

            acc_rec_F2 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_rec_F2( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_rec_F2( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats

            % -------------------------------------------------------------------------

            % save( [ 'ALL_Results', fname( 8 : end - 4 ), '_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ], 'vars', 'act_G', 'act_F', 'rec_G', 'rec_F', 'acc_data', 'acc_act_G', 'acc_act_F', 'acc_rec_G', 'acc_rec_F', 'mean_eval_G_F' )
            % save( [ 'REC_Results', fname( 8 : end - 4 ), '_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ], 'rec_G', 'rec_F', 'acc_data', 'acc_act_G', 'acc_act_F', 'acc_rec_G', 'acc_rec_F', 'mean_eval_G_F' )
            save( [ 'Results_ExpRD', fname( 8 : end - 4 ), '_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ], 'acc_data1', 'acc_data2', 'acc_act_G', 'acc_act_F', 'acc_rec_G1', 'acc_rec_G2', 'acc_rec_F1', 'acc_rec_F2', 'mean_eval_G_F' )

            disp( [ num2str( fn ), ' / ', num2str( size( flist, 1 ) ) ] )

        end; clear fn

    end; clear k

end; clear iterr


%% Experiment - Real world data (Learning)

flist = dir( 'Storage_RD_PBW_*.mat' );

for iterr = 1 : 9

    for k = 1 : 7

        for fn = 1 : size( flist, 1 )

            fname = flist( fn, 1 ).name;

            load( fname )

            data = {};
            data{ 1, 1 } = [ data_A_D ];
            data{ 1, 2 } = [ data_B ];

            data_C = double( data_C );
            for beh = 1 : 6
                if all( data_C( beh, : ) == median( data_C( beh, : ), 2, 'omitnan' ) )
                    data_C( beh, : ) = nan;
                end
            end; clear beh

            % -------------------------------------------------------------------------

            vars = struct;

            vars.N_inputs = [];
            for g0 = 1 : length( data )
                vars.N_inputs( 1, g0 ) = size( data{ 1, g0 }, 1 );
            end; clear g0

            vars.T_length = ( 2 ^ ( k + 0 ) ) * [ 1 ] + 1;
            vars.N_units = 64 * ones( 1, length( vars.T_length ) );

            vars.V_from_inputs = [ [ 1 ]; [ 1 ] ];% ( from, to ), 1 (if exist) or 0 (otherwise).
            vars.V_between_G = [ [ 0 ] ];% ( from, to ), 1 (if exist) or 0 (otherwise).
            vars.V_to_outputs = [ [ 1, 1 ] ];% ( from, to ), 1 (if exist) or 0 (otherwise).

            vars.W_from_inputs = [ [ 1 ]; [ 1 ] ];% ( from, to ), >= 0.
            vars.W_between_G = [ [ 0 ] ];% ( from, to ), >= 0.
            vars.W_to_outputs = [ [ 1, 1 ] ];% ( from, to ), >= 0.

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
            for iter = 1 : 16
                [ vars, act_G, act_F, ~, ~ ] = AG1_process( vars, data );
                eval_G_F = [];
                for g = 1 : length( vars.T_length )
                    eval_G_F( g, : ) = sqrt( mean( ( act_G{ 1, g } - act_F{ 1, g } ) .^ 2, 1 ) );
                end; clear g
                mean_eval_G_F = [ mean_eval_G_F, mean( eval_G_F, 2 ) ];
            end; clear iter
            toc

            vars.learning = 'off';

            tic
            [ vars, act_G, act_F, rec_G, rec_F ] = AG1_process( vars, data );
            eval_G_F = [];
            for g = 1 : length( vars.T_length )
                eval_G_F( g, : ) = sqrt( mean( ( act_G{ 1, g } - act_F{ 1, g } ) .^ 2, 1 ) );
            end; clear g
            mean_eval_G_F = [ mean_eval_G_F, mean( eval_G_F, 2 ) ];
            toc

            % -------------------------------------------------------------------------

            learning_assign = data_C;

            % -------------------------------------------------------------------------

            t_data = data{ 1, 1 };

            % -------------------------------------------------------------------------

            acc_data1 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_data1( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_data1( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats

            % -------------------------------------------------------------------------

            t_data = data{ 1, 2 };

            % -------------------------------------------------------------------------

            acc_data2 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_data2( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_data2( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats

            % -------------------------------------------------------------------------

            acc_act = {};
            for g = 1 : length( vars.T_length )
                t_data = act_G{ 1, g };
                for beh = 1 : 6
                    if ~all( isnan( learning_assign( beh, : ) ) )
                        [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                        acc_act{ 1, g }( beh, 1 ) = stats( 1 );% R-square
                    else
                        acc_act{ 1, g }( beh, 1 ) = nan;
                    end
                end; clear beh
            end; clear g
            acc_act_G = acc_act;
            clear stats

            % -------------------------------------------------------------------------

            acc_act = {};
            for g = 1 : length( vars.T_length )
                t_data = act_F{ 1, g };
                for beh = 1 : 6
                    if ~all( isnan( learning_assign( beh, : ) ) )
                        [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                        acc_act{ 1, g }( beh, 1 ) = stats( 1 );% R-square
                    else
                        acc_act{ 1, g }( beh, 1 ) = nan;
                    end
                end; clear beh
            end; clear g
            acc_act_F = acc_act;
            clear stats

            % -------------------------------------------------------------------------

            t_data = rec_G{ length( vars.T_length ), 1 };

            % -------------------------------------------------------------------------

            acc_rec_G1 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_rec_G1( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_rec_G1( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats

            % -------------------------------------------------------------------------

            t_data = rec_G{ length( vars.T_length ), 2 };

            % -------------------------------------------------------------------------

            acc_rec_G2 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_rec_G2( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_rec_G2( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats


            % -------------------------------------------------------------------------

            t_data = rec_F{ length( vars.T_length ), 1 };

            % -------------------------------------------------------------------------

            acc_rec_F1 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_rec_F1( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_rec_F1( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats

            % -------------------------------------------------------------------------

            t_data = rec_F{ length( vars.T_length ), 2 };

            % -------------------------------------------------------------------------

            acc_rec_F2 = [];
            for beh = 1 : 6
                if ~all( isnan( learning_assign( beh, : ) ) )
                    [ ~, ~, ~, ~, stats ] = regress( transpose( learning_assign( beh, : ) ), [ ones( size( t_data, 2 ), 1 ), transpose( t_data ) ] );
                    acc_rec_F2( beh, 1 ) = stats( 1 );% R-square
                else
                    acc_rec_F2( beh, 1 ) = nan;
                end
            end; clear beh
            clear stats

            % -------------------------------------------------------------------------

            % save( [ 'ALL_Results', fname( 8 : end - 4 ), '_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ], 'vars', 'act_G', 'act_F', 'rec_G', 'rec_F', 'acc_data', 'acc_act_G', 'acc_act_F', 'acc_rec_G', 'acc_rec_F', 'mean_eval_G_F' )
            % save( [ 'REC_Results', fname( 8 : end - 4 ), '_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ], 'rec_G', 'rec_F', 'acc_data', 'acc_act_G', 'acc_act_F', 'acc_rec_G', 'acc_rec_F', 'mean_eval_G_F' )
            save( [ 'Results_ExpRD', fname( 8 : end - 4 ), '_k', num2str( k ), '_iterr', num2str( iterr ), '.mat' ], 'acc_data1', 'acc_data2', 'acc_act_G', 'acc_act_F', 'acc_rec_G1', 'acc_rec_G2', 'acc_rec_F1', 'acc_rec_F2', 'mean_eval_G_F' )

            disp( [ num2str( fn ), ' / ', num2str( size( flist, 1 ) ) ] )

        end; clear fn

    end; clear k

end; clear iterr


%% Results
% clear
% flist = dir( [ 'Results_ExpRD_*_k1_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k2_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k3_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k4_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k5_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k6_iterr1.mat' ] );
% % flist = dir( [ 'Results_ExpRD_*_k7_iterr1.mat' ] );
% 
% mm_acc_data1 = nan( 6, size( flist, 1 ) );
% mm_acc_data2 = nan( 6, size( flist, 1 ) );
% mm_acc_act_G = nan( 6, size( flist, 1 ) );
% mm_acc_act_F = nan( 6, size( flist, 1 ) );
% mm_acc_rec_G1 = nan( 6, size( flist, 1 ) );
% mm_acc_rec_G2 = nan( 6, size( flist, 1 ) );
% mm_acc_rec_F1 = nan( 6, size( flist, 1 ) );
% mm_acc_rec_F2 = nan( 6, size( flist, 1 ) );
% mm_mean_eval_G_F = nan( 9, size( flist, 1 ) );
% 
% for fn = 1 : size( flist, 1 )
% 
%     fname = flist( fn, 1 ).name;
% 
%     load( fname )
% 
%     m_acc_data1 = [ mean( acc_data1, 2, 'omitnan' ) ];
%     m_acc_data2 = [ mean( acc_data2, 2, 'omitnan' ) ];
%     m_acc_act_G = [];
%     m_acc_act_F = [];
%     for g = 1 : 1
%         m_acc_act_G( :, g ) = mean( acc_act_G{ 1, g }, 2, 'omitnan' );
%         m_acc_act_F( :, g ) = mean( acc_act_F{ 1, g }, 2, 'omitnan' );
%     end; clear g
%     m_acc_rec_G1 = [ mean( acc_rec_G1, 2, 'omitnan' ) ];
%     m_acc_rec_G2 = [ mean( acc_rec_G2, 2, 'omitnan' ) ];
%     m_acc_rec_F1 = [ mean( acc_rec_F1, 2, 'omitnan' ) ];
%     m_acc_rec_F2 = [ mean( acc_rec_F2, 2, 'omitnan' ) ];
% 
%     mm_acc_data1( :, fn ) = m_acc_data1;
%     mm_acc_data2( :, fn ) = m_acc_data2;
%     mm_acc_act_G( :, fn ) = m_acc_act_G;
%     mm_acc_act_F( :, fn ) = m_acc_act_F;
%     mm_acc_rec_G1( :, fn ) = m_acc_rec_G1;
%     mm_acc_rec_G2( :, fn ) = m_acc_rec_G2;
%     mm_acc_rec_F1( :, fn ) = m_acc_rec_F1;
%     mm_acc_rec_F2( :, fn ) = m_acc_rec_F2;
%     mm_mean_eval_G_F( :, fn ) = mean_eval_G_F;
% 
% end; clear fn
% 
% m_mm_acc_data1 = median( mm_acc_data1, 2, 'omitnan' );
% m_mm_acc_data2 = median( mm_acc_data2, 2, 'omitnan' );
% m_mm_acc_act_G = median( mm_acc_act_G, 2, 'omitnan' );
% m_mm_acc_act_F = median( mm_acc_act_F, 2, 'omitnan' );
% m_mm_acc_rec_G1 = median( mm_acc_rec_G1, 2, 'omitnan' );
% m_mm_acc_rec_G2 = median( mm_acc_rec_G2, 2, 'omitnan' );
% m_mm_acc_rec_F1 = median( mm_acc_rec_F1, 2, 'omitnan' );
% m_mm_acc_rec_F2 = median( mm_acc_rec_F2, 2, 'omitnan' );
% m_mm_mean_eval_G_F = mean( mm_mean_eval_G_F, 2, 'omitnan' );
% 
% y_lim = [ 0.0, 1.0 ];
% 
% figure
% subplot( 1, 5, 1 )
% bar( [ squeeze( m_mm_acc_data1 ), squeeze( m_mm_acc_data2 ) ] )
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
% bar( [ squeeze( m_mm_acc_rec_G1 ), squeeze( m_mm_acc_rec_G2 ) ] )
% ylim( y_lim )
% title( [ 'rec_G' ] )
% subplot( 1, 5, 5 )
% bar( [ squeeze( m_mm_acc_rec_F1 ), squeeze( m_mm_acc_rec_F2 ) ] )
% ylim( y_lim )
% title( [ 'rec_F' ] )
% 
% figure
% bar( squeeze( m_mm_mean_eval_G_F ) )
% colorbar
% 
