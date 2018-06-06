'''
Sheffield
'''
import sys

import cobra
from cobra.flux_analysis import flux_variability_analysis


def prelim_analysis(filename):
    model = _get_model(filename)

    # Fix glucose uptake to 0, 1, 10 and maximise:
    _fix_glucose_maximise(model, 0, 'Max biomass, glc_uptake = 0')
    _fix_glucose_maximise(model, 1, 'Max biomass, glc_uptake = 1')
    _fix_glucose_maximise(model, 10, 'Max biomass, glc_uptake = 10')

    # Add mAb production to objective function and maximise:
    model.reactions.BIO029.objective_coefficient = 1
    _fix_glucose_maximise(model, 0, 'Max biomass and mAb, glc_uptake = 0')
    _fix_glucose_maximise(model, 1, 'Max biomass and mAb, glc_uptake = 1')
    _fix_glucose_maximise(model, 10, 'Max biomass and mAb, glc_uptake = 10')

    # Print components required for biomass and mAb production:
    _print_reaction(model, 'BIO028')
    _print_reaction(model, 'BIO029')


def blocked_reactions(filename):
    model = _get_model(filename)

    # Perform FVA:
    _perform_fva(model)

    # Delete formaldehyde transport reactions and maximise:
    _delete_reactions(model, ['EF0032', 'R00602', 'R00610', 'R00611_mt',
                              'R01565_mt', 'R07937'])
    _fix_glucose_maximise(model, 1, 'Max biomass, glc_uptake = 1, ' +
                          'formaldehyde transport ko')

    # Delete ethanolamine transport reaction and maximise:
    model = _get_model(filename)
    _delete_reactions(model, ['EF0035'])
    _fix_glucose_maximise(model, 1, 'Max biomass, glc_uptake = 1, ' +
                          'ethanolamine transport ko')

    # Delete NADH transport reaction and maximise:
    model = _get_model(filename)
    _delete_reactions(model, ['EF0037'])
    _fix_glucose_maximise(model, 1, 'Max biomass, glc_uptake = 1, ' +
                          'NADH transport ko')

    # Fix reversibility of alanine, glutamate transport and maximise:
    model = _get_model(filename)
    _set_bounds(model, ['EF0006', 'EF0010'], -1000, 0)
    _fix_glucose_maximise(model, 1, 'Max biomass, glc_uptake = 1, ' +
                          'Fix alanine and glutamate transport')

    # Investigate the roll of charged tRNA in biomass production:
    model = _get_model(filename)
    _fix_glucose_maximise(model, 1, None, print_result=False)

    print 'Roll of L-Aspartyl-tRNA(Asn) in biomass production'
    model.metabolites.C06113.summary(names=False)
    print
    print 'R03647\t' + model.reactions.R03647.build_reaction_string(
        use_metabolite_names=True)
    print

    print 'Roll of L-Glutamyl-tRNA(Gln) in biomass production'
    model.metabolites.C06112.summary(names=False)
    print
    print 'R03651\t' + model.reactions.R03651.build_reaction_string(
        use_metabolite_names=True)
    print


def _fix_glucose_maximise(model, glc_bound, title,
                          names=True, print_result=True):
    '''Fix glucose uptake flux and maximise.'''
    # Fix glucose uptake to glc_bound:
    glc_transport = model.reactions.EF0001
    glc_transport.lower_bound = glc_bound
    glc_transport.upper_bound = glc_bound

    # Optimise:
    solution = model.optimize()

    if print_result:
        # Print result:
        print title
        model.summary(names=names)
        print

        solution.fluxes.to_csv(title + '.csv')


def _print_reaction(model, reaction_id):
    rct = model.reactions.get_by_id(reaction_id)

    print '\t'.join([rct.id, rct.name,
                     rct.build_reaction_string(use_metabolite_names=True)]) + \
        '\n'


def _perform_fva(model):
    '''Perform FVA.'''
    flux_var = flux_variability_analysis(model, model.reactions)
    blocked = flux_var.loc[(abs(flux_var['minimum']) < 1e-6) &
                           (abs(flux_var['maximum']) < 1e-6)]

    print 'Blocked: %d/%d\n' % (len(blocked), len(flux_var))

    flux_var.to_csv('flux_var.csv')
    blocked.to_csv('blocked.csv')


def _delete_reactions(model, reaction_ids):
    for reaction_id in reaction_ids:
        model.reactions.get_by_id(reaction_id).knock_out()


def _set_bounds(model, reaction_ids, lower_bound, upper_bound):
    for reaction_id in reaction_ids:
        rct = model.reactions.get_by_id(reaction_id)
        rct.lower_bound = lower_bound
        rct.upper_bound = upper_bound


def _get_model(filename):
    '''Get "fresh" model.'''
    model = cobra.io.read_sbml_model(filename)
    model.reactions.BIO028.objective_coefficient = 1
    return model


def main(args):
    '''main method.'''
    filename = args[0]

    prelim_analysis(filename)
    blocked_reactions(filename)


if __name__ == '__main__':
    main(sys.argv[1:])
