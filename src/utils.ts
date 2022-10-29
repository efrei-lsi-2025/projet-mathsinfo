import { Intergare } from "./types";

function getMetroColor(line: string) {
  switch (line) {
    case "1":
      return "#ffcd00";
    case "2":
      return "#003df5";
    case "3":
      return "#827a04";
    case "3bis":
      return "#71c5e8";
    case "4":
      return "#c800a1";
    case "5":
      return "#ff7f32";
    case "6":
      return "#71cc98";
    case "7":
      return "#f59bbb";
    case "7bis":
      return "#71cc98";
    case "8":
      return "#dd9cdf";
    case "9":
      return "#b5bd00";
    case "10":
      return "#c69214";
    case "11":
      return "#6e4c1e";
    case "12":
      return "#007a53";
    case "13":
      return "#71c5e8";
    case "14":
      return "#5f259f";
    case "15":
      return "#a50034";
    case "16":
      return "#f59bbb";
    case "17":
      return "#b5bd00";
    case "18":
      return "#00ab8e";
    default:
      return "#000";
  }
}

class UnionFindSet {
  private parent: number[] = [];
  private size = 0;

  constructor(size?: number) {
    this.size = size || 0;
    for (let i = 0; i < this.size; i++) {
      this.parent.push(i);
    }
  }

  makeSet(): number {
    this.parent.push(this.size);
    this.size++;
    return this.size - 1;
  }

  find(x: number): number {
    if (this.parent[x] !== x) {
      this.parent[x] = this.find(this.parent[x]);
      return this.parent[x];
    } else {
      return x;
    }
  }

  union(x: number, y: number): void {
    x = this.find(x);
    y = this.find(y);

    if (x === y) return;

    this.parent[y] = x;
  }
}

class KruskalSet {
  private position = new Map();
  private disjointSetArray = new UnionFindSet();
  private elements = [];

  makeSet(element) {
    if (this.position.has(element)) return;
    const index = this.disjointSetArray.makeSet();
    this.position.set(element, index);
    this.elements.push(element);
  }

  find(element) {
    const index = this.position.get(element);
    if (index === undefined) return;
    const p = this.disjointSetArray.find(index);
    return this.elements[p];
  }

  union(element1, element2) {
    const index1 = this.position.get(element1);
    const index2 = this.position.get(element2);
    if (index1 === undefined || index2 === undefined) return;

    this.disjointSetArray.union(index1, index2);
  }
}

export { getMetroColor, KruskalSet };