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

export class KruskalSet {
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
