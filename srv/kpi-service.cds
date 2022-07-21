using {idm.db as db} from '../db/denormalised-kpis';

service api {
    @readonly
    entity createWeekNumberVH as select from SimpleTest distinct {
        createWeekNumber
    };

@readonly
entity SimpleTest       as
        projection on db.TR_TRIPT as Headers
        {
            TRIP_ID,
            Headers.numberOfTrips,
            Headers.createWeekNumber_db,
                        strftime(
                '%W',
                //reorder Headers.CREATE_DATE to use week number function
                substring(
                    Headers.CREATE_DATE, 7, 4) || '-' || // year
                    substring(
                        Headers.CREATE_DATE, 4, 2) || '-' || // month
                        substring(
                            Headers.CREATE_DATE, 0, 3) // day
                        )                  as createWeekNumber    : Integer64,
        }

}