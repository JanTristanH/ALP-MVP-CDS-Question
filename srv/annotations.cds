using api from './kpi-service';


annotate api.SimpleTest with @(
    Aggregation.ApplySupported.PropertyRestrictions : true,
    Aggregation,
    UI                                              : {
        SelectionFields   : [createWeekNumber_db, ],
        LineItem          : [
            {Value : TRIP_ID},
            {Value : numberOfTrips},
            {Value : createWeekNumber_db},
        ],

         Facets                             : [{
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>Details}',
            Target : '@UI.FieldGroup#Details',
        }, ],
        FieldGroup #Details                : {Data : [
            {Value : TRIP_ID},
            {Value : numberOfTrips},
            {Value : createWeekNumber_db},

        ]},

        //Charts
        Chart #C1 : {
            ChartType           : #Column,
            Dimensions          : [createWeekNumber_db],
            DimensionAttributes : [{
                Dimension : createWeekNumber_db,
                Role      : #Category
            }],
            Measures            : [numberOfTrips],
            MeasureAttributes   : [{
                Measure : numberOfTrips,
                Role    : #Axis1
            }]
        },

        //Presentation Variants
        //Needed to use in visual filter definition
        PresentationVariant #PVNumberOfTripsByWeek         : {Visualizations : ['@UI.Chart#C1']},
    }
) {
    @Analytics.Measure   : true
    @Aggregation.default : #SUM
    numberOfTrips @(title : '{i18n>numberOfTrips}');

     @Common                          : {ValueList #VisualFilterNumberOfTripsByWeek : {
        $Type                        : 'Common.ValueListType',
        CollectionPath               : 'SimpleTest',
        PresentationVariantQualifier : 'PVNumberOfTripsByWeek',
        Parameters                   : [{
            $Type             : 'Common.ValueListParameterInOut',
            LocalDataProperty : 'createWeekNumber_db',
            ValueListProperty : 'createWeekNumber_db'
        }]
    }}
    @Analytics.Dimension : true
    createWeekNumber_db @(title : '{i18n>createWeekNumber}');//, ValueList.entity : 'createWeekNumberVH' );

    
};
