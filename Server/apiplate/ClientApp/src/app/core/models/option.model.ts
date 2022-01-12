import { Base } from "./base.model";
import { OptionValue } from "./option-value.model";

export class Option extends Base {
    title: string;
    values: OptionValue[];
}
