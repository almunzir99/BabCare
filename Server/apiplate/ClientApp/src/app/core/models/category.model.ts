import { Base } from "./base.model";
import {Image} from "./image.model";
import { Offer } from "./offer.model";
import { Product } from "./product.model";
export class Category extends Base{
    title:string;
    image:Image;
    products:Product[];
    offerId:number;
    offer:Offer;
}
