import { Base } from "./base.model";
import { OrderedAddon } from "./ordered-addon.model";
import { OrderedOption } from "./ordered-option.model";
import { Product } from "./product.model";

export class OrderedProduct extends Base {
    productId:number;
    product:Product;
    orderedOptions:OrderedOption[];
    orderedAddons:OrderedAddon[];
}
