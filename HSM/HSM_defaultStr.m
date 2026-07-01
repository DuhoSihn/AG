function vars = HSM_defaultStr( vars )
% Defalut setup for "HSM_initialize.m"

L_inputs = length( vars.N_inputs );

vars.L_hierarchy = 3;% the length of hierarchy, scalar.
vars.L_sub_hierarchy = 2;% the length of sub-hierarchy which divides connectivities between modalities, scalar.
vars.N_modules = L_inputs * 16;% the number of modules in each hiercarchy, scalar.
vars.N_units = 16;% the number of units in each module, scalar.
vars.C_bottom_up = 2 * ones( 1, L_inputs );% coefficients (strength) of bottom-up pathway, (1) X (N), where N represent the number of modality.
vars.C_top_down = 0.25 * ones( 1, L_inputs );% coefficients (strength) of top-down pathway, (1) X (N), where N represent the number of modality.
vars.L_memory = 8 * [ 1, 2, 3 ];% the length of memorized activities for each hierarchy, (1) X (vars.L_hierarchy).
