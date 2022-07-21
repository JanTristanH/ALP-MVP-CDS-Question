namespace idm.db;


entity TR_TRIPT {
    key TRIP_ID             : String(16);
        createWeekNumber_db : Integer64;
        CREATE_DATE         : String(8);
        numberOfTrips       : Integer default 1; // used for counting
}
