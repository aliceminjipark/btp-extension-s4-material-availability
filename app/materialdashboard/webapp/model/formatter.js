sap.ui.define([], function () {
    "use strict";

    return {

        /**
         * Rounds the number unit value to 2 digits
         * @public
         * @param {string} sValue the number string to be rounded
         * @returns {string} sValue with 2 digits rounded
         */
        numberUnit : function (sValue) {
            if (!sValue) {
                return "";
            }
            return parseFloat(sValue).toFixed(2);
        },

        getEnglishDescription: function (descriptions) {
            for(var i=0 ; i<descriptions.length; i++)
            {
                if(descriptions[i].Language == 'EN')
                {
                    return descriptions[i].Description;
                }
            }
            //for loop in descriptions.results until descriptions.results[i].Language === "EN" and return it
       }
    };

});