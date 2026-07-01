function vars = AG1_initialize( vars )
% initialize, Associative Generators, Recurrent

N_inputs = length( vars.N_inputs );
N_generators = length( vars.T_length );
T1_length = vars.T_length - 1;

vars.W_G = cell( 1, N_generators );
for g = 1 : N_generators
    vars.W_G{ 1, g } = rand( vars.N_units( g ), vars.N_units( g ) * T1_length( g ) );% ( to, from )
    vars.W_G{ 1, g } = vars.W_G{ 1, g } ./ mean( vars.W_G{ 1, g }, 2 );
    vars.W_G{ 1, g } = vars.W_G{ 1, g } ./ mean( vars.W_G{ 1, g }, 1 );
end

vars.W_F = cell( N_generators, N_generators );
for g1 = 1 : N_generators
    for g = 1 : N_generators
        if vars.V_between_G( g1, g ) == 1
            vars.W_F{ g1, g } = rand( vars.N_units( g ), vars.N_units( g1 ) );% ( to, from )
            vars.W_F{ g1, g } = vars.W_F{ g1, g } ./ mean( vars.W_F{ g1, g }, 2 );
            vars.W_F{ g1, g } = vars.W_F{ g1, g } ./ mean( vars.W_F{ g1, g }, 1 );
        end
    end
end

vars.W_F_inputs = cell( N_inputs, N_generators );
for g0 = 1 : N_inputs
    for g = 1 : N_generators
        if vars.V_from_inputs( g0, g ) == 1
            vars.W_F_inputs{ g0, g } = rand( vars.N_units( g ), vars.N_inputs( g0 ) );% ( to, from )
            vars.W_F_inputs{ g0, g } = vars.W_F_inputs{ g0, g } ./ mean( vars.W_F_inputs{ g0, g }, 2 );
            vars.W_F_inputs{ g0, g } = vars.W_F_inputs{ g0, g } ./ mean( vars.W_F_inputs{ g0, g }, 1 );
        end
    end
end

vars.W_F_outputs_G = cell( N_generators, N_inputs );
vars.W_F_outputs_F = cell( N_generators, N_inputs );
for g = 1 : N_generators
    for g0 = 1 : N_inputs
        if vars.V_to_outputs( g, g0 ) == 1

            vars.W_F_outputs_G{ g, g0 } = rand( vars.N_inputs( g0 ), vars.N_units( g ) );% ( to, from )
            vars.W_F_outputs_G{ g, g0 } = vars.W_F_outputs_G{ g, g0 } ./ mean( vars.W_F_outputs_G{ g, g0 }, 2 );
            vars.W_F_outputs_G{ g, g0 } = vars.W_F_outputs_G{ g, g0 } ./ mean( vars.W_F_outputs_G{ g, g0 }, 1 );

            vars.W_F_outputs_F{ g, g0 } = rand( vars.N_inputs( g0 ), vars.N_units( g ) );% ( to, from )
            vars.W_F_outputs_F{ g, g0 } = vars.W_F_outputs_F{ g, g0 } ./ mean( vars.W_F_outputs_F{ g, g0 }, 2 );
            vars.W_F_outputs_F{ g, g0 } = vars.W_F_outputs_F{ g, g0 } ./ mean( vars.W_F_outputs_F{ g, g0 }, 1 );
            
        end
    end
end

vars.X_memory = cell( 1, N_generators );
vars.X_G = cell( 1, N_generators );
vars.X_F = cell( 1, N_generators );
for g = 1 : N_generators
    vars.X_memory{ 1, g } = ones( vars.N_units( g ) * T1_length( g ), 1 );
    vars.X_G{ 1, g } = ones( vars.N_units( g ), 1 );
    vars.X_F{ 1, g } = ones( vars.N_units( g ), 1 );
end

vars.Y_G = cell( N_generators, N_inputs );
vars.Y_F = cell( N_generators, N_inputs );
for g = 1 : N_generators
    for g0 = 1 : N_inputs
        if vars.V_to_outputs( g, g0 ) == 1
            vars.Y_G{ g, g0 } = ones( vars.N_inputs( g0 ), 1 );
            vars.Y_F{ g, g0 } = ones( vars.N_inputs( g0 ), 1 );
        end
    end
end
