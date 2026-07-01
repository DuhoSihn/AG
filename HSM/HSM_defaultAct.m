function vars = HSM_defaultAct( vars )
% Defalut setup for "HSM_process.m" (or "HSM_process_GPU.m")

vars.C_activation = 1 * [ 1 : vars.L_hierarchy ] ./ vars.L_hierarchy;% coefficients of activation functions for each hierarchy, (1) X (vars.L_hierarchy).
vars.C_activation_input = 0.5;% coefficients of activation functions for input hierarchy, scalar.
vars.C_activation_threshold = 2;% coefficients of activation threshold, scalar.
vars.L_adaptation_unit = 2 * vars.L_memory;% the range of activity adaptation for each hierarchy, (1) X (vars.L_hierarchy).
vars.C_adaptation_unit = [ 2, 0.25 ];% coefficients of adaptation parameters [ threshold, probability ], (1) X (2), where activities exceed the "threshold" will be candidates for adaptation and where if the ratio of candidates for adaptation exceed the "probability", then the adaptation mode is "on".
vars.L_adaptation_module = 4 * vars.L_memory;% the range of activity adaptation for each hierarchy, (1) X (vars.L_hierarchy).
vars.C_adaptation_module = [ 1, 0.5 ];% coefficients of adaptation parameters [ threshold, probability ], (1) X (2), where activities exceed the "threshold" will be candidates for adaptation and where if the ratio of candidates for adaptation exceed the "probability", then the adaptation mode is "on".
vars.L_recurrent_unit = 1 * ones( 1, vars.L_hierarchy );% the length of recurrent activities for each hierarchy, (1) X (vars.L_hierarchy).
vars.C_recurrent_unit = 0.5;% coefficient of recurrent ratio, in [ 0, 1 ] where a large value indicates a strong recurrence, scalar.
vars.L_recurrent_module = 1 * ones( 1, vars.L_hierarchy );% the length of recurrent activities for each hierarchy, (1) X (vars.L_hierarchy).
vars.C_recurrent_module = 0.5;% coefficient of recurrent ratio, in [ 0, 1 ] where a large value indicates a strong recurrence, scalar.
vars.learning = 'off';% 'on', 'off', or 'assign'.
vars.learning_assign = [];% assign learning or not for each time point if vars.learning = 'assign', (1) X size( data, 2 ), 1 := learing 'on', 0 := learning 'off'.
vars.learning_threshold = 3;% activity threshold will be used in learning, scalar.
vars.learning_rate = ( 10 .^ ( -4 ) ) .* ( ( vars.N_modules .* vars.N_units ) .^ ( -1 ) );% learning rate, scalar.
vars.learning_scaling = 10 * max( vars.L_memory );% synaptic scaling cycle, scalar.
vars.learning_stereotyped = [ 1.5, 1 / vars.learning_scaling ];% parameters to prevent stereotyped behavior [ threshold, re-scaling factor ], (1) X (2).
