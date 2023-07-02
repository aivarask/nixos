<script lang="ts">
  type Person = {
    name: string;
    age: number;
  };
  export const items: any | Person[] = [
    {
      name: "Alice",
      age: 25,
    },
    { name: "Bob", age: 25 },
    [],
  ];
</script>

<div>
  <h1>Head</h1>
  <div>
    <table class="hover" title="Persons table">
      {#each items as item, i}
        <tr>
          <td>{item.name}</td>
          <td>{item.age}</td>
          <td>{i}</td>
        </tr>
      {/each}
    </table>
  </div>
</div>
