function [ vars, act_G, act_F, rec_G, rec_F ] = AG1_process( vars, data )
% process, Associative Generators, Recurrent
%
% data : input data, (1) X (m) cells, (channel) X (time) form for each cell.
%
% act : activities, (1) X (n) cells, (unit) X (time) form for each cell.

N_inputs = length( vars.N_inputs );
N_generators = length( vars.T_length );
T1_length = vars.T_length - 1;
L_data = size( data{ 1, 1 }, 2 );

% -------------------------------------------------------------------------

% vars.W_from_inputs = gpuArray( vars.W_from_inputs );
% vars.W_between_G = gpuArray( vars.W_between_G );
% 
% vars.C_modulation = gpuArray( vars.C_modulation );
% vars.C_learning_rate = gpuArray( vars.C_learning_rate );
% vars.C_learning_threshold = gpuArray( vars.C_learning_threshold );
% 
% for g = 1 : N_generators
%     vars.W_G{ 1, g } = gpuArray( vars.W_G{ 1, g } );
%     vars.X_memory{ 1, g } = gpuArray( vars.X_memory{ 1, g } );
%     vars.X_G{ 1, g } = gpuArray( vars.X_G{ 1, g } );
%     vars.X_F{ 1, g } = gpuArray( vars.X_F{ 1, g } );
% end
% 
% for g = 1 : N_generators
%     for g0 = 1 : N_inputs
%         vars.Y_G{ g, g0 } = gpuArray( vars.Y_G{ g, g0 } );
%         vars.Y_F{ g, g0 } = gpuArray( vars.Y_F{ g, g0 } );
%     end
% end
% 
% for g1 = 1 : N_generators
%     for g = 1 : N_generators
%         vars.W_F{ g1, g } = gpuArray( vars.W_F{ g1, g } );
%     end
% end
% 
% for g0 = 1 : N_inputs
%     for g = 1 : N_generators
%         vars.W_F_inputs{ g0, g } = gpuArray( vars.W_F_inputs{ g0, g } );
%     end
% end
% 
% for g = 1 : N_generators
%     for g0 = 1 : N_inputs
%         vars.W_F_outputs_G{ g, g0 } = gpuArray( vars.W_F_outputs_G{ g, g0 } );
%         vars.W_F_outputs_F{ g, g0 } = gpuArray( vars.W_F_outputs_F{ g, g0 } );
%     end
% end

% -------------------------------------------------------------------------

act_G = cell( 1, N_generators );
act_F = cell( 1, N_generators );
for g = 1 : N_generators
    act_G{ 1, g } = ones( vars.N_units( g ), L_data );
    act_F{ 1, g } = ones( vars.N_units( g ), L_data );
    %     act_G{ 1, g } = ones( vars.N_units( g ), L_data, 'gpuArray' );
    %     act_F{ 1, g } = ones( vars.N_units( g ), L_data, 'gpuArray' );
end

rec_G = cell( N_generators, N_inputs );
rec_F = cell( N_generators, N_inputs );
for g = 1 : N_generators
    for g0 = 1 : N_inputs
        if vars.V_to_outputs( g, g0 ) == 1
            rec_G{ g, g0 } = ones( vars.N_inputs( g0 ), L_data );
            rec_F{ g, g0 } = ones( vars.N_inputs( g0 ), L_data );
            %     rec_G{ g, g0 } = ones( vars.N_inputs( g0 ), L_data, 'gpuArray' );
            %     rec_F{ g, g0 } = ones( vars.N_inputs( g0 ), L_data, 'gpuArray' );
        end
    end
end

% -------------------------------------------------------------------------

for t = 1 : L_data

    % ---------------------------------------------------------------------

    %     vars.W_from_inputs = vars.W_from_inputs ./ sum( vars.W_from_inputs, 1 );
    %
    %     vars.W_between_G( repmat( sum( vars.W_from_inputs, 1 ) > 0, [ N_generators, 1 ] ) ) = 0;
    %     vars.W_between_G = vars.W_between_G ./ sum( vars.W_between_G, 1 );

    % ---------------------------------------------------------------------
    % process, generator

    for g = 1 : N_generators
        % weighted sum
        X = mean( vars.W_G{ 1, g } .* transpose( vars.X_memory{ 1, g } ), 2, 'omitnan' );
        % applying VCAF
        X = log( X );
        X = X - mean( X, 1, 'omitnan' );
        b = mean( abs( X ), 1, 'omitnan' );
        X = ( vars.C_modulation ./ b ) .* X;
        X = exp( X );
        X = X / mean( X, 1, 'omitnan' );
        vars.X_G{ 1, g } = X;
    end

    % ---------------------------------------------------------------------
    % process, transfomation

    X_F = cell( N_generators, N_generators );
    for g1 = 1 : N_generators
        for g = 1 : N_generators
            if vars.V_between_G( g1, g ) == 1
                % weighted sum
                X = mean( vars.W_F{ g1, g } .* ( ( vars.C_output_type( 1, g1 ) .* transpose( vars.X_G{ 1, g1 } ) ) + ( ( 1 - vars.C_output_type( 1, g1 ) ) .* transpose( vars.X_memory{ 1, g1 }( 1 : vars.N_units( g1 ) ) ) ) ), 2, 'omitnan' );
                X_F{ g1, g } = X;
            end
        end
    end

    X_F_input = cell( N_inputs, N_generators );
    for g0 = 1 : N_inputs
        for g = 1 : N_generators
            if vars.V_from_inputs( g0, g ) == 1
                % weighted sum
                X = mean( vars.W_F_inputs{ g0, g } .* transpose( data{ 1, g0 }( :, t ) ), 2, 'omitnan' );
                X_F_input{ g0, g } = X;
            end
        end
    end

    for g = 1 : N_generators
        % gathering all inputs
        X = zeros( vars.N_units( g ), 1 );
        % X = zeros( vars.N_units( g ), 1, 'gpuArray' );
        for g0 = 1 : N_inputs
            if vars.V_from_inputs( g0, g ) == 1
                X = X + vars.W_from_inputs( g0, g ) .* X_F_input{ g0, g };
            end
        end
        for g1 = 1 : N_generators
            if vars.V_between_G( g1, g ) == 1
                X = X + vars.W_between_G( g1, g ) .* X_F{ g1, g };
            end
        end
        % applying VCAF
        X = log( X );
        X = X - mean( X, 1, 'omitnan' );
        b = mean( abs( X ), 1, 'omitnan' );
        X = ( vars.C_modulation ./ b ) .* X;
        X = exp( X );
        X = X / mean( X, 1, 'omitnan' );
        vars.X_F{ 1, g } = X;
    end

    % ---------------------------------------------------------------------
    % process, output

    for g = 1 : N_generators
        for g0 = 1 : N_inputs
            if vars.V_to_outputs( g, g0 ) == 1

                % weighted sum
                X = mean( vars.W_F_outputs_G{ g, g0 } .* transpose( vars.X_G{ 1, g } ), 2, 'omitnan' );
                % applying VCAF
                X = log( X );
                X = X - mean( X, 1, 'omitnan' );
                b = mean( abs( X ), 1, 'omitnan' );
                X = ( vars.C_modulation ./ b ) .* X;
                X = exp( X );
                X = X / mean( X, 1, 'omitnan' );
                vars.Y_G{ g, g0 } = X;

                % weighted sum
                X = mean( vars.W_F_outputs_F{ g, g0 } .* transpose( vars.X_F{ 1, g } ), 2, 'omitnan' );
                % applying VCAF
                X = log( X );
                X = X - mean( X, 1, 'omitnan' );
                b = mean( abs( X ), 1, 'omitnan' );
                X = ( vars.C_modulation ./ b ) .* X;
                X = exp( X );
                X = X / mean( X, 1, 'omitnan' );
                vars.Y_F{ g, g0 } = X;

            end
        end
    end

    % ---------------------------------------------------------------------

    for g = 1 : N_generators
        act_G{ 1, g }( :, t ) = vars.X_G{ 1, g };
        act_F{ 1, g }( :, t ) = vars.X_F{ 1, g };
    end

    for g = 1 : N_generators
        for g0 = 1 : N_inputs
            if vars.V_to_outputs( g, g0 ) == 1
                rec_G{ g, g0 }( :, t ) = vars.Y_G{ g, g0 };
                rec_F{ g, g0 }( :, t ) = vars.Y_F{ g, g0 };
            end
        end
    end

    % ---------------------------------------------------------------------
    % learning

    if strcmpi( vars.learning, 'on' ) || ( strcmpi( vars.learning, 'assign' ) && vars.learning_assign( t ) == 1 )

        % learning, generator
        for g = 1 : N_generators

            % scattered Hebbian learning
            Xmemory = vars.X_memory{ 1, g };
            XF = vars.X_F{ 1, g };

            X_scatter_mean = mean( reshape( Xmemory, [ vars.N_units( g ), T1_length( g ) ] ), 2, 'omitnan' );
            [ ~, sort_idx_mean ] = sort( X_scatter_mean );
            idx_XF = find( XF >= vars.C_learning_threshold );
            N_active = length( idx_XF );
            N_scatter = round( vars.C_learning_scatter_ratio * N_active );
            sort_idx_member = sort_idx_mean( ~all( sort_idx_mean ~= transpose( idx_XF ), 2 ) );
            sort_idx_remainder = sort_idx_mean( all( sort_idx_mean ~= transpose( idx_XF ), 2 ) );
            idx_XF = [ sort_idx_member( 1 : N_active - N_scatter, 1 ); sort_idx_remainder( 1 : N_scatter, 1 ) ];

            idxL_Xmemory = Xmemory < vars.C_learning_threshold;
            % idxL_XF = XF < vars.C_learning_threshold;
            idxL_XF = all( transpose( [ 1 : vars.N_units( g ) ] ) ~= transpose( idx_XF ), 2 );

            Xmemory( idxL_Xmemory ) = 0;
            XF( idxL_XF ) = 0;

            Xmemory( ~idxL_Xmemory ) = 1;
            XF( ~idxL_XF ) = 1;

            Xmemory = sqrt( Xmemory );
            XF = sqrt( XF );

            vars.W_G{ 1, g } = vars.W_G{ 1, g } + vars.C_learning_rate .* ( XF .* transpose( Xmemory ) );

            vars.W_G{ 1, g } = vars.W_G{ 1, g } ./ mean( vars.W_G{ 1, g }, 2 );
            vars.W_G{ 1, g } = vars.W_G{ 1, g } ./ mean( vars.W_G{ 1, g }, 1 );

        end

        % learning, transformation
        for g1 = 1 : N_generators
            for g = 1 : N_generators
                if vars.V_between_G( g1, g ) == 1

                    % vanilla Hebbian learning
                    XG1 = ( ( vars.C_output_type( 1, g1 ) .* vars.X_G{ 1, g1 } ) + ( ( 1 - vars.C_output_type( 1, g1 ) ) .* vars.X_memory{ 1, g1 }( 1 : vars.N_units( g1 ) ) ) );
                    XG = vars.X_G{ 1, g };

                    idxL_XG1 = XG1 < vars.C_learning_threshold;
                    idxL_XG = XG < vars.C_learning_threshold;

                    XG1( idxL_XG1 ) = 0;
                    XG( idxL_XG ) = 0;

                    XG1( ~idxL_XG1 ) = 1;
                    XG( ~idxL_XG ) = 1;

                    XG1 = sqrt( XG1 );
                    XG = sqrt( XG );

                    vars.W_F{ g1, g } = vars.W_F{ g1, g } + vars.C_learning_rate .* ( XG .* transpose( XG1 ) );

                    vars.W_F{ g1, g } = vars.W_F{ g1, g } ./ mean( vars.W_F{ g1, g }, 2 );
                    vars.W_F{ g1, g } = vars.W_F{ g1, g } ./ mean( vars.W_F{ g1, g }, 1 );

                end
            end
        end

        % learning, transformation from inputs
        for g0 = 1 : N_inputs
            for g = 1 : N_generators
                if vars.V_from_inputs( g0, g ) == 1

                    % vanilla Hebbian learning
                    XG1 = data{ 1, g0 }( :, t );
                    XG = vars.X_G{ 1, g };

                    idxL_XG = XG < vars.C_learning_threshold;

                    XG( idxL_XG ) = 0;

                    XG( ~idxL_XG ) = 1;

                    XG1 = sqrt( XG1 );
                    XG = sqrt( XG );

                    vars.W_F_inputs{ g0, g } = vars.W_F_inputs{ g0, g } + vars.C_learning_rate .* ( XG .* transpose( XG1 ) );

                    vars.W_F_inputs{ g0, g } = vars.W_F_inputs{ g0, g } ./ mean( vars.W_F_inputs{ g0, g }, 2 );
                    vars.W_F_inputs{ g0, g } = vars.W_F_inputs{ g0, g } ./ mean( vars.W_F_inputs{ g0, g }, 1 );

                end
            end
        end

        % learning, transformation to outputs
        for g = 1 : N_generators
            for g0 = 1 : N_inputs
                if vars.V_to_outputs( g, g0 ) == 1

                    % vanilla Hebbian learning
                    XG = vars.X_G{ 1, g };
                    XF = vars.X_F{ 1, g };
                    XG1 = data{ 1, g0 }( :, t );

                    idxL_XG = XG < vars.C_learning_threshold;
                    idxL_XF = XF < vars.C_learning_threshold;

                    XG( idxL_XG ) = 0;
                    XF( idxL_XF ) = 0;

                    XG( ~idxL_XG ) = 1;
                    XF( ~idxL_XF ) = 1;

                    XG = sqrt( XG );
                    XF = sqrt( XF );

                    vars.W_F_outputs_G{ g, g0 } = vars.W_F_outputs_G{ g, g0 } + vars.C_learning_rate .* ( XG1 .* transpose( XG ) );
                    vars.W_F_outputs_F{ g, g0 } = vars.W_F_outputs_F{ g, g0 } + vars.C_learning_rate .* ( XG1 .* transpose( XF ) );

                    vars.W_F_outputs_G{ g, g0 } = vars.W_F_outputs_G{ g, g0 } ./ mean( vars.W_F_outputs_G{ g, g0 }, 2 );
                    vars.W_F_outputs_G{ g, g0 } = vars.W_F_outputs_G{ g, g0 } ./ mean( vars.W_F_outputs_G{ g, g0 }, 1 );

                    vars.W_F_outputs_F{ g, g0 } = vars.W_F_outputs_F{ g, g0 } ./ mean( vars.W_F_outputs_F{ g, g0 }, 2 );
                    vars.W_F_outputs_F{ g, g0 } = vars.W_F_outputs_F{ g, g0 } ./ mean( vars.W_F_outputs_F{ g, g0 }, 1 );

                end
            end
        end

    end

    % ---------------------------------------------------------------------
    % update, memory

    for g = 1 : N_generators
        vars.X_memory{ 1, g } = [ vars.X_F{ 1, g }; vars.X_memory{ 1, g }( 1 : end - vars.N_units( g ) ) ];
    end

end

% -------------------------------------------------------------------------

% vars.W_from_inputs = gather( vars.W_from_inputs );
% vars.W_between_G = gather( vars.W_between_G );
%
% vars.C_modulation = gather( vars.C_modulation );
% vars.C_learning_rate = gather( vars.C_learning_rate );
% vars.C_learning_threshold = gather( vars.C_learning_threshold );
%
% for g = 1 : N_generators
%     vars.W_G{ 1, g } = gather( vars.W_G{ 1, g } );
%     vars.X_memory{ 1, g } = gather( vars.X_memory{ 1, g } );
%     vars.X_G{ 1, g } = gather( vars.X_G{ 1, g } );
%     vars.X_F{ 1, g } = gather( vars.X_F{ 1, g } );
% end
% 
% for g = 1 : N_generators
%     for g0 = 1 : N_inputs
%         vars.Y_G{ g, g0 } = gather( vars.Y_G{ g, g0 } );
%         vars.Y_F{ g, g0 } = gather( vars.Y_F{ g, g0 } );
%     end
% end
%
% for g1 = 1 : N_generators
%     for g = 1 : N_generators
%         vars.W_F{ g1, g } = gather( vars.W_F{ g1, g } );
%     end
% end
%
% for g0 = 1 : N_inputs
%     for g = 1 : N_generators
%         vars.W_F_inputs{ g0, g } = gather( vars.W_F_inputs{ g0, g } );
%     end
% end
% 
% for g = 1 : N_generators
%     for g0 = 1 : N_inputs
%         vars.W_F_outputs_G{ g, g0 } = gather( vars.W_F_outputs_G{ g, g0 } );
%         vars.W_F_outputs_F{ g, g0 } = gather( vars.W_F_outputs_F{ g, g0 } );
%     end
% end
%
% for g = 1 : N_generators
%     act_G{ 1, g } = gather( act_G{ 1, g } );
%     act_F{ 1, g } = gather( act_F{ 1, g } );
% end
% 
% for g = 1 : N_generators
%     for g0 = 1 : N_inputs
%         rec_G{ g, g0 } = gather( rec_G{ g, g0 } );
%         rec_F{ g, g0 } = gather( rec_F{ g, g0 } );
%     end
% end
