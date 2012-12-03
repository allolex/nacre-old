# The Order Service

## Base URI

/order-search

## Columns

orderId            | The Id of the Order. Can be used to retrive all order information usinge Order Get.
orderTypeId        | The Id of the Order Type. See report reference data for description.
contactId          | The ID of the Contact. Can be used to recover all information about a contact by issuing a Contact GET.
orderStatusId      | The Id of the Order status. Description can be found in the report reference data.
orderStockStatusId | The ID of the Order stock status. Description can be found in the report reference data.
createdOn          | The date the Order was created.
createdById        | The ID of the Staff member who created this order.

## Filters

Name                | Sortable | Data type
placedOn            | true     | PERIOD
deliveryDate        | true     | PERIOD
shippingMethodId    | true     | INTEGER
staffOwnerContactId | true     | INTEGER
projectId           | true     | INTEGER
departmentId        | true     | INTEGER
leadSourceId        | true     | INTEGER

## Usage

placedOn            | The date the order was placed.
deliveryDate        | The date the delivery is set for.
shippingMethodId    | The ID of the Shipping Method.
staffOwnerContactId | The ID of the Staff member who owns the Order.
projectId           | The ID of the project the Order is associated with.
departmentId        | The ID of the department the Order is associated with.
leadSourceId        | The ID of the lead source the Order is associated with.

