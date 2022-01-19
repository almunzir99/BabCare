import { Base } from "./base.model";
import { Image } from "./image.model";
import { AddOn } from "./add-on.model";
import { Option } from "./option.model";

export class Product extends Base {
    title: string;
    description: string;
    price: number;
    images: Image[];
    discount: number;
    options: Option[] = [];
    addOns: AddOn[] = [];
    categoryId:number;
    categoryName:string;
}
