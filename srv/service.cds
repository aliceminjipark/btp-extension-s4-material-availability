using SalesOrderA2X as SalesOrdersSRV from './external/SalesOrderA2X';

using ProductMasterA2X as ProductSRV from './external/ProductMasterA2X';

using BasicProductAvailabilityInfo as BasicAvailabilitySrv from './external/BasicProductAvailabilityInfo.cds';

using Product as ProductSRVNew from './external/Product.cds';

extend ProductSRV.A_ProductPlant
{
    virtual AvailableQuantity : type of BasicAvailabilitySrv.AvailabilityRecord:AvailableQuantityInBaseUnit not null
        @sap.creatable : 'false'
        @sap.filterable : 'false'
        @sap.label : 'Available Quantity'
        @sap.sortable : 'false'
        @sap.unit : 'BaseUnit'
        @sap.updatable : 'false';
    virtual AvailableQuantityBaseUnit : type of BasicAvailabilitySrv.AvailabilityRecord:BaseUnit not null
        @sap.creatable : 'false'
        @sap.filterable : 'false'
        @sap.label : 'Unit'
        @sap.semantics : 'unit-of-measure'
        @sap.sortable : 'false'
        @sap.updatable : 'false';
}

@path : '/material-availability'
service MaterialAvailability
{
    annotate Product with @Capabilities.NavigationRestrictions : 
    {
        RestrictedProperties :
        [
            {
                $Type : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty : _ProductChangeMaster,
                InsertRestrictions :
                {
                    $Type : 'Capabilities.InsertRestrictionsType',
                    Insertable : true
                }
            },
            {
                $Type : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty : _ProductDescription,
                InsertRestrictions :
                {
                    $Type : 'Capabilities.InsertRestrictionsType',
                    Insertable : true
                }
            },
            {
                $Type : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty : _ProductEWMWarehouse,
                InsertRestrictions :
                {
                    $Type : 'Capabilities.InsertRestrictionsType',
                    Insertable : true
                }
            },
            {
                $Type : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty : _ProductPlant,
                InsertRestrictions :
                {
                    $Type : 'Capabilities.InsertRestrictionsType',
                    Insertable : true
                }
            },
            {
                $Type : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty : _ProductProcurement,
                InsertRestrictions :
                {
                    $Type : 'Capabilities.InsertRestrictionsType',
                    Insertable : true
                }
            },
            {
                $Type : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty : _ProductQualityManagement,
                InsertRestrictions :
                {
                    $Type : 'Capabilities.InsertRestrictionsType',
                    Insertable : true
                }
            },
            {
                $Type : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty : _ProductSales,
                InsertRestrictions :
                {
                    $Type : 'Capabilities.InsertRestrictionsType',
                    Insertable : true
                }
            },
            {
                $Type : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty : _ProductSalesDelivery,
                InsertRestrictions :
                {
                    $Type : 'Capabilities.InsertRestrictionsType',
                    Insertable : true
                }
            },
            {
                $Type : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty : _ProductStorage,
                InsertRestrictions :
                {
                    $Type : 'Capabilities.InsertRestrictionsType',
                    Insertable : true
                }
            },
            {
                $Type : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty : _ProductUnitOfMeasure,
                InsertRestrictions :
                {
                    $Type : 'Capabilities.InsertRestrictionsType',
                    Insertable : true
                }
            },
            {
                $Type : 'Capabilities.NavigationPropertyRestriction',
                NavigationProperty : _ProductValuation,
                InsertRestrictions :
                {
                    $Type : 'Capabilities.InsertRestrictionsType',
                    Insertable : true
                }
            }
        ]
    };

    @readonly
    entity SalesOrder as
        projection on SalesOrdersSRV.A_SalesOrderItem
        {
            key SalesOrder,
            key SalesOrderItem,
            SalesOrderItemText,
            Material,
            RequestedQuantity,
            RequestedQuantityUnit,
            SDDocReferenceStatus,
            ProductionPlant,
            OriginalPlant,
            StorageLocation,
            DeliveryPriority,
            DeliveryStatus,
            SDProcessStatus
        };

    @readonly
    entity Material as
        projection on ProductSRV.A_Product
        {
            Product as Material,
            ProductType,
            LastChangeDate,
            CountryOfOrigin,
            ProductGroup,
            ItemCategoryGroup,
            ProductHierarchy,
            ProductManufacturerNumber,
            to_Description,
            to_Plant
        };

    @readonly
    entity MaterialDescription as
        projection on ProductSRV.A_ProductDescription
        {
            key Product as Material,
            key Language,
            ProductDescription as Description
        };

    @readonly
    entity MaterialPlant as
        projection on ProductSRV.A_ProductPlant
        {
            key Product as Material,
            key Plant,
            MRPType,
            AvailabilityCheckType,
            to_PlantMRPArea,
            AvailableQuantity,
            AvailableQuantityBaseUnit
        };

    @readonly
    entity MaterialPlantMRPArea as
        projection on ProductSRV.A_ProductPlantMRPArea
        {
            *
        };

    function calcMaterialAvailability
    (
        material : String,
        plant : String
    )
    returns many BasicAvailabilitySrv.AvailabilityRecord;

    function calcMaterialAvailabilityAt
    (
        material : String,
        plant : String,
        timestamp : Timestamp
    )
    returns BasicAvailabilitySrv.AvailabilityRecord;

    entity Product as
        projection on ProductSRVNew.Product
        {
            Product,
            _ProductDescription
        };

    entity ProductDescription as
        projection on ProductSRVNew.ProductDescription;
}
