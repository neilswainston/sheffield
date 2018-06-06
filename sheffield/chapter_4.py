'''
Created on 6 Jun 2018

@author: neilswainston
'''
import sys
import cobra


def prelim_analysis(filename):
    model = _get_model(filename)

    # Fix glucose uptake to 1 and maximise:
    _fix_glucose_maximise(model, 1)
    _fix_glucose_maximise(model, 10)

    # Add mAb production to objective function and maximise:
    model.reactions.BIO029.objective_coefficient = 1
    _fix_glucose_maximise(model, 1)
    _fix_glucose_maximise(model, 10)


def _fix_glucose_maximise(model, glc_bound):
    '''Fix glucose uptake flux and maximise.'''
    # Fix glucose uptake to glc_bound:
    glc_transport = model.reactions.EF0001
    glc_transport.lower_bound = glc_bound
    glc_transport.upper_bound = glc_bound

    # Optimise:
    model.optimize()
    model.summary()


def _get_model(filename):
    '''Get "fresh" model.'''
    return cobra.io.read_sbml_model(filename)


def main(args):
    '''main method.'''
    filename = args[0]
    prelim_analysis(filename)


if __name__ == '__main__':
    main(sys.argv[1:])
