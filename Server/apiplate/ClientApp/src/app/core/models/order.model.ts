import { Branch } from "./branch.model";
import { Customer } from "./customer.model";
import { Delivery } from "./delivery.model";
import { OrderedProduct } from "./ordered-product.model";
import { Base } from "./base.model";
import { OrderStatus } from "./order-status.enum";

export class Order extends Base {
    customerId: number;
    customer: Customer;
    products: OrderedProduct[];
    branchId: number;
    branch: Branch;
    deliveryId: number;
    delivery: Delivery;
    lat: number;
    long: number;
    location: string;
    status: OrderStatus;
    isPaid: boolean;
    total: number;
}
